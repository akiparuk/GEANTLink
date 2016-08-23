﻿/*
    Copyright 2015-2016 Amebis
    Copyright 2016 GÉANT

    This file is part of GÉANTLink.

    GÉANTLink is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    GÉANTLink is distributed in the hope that it will be useful, but
    WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with GÉANTLink. If not, see <http://www.gnu.org/licenses/>.
*/

#include "StdAfx.h"

using namespace std;
using namespace winstd;


//////////////////////////////////////////////////////////////////////
// eap::method_ttls
//////////////////////////////////////////////////////////////////////

eap::method_ttls::method_ttls(_In_ module &module, _In_ config_provider_list &cfg, _In_ credentials_ttls &cred) :
    m_cred(cred),
    m_version(version_0),
    method_tls(module, cfg, cred)
{
}


eap::method_ttls::method_ttls(_Inout_ method_ttls &&other) :
    m_cred(other.m_cred),
    m_version(std::move(other.m_version)),
    method_tls(std::move(other))
{
}


eap::method_ttls& eap::method_ttls::operator=(_Inout_ method_ttls &&other)
{
    if (this != std::addressof(other)) {
        (method_tls&)*this = std::move(other);
        m_version          = std::move(other.m_version);
    }

    return *this;
}


void eap::method_ttls::process_request_packet(
    _In_bytecount_(dwReceivedPacketSize) const EapPacket           *pReceivedPacket,
    _In_                                       DWORD               dwReceivedPacketSize,
    _Inout_                                    EapPeerMethodOutput *pEapOutput)
{
    if (pReceivedPacket->Code == EapCodeRequest && (pReceivedPacket->Data[1] & flags_start)) {
        // This is a start EAP-TTLS packet.

        // Determine minimum EAP-TTLS version supported by server and us.
        version_t ver_remote = (version_t)(pReceivedPacket->Data[1] & flags_ver_mask);
        m_version = std::min<version_t>(ver_remote, version_0);
        m_module.log_event(&EAPMETHOD_TTLS_HANDSHAKE_START, event_data((unsigned int)eap_type_ttls), event_data((unsigned char)m_version), event_data((unsigned char)ver_remote), event_data::blank);
    }

    // Do the TLS.
    method_tls::process_request_packet(pReceivedPacket, dwReceivedPacketSize, pEapOutput);
}


void eap::method_ttls::get_response_packet(
    _Inout_bytecap_(*dwSendPacketSize) EapPacket *pSendPacket,
    _Inout_                            DWORD     *pdwSendPacketSize)
{
    method_tls::get_response_packet(pSendPacket, pdwSendPacketSize);

    // Change packet type to EAP-TTLS, and add EAP-TTLS version.
    pSendPacket->Data[0]  = (BYTE)eap_type_ttls;
    pSendPacket->Data[1] &= ~flags_ver_mask;
    pSendPacket->Data[1] |= m_version;
}


void eap::method_ttls::get_result(
    _In_    EapPeerMethodResultReason reason,
    _Inout_ EapPeerMethodResult       *ppResult)
{
    if (m_phase != phase_application_data) {
        // Do the TLS.
        method_tls::get_result(reason, ppResult);
    } else {
        // The TLS finished, this is inner authentication's bussines.
        config_provider &cfg_prov(m_cfg.m_providers.front());
        config_method_ttls *cfg_method = dynamic_cast<config_method_ttls*>(cfg_prov.m_methods.front().get());
        assert(cfg_method);

        switch (reason) {
        case EapPeerMethodResultSuccess: {
            m_module.log_event(&EAPMETHOD_TTLS_INNER_SUCCESS, event_data((unsigned int)eap_type_ttls), event_data::blank);
            cfg_method->m_inner->m_auth_failed = false;
            break;
        }

        case EapPeerMethodResultFailure:
            m_module.log_event(&EAPMETHOD_TTLS_INNER_FAILURE, event_data((unsigned int)eap_type_ttls), event_data::blank);
            cfg_method->m_inner->m_auth_failed = true;
            break;

        default:
            throw win_runtime_error(ERROR_NOT_SUPPORTED, __FUNCTION__ " Not supported.");
        }

        // EAP-TTLS uses different label in PRF for MSK derivation than EAP-TLS.
        static const DWORD s_key_id = 0x01; // EAP-TTLSv0 Keying Material
        static const SecPkgContext_EapPrfInfo s_prf_info = { 0, sizeof(s_key_id), (PBYTE)&s_key_id };
        SECURITY_STATUS status = SetContextAttributes(m_sc_ctx, SECPKG_ATTR_EAP_PRF_INFO, (void*)&s_prf_info, sizeof(s_prf_info));
        if (FAILED(status))
            throw sec_runtime_error(status, __FUNCTION__ "Error setting EAP-TTLS PRF in Schannel.");

        // The TLS was OK.
        method_tls::get_result(EapPeerMethodResultSuccess, ppResult);

        // Do not report failure to EAPHost, as it will not save updated configuration then. But we need it to save it, to alert user on next connection attempt.
        // EAPHost is well aware of the failed condition.
        //if (reason == EapPeerMethodResultFailure) {
        //    ppResult->fIsSuccess = FALSE;
        //    ppResult->dwFailureReasonCode = EAP_E_AUTHENTICATION_FAILED;
        //}
    }
}


