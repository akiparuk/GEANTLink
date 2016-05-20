/*
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

#include <StdAfx.h>


//////////////////////////////////////////////////////////////////////
// eap::session_base
//////////////////////////////////////////////////////////////////////

eap::session_base::session_base()
{
}


DWORD eap::session_base::begin(_In_ DWORD dwFlags, _In_ const EapAttributes *pAttributeArray, _In_ HANDLE hTokenImpersonateUser, _In_ DWORD dwSizeofConnectionData, _In_count_(dwSizeofConnectionData) BYTE *pConnectionData, _In_ DWORD dwSizeofUserData, _In_count_(dwSizeofUserData) BYTE *pUserData, _In_ DWORD dwMaxSendPacketSize, _Out_ EAP_ERROR **ppEapError)
{
    UNREFERENCED_PARAMETER(dwFlags);
    UNREFERENCED_PARAMETER(pAttributeArray);
    UNREFERENCED_PARAMETER(hTokenImpersonateUser);
    UNREFERENCED_PARAMETER(dwSizeofConnectionData);
    UNREFERENCED_PARAMETER(pConnectionData);
    UNREFERENCED_PARAMETER(dwSizeofUserData);
    UNREFERENCED_PARAMETER(pUserData);
    UNREFERENCED_PARAMETER(dwMaxSendPacketSize);
    UNREFERENCED_PARAMETER(ppEapError);

    return ERROR_SUCCESS;
}


DWORD eap::session_base::end(_Out_ EAP_ERROR **ppEapError)
{
    UNREFERENCED_PARAMETER(ppEapError);

    return ERROR_SUCCESS;
}


DWORD eap::session_base::process_request_packet(_In_ DWORD dwSizeofReceivePacket, _In_bytecount_(dwSizeofReceivePacket) EapPacket *pReceivePacket, _Out_ EapPeerMethodOutput *pEapOutput, _Out_ EAP_ERROR **ppEapError)
{
    UNREFERENCED_PARAMETER(dwSizeofReceivePacket);
    UNREFERENCED_PARAMETER(pReceivePacket);
    UNREFERENCED_PARAMETER(pEapOutput);
    UNREFERENCED_PARAMETER(ppEapError);

    return ERROR_NOT_SUPPORTED;
}


DWORD eap::session_base::get_response_packet(_Inout_ DWORD *pcbSendPacket, _Out_cap_(*pcbSendPacket) EapPacket *pSendPacket, _Out_ EAP_ERROR **ppEapError)
{
    UNREFERENCED_PARAMETER(pcbSendPacket);
    UNREFERENCED_PARAMETER(pSendPacket);
    UNREFERENCED_PARAMETER(ppEapError);

    return ERROR_NOT_SUPPORTED;
}


DWORD eap::session_base::get_result(_In_ EapPeerMethodResultReason reason, _Out_ EapPeerMethodResult *ppResult, _Out_ EAP_ERROR **ppEapError)
{
    UNREFERENCED_PARAMETER(reason);
    UNREFERENCED_PARAMETER(ppResult);
    UNREFERENCED_PARAMETER(ppEapError);

    return ERROR_NOT_SUPPORTED;
}


DWORD eap::session_base::get_ui_context(_Out_ DWORD *dwSizeOfUIContextData, _Out_cap_(*dwSizeOfUIContextData) BYTE **pUIContextData, _Out_ EAP_ERROR **ppEapError)
{
    UNREFERENCED_PARAMETER(dwSizeOfUIContextData);
    UNREFERENCED_PARAMETER(pUIContextData);
    UNREFERENCED_PARAMETER(ppEapError);

    return ERROR_NOT_SUPPORTED;
}


DWORD eap::session_base::set_ui_context(_In_ DWORD dwSizeOfUIContextData, _In_count_(dwSizeOfUIContextData) const BYTE *pUIContextData, _Out_ EapPeerMethodOutput *pEapOutput, _Out_ EAP_ERROR **ppEapError)
{
    UNREFERENCED_PARAMETER(dwSizeOfUIContextData);
    UNREFERENCED_PARAMETER(pUIContextData);
    UNREFERENCED_PARAMETER(pEapOutput);
    UNREFERENCED_PARAMETER(ppEapError);

    return ERROR_NOT_SUPPORTED;
}


DWORD eap::session_base::get_response_attributes(_Out_ EapAttributes *pAttribs, _Out_ EAP_ERROR **ppEapError)
{
    assert(pAttribs);
    UNREFERENCED_PARAMETER(ppEapError);

    pAttribs->dwNumberOfAttributes = 0;
    pAttribs->pAttribs             = NULL;

    return ERROR_SUCCESS;
}


DWORD eap::session_base::set_response_attributes(_In_ EapAttributes *pAttribs, _Out_ EapPeerMethodOutput *pEapOutput, _Out_ EAP_ERROR **ppEapError)
{
    assert(pAttribs);
    assert(pEapOutput);
    UNREFERENCED_PARAMETER(ppEapError);

    pEapOutput->action             = EapPeerMethodResponseActionNone;
    pAttribs->dwNumberOfAttributes = 0;
    pAttribs->pAttribs             = NULL;

    return ERROR_SUCCESS;
}


//////////////////////////////////////////////////////////////////////
// eap::module_base
//////////////////////////////////////////////////////////////////////

eap::module_base::module_base()
{
    m_ep.create(&EAPMETHOD_TRACE_EVENT_PROVIDER);
    m_ep.write(&EAPMETHOD_TRACE_EVT_MODULE_LOAD, winstd::event_data((BYTE)EAPMETHOD_TYPE), winstd::event_data::blank);

    m_heap.create(0, 0, 0);
}


eap::module_base::~module_base()
{
    m_ep.write(&EAPMETHOD_TRACE_EVT_MODULE_UNLOAD, winstd::event_data((BYTE)EAPMETHOD_TYPE), winstd::event_data::blank);
}


EAP_ERROR* eap::module_base::make_error(_In_ DWORD dwErrorCode, _In_ DWORD dwReasonCode, _In_ LPCGUID pRootCauseGuid, _In_ LPCGUID pRepairGuid, _In_ LPCGUID pHelpLinkGuid, _In_z_ LPCWSTR pszRootCauseString, _In_z_ LPCWSTR pszRepairString) const
{
    // Calculate memory size requirement.
    SIZE_T
        nRootCauseSize    = pszRootCauseString != NULL && pszRootCauseString[0] ? (wcslen(pszRootCauseString) + 1)*sizeof(WCHAR) : 0,
        nRepairStringSize = pszRepairString    != NULL && pszRepairString   [0] ? (wcslen(pszRepairString   ) + 1)*sizeof(WCHAR) : 0,
        nEapErrorSize = sizeof(EAP_ERROR) + nRootCauseSize + nRepairStringSize;

    EAP_ERROR *pError = (EAP_ERROR*)HeapAlloc(m_heap, 0, nEapErrorSize);
    if (!pError)
        return NULL;
    BYTE *p = (BYTE*)(pError + 1);

    // Fill the error descriptor.
    pError->dwWinError                = dwErrorCode;
    pError->type.eapType.type         = EAPMETHOD_TYPE;
    pError->type.eapType.dwVendorId   = 0;
    pError->type.eapType.dwVendorType = 0;
    pError->type.dwAuthorId           = 67532;
    pError->dwReasonCode              = dwReasonCode;
    pError->rootCauseGuid             = pRootCauseGuid != NULL ? *pRootCauseGuid : GUID_NULL;
    pError->repairGuid                = pRepairGuid    != NULL ? *pRepairGuid    : GUID_NULL;
    pError->helpLinkGuid              = pHelpLinkGuid  != NULL ? *pHelpLinkGuid  : GUID_NULL;
    if (nRootCauseSize) {
        pError->pRootCauseString = (LPWSTR)p;
        memcpy(pError->pRootCauseString, pszRootCauseString, nRootCauseSize);
        p += nRootCauseSize;
    } else
        pError->pRootCauseString = NULL;
    if (nRepairStringSize) {
        pError->pRepairString = (LPWSTR)p;
        memcpy(pError->pRepairString, pszRepairString, nRepairStringSize);
        p += nRepairStringSize;
    } else
        pError->pRepairString = NULL;

    // Write trace event.
    std::vector<EVENT_DATA_DESCRIPTOR> evt_desc;
    evt_desc.reserve(8);
    evt_desc.push_back(winstd::event_data(pError->dwWinError));
    evt_desc.push_back(winstd::event_data(pError->type.eapType.type));
    evt_desc.push_back(winstd::event_data(pError->dwReasonCode));
    evt_desc.push_back(winstd::event_data(&(pError->rootCauseGuid), sizeof(GUID)));
    evt_desc.push_back(winstd::event_data(&(pError->repairGuid), sizeof(GUID)));
    evt_desc.push_back(winstd::event_data(&(pError->helpLinkGuid), sizeof(GUID)));
    evt_desc.push_back(winstd::event_data(pError->pRootCauseString));
    evt_desc.push_back(winstd::event_data(pError->pRepairString));
    m_ep.write(&EAPMETHOD_TRACE_EAP_ERROR, (ULONG)evt_desc.size(), evt_desc.data());

    return pError;
}


void eap::module_base::free_memory(_In_ void *ptr)
{
    ETW_FN_VOID;

    if (ptr) {
        // Since we do security here and some of the BLOBs contain credentials, sanitize every memory block before freeing.
        SecureZeroMemory(ptr, HeapSize(m_heap, 0, ptr));
        HeapFree(m_heap, 0, ptr);
    }
}


void eap::module_base::free_error_memory(_In_ EAP_ERROR *err)
{
    ETW_FN_VOID;

    if (err) {
        // pRootCauseString and pRepairString always trail the ppEapError to reduce number of (de)allocations.
        HeapFree(m_heap, 0, err);
    }
}



//////////////////////////////////////////////////////////////////////
// eap::peer_ui_base
//////////////////////////////////////////////////////////////////////

eap::peer_ui_base::peer_ui_base() : module_base()
{
}