void eap::method_ttls::process_application_data(_In_bytecount_(size_msg) const void *msg, _In_ size_t size_msg)
{
    UNREFERENCED_PARAMETER(msg);
    UNREFERENCED_PARAMETER(size_msg);

    // Prepare inner authentication.
    if (!(m_sc_ctx.m_attrib & ISC_RET_CONFIDENTIALITY))
        throw runtime_error(__FUNCTION__ " Refusing to send credentials unencrypted.");

    m_module.log_event(&EAPMETHOD_TTLS_INNER_CRED, event_data((unsigned int)eap_type_ttls), event_data(m_cred.m_inner->get_name()), event_data::blank);

    SECURITY_STATUS status;

    // Get maximum message sizes.
    SecPkgContext_StreamSizes sizes;
    status = QueryContextAttributes(m_sc_ctx, SECPKG_ATTR_STREAM_SIZES, &sizes);
    if (FAILED(status))
        throw sec_runtime_error(status, __FUNCTION__ " Error getting Schannel required encryption sizes.");

    // Make PAP message.
    sanitizing_blob msg_pap(make_pap_client());
    assert(msg_pap.size() < sizes.cbMaximumMessage);
    unsigned long size_data = std::min<unsigned long>(sizes.cbMaximumMessage, (unsigned long)msg_pap.size()); // Truncate

    sanitizing_blob data(sizes.cbHeader + size_data + sizes.cbTrailer, 0);
    memcpy(data.data() + sizes.cbHeader, msg_pap.data(), size_data);

    // Prepare input/output buffer(s).
    SecBuffer buf[] = {
        {  sizes.cbHeader, SECBUFFER_STREAM_HEADER , data.data()                              },
        {       size_data, SECBUFFER_DATA          , data.data() + sizes.cbHeader             },
        { sizes.cbTrailer, SECBUFFER_STREAM_TRAILER, data.data() + sizes.cbHeader + size_data },
        {               0, SECBUFFER_EMPTY         , NULL                                     },
    };
    SecBufferDesc buf_desc = {
        SECBUFFER_VERSION,
        _countof(buf),
        buf
    };

    // Encrypt the message.
    status = EncryptMessage(m_sc_ctx, 0, &buf_desc, 0);
    if (FAILED(status))
        throw sec_runtime_error(status, __FUNCTION__ " Error encrypting message.");
    m_packet_res.m_data.insert(m_packet_res.m_data.end(), (const unsigned char*)buf[0].pvBuffer, (const unsigned char*)buf[0].pvBuffer + buf[0].cbBuffer + buf[1].cbBuffer + buf[2].cbBuffer);
}


eap::sanitizing_blob eap::method_ttls::make_pap_client() const
{
    const credentials_pap *cred = dynamic_cast<credentials_pap*>(m_cred.m_inner.get());
    if (!cred)
        throw invalid_argument(__FUNCTION__ " Inner credentials missing or not PAP.");

    // Convert username and password to UTF-8.
    sanitizing_string identity_utf8, password_utf8;
    WideCharToMultiByte(CP_UTF8, 0, cred->m_identity.c_str(), (int)cred->m_identity.length(), identity_utf8, NULL, NULL);
    WideCharToMultiByte(CP_UTF8, 0, cred->m_password.c_str(), (int)cred->m_password.length(), password_utf8, NULL, NULL);

    // PAP passwords must be padded to 16B boundary according to RFC 5281. Will not add random extra padding here, as length obfuscation should be done by TLS encryption layer.
    size_t padding_password_ex = (16 - password_utf8.length()) % 16;
    password_utf8.append(padding_password_ex, 0);

    size_t
        size_identity    = identity_utf8.length(),
        size_password    = password_utf8.length(),
        padding_identity = (4 - size_identity         ) % 4,
        padding_password = (4 - password_utf8.length()) % 4,
        size_identity_outer,
        size_password_outer;

    sanitizing_blob msg;
    msg.reserve(
        (size_identity_outer = 
        4                + // Diameter AVP Code
        4                + // Diameter AVP Flags & Length
        size_identity)   + // Identity
        padding_identity + // Identity padding
        (size_password_outer = 
        4                + // Diameter AVP Code
        4                + // Diameter AVP Flags & Length
        size_password)   + // Password
        padding_password); // Password padding

    // Diameter AVP Code User-Name (0x00000001)
    msg.push_back(0x00);
    msg.push_back(0x00);
    msg.push_back(0x00);
    msg.push_back(0x01);

    // Diameter AVP Flags & Length
    unsigned int identity_hdr = htonl((diameter_avp_flag_mandatory << 24) | (unsigned int)size_identity_outer);
    msg.insert(msg.end(), (unsigned char*)&identity_hdr, (unsigned char*)(&identity_hdr + 1));

    // Identity
    msg.insert(msg.end(), identity_utf8.begin(), identity_utf8.end());
    msg.insert(msg.end(), padding_identity, 0);

    // Diameter AVP Code User-Password (0x00000002)
    msg.push_back(0x00);
    msg.push_back(0x00);
    msg.push_back(0x00);
    msg.push_back(0x02);

    // Diameter AVP Flags & Length
    unsigned int password_hdr = htonl((diameter_avp_flag_mandatory << 24) | (unsigned int)size_password_outer);
    msg.insert(msg.end(), (unsigned char*)&password_hdr, (unsigned char*)(&password_hdr + 1));

    // Password
    msg.insert(msg.end(), password_utf8.begin(), password_utf8.end());
    msg.insert(msg.end(), padding_password, 0);

    return msg;
}
