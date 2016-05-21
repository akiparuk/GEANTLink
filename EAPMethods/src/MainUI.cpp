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


#if EAPMETHOD_TYPE==21
#define _EAPMETHOD_PEER_UI eap::peer_ttls_ui
#else
#error Unknown EAP Method type.
#endif

HINSTANCE g_hResource = NULL;
_EAPMETHOD_PEER_UI g_peer;


///
/// DLL main entry point
///
/// \sa [DllMain entry point](https://msdn.microsoft.com/en-us/library/windows/desktop/ms682583.aspx)
///
BOOL WINAPI DllMain(_In_ HINSTANCE hinstDLL, _In_ DWORD fdwReason, _In_ LPVOID lpvReserved)
{
    UNREFERENCED_PARAMETER(lpvReserved);

    if (fdwReason == DLL_PROCESS_ATTACH) {
#ifdef _DEBUG
        Sleep(10000);
#endif
        g_hResource = hinstDLL;
    } else if (fdwReason == DLL_PROCESS_DETACH)
        assert(!_CrtDumpMemoryLeaks());

    return TRUE;
}


///
/// Releases all memory associated with an opaque user interface context data buffer.
///
/// \sa [EapPeerFreeMemory function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363606.aspx)
///
VOID WINAPI EapPeerFreeMemory(_In_ void *pUIContextData)
{
    if (pUIContextData)
        g_peer.free_memory((BYTE*)pUIContextData);
}


///
/// Releases error-specific memory allocated by the EAP peer method.
///
/// \sa [EapPeerFreeErrorMemory function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363605.aspx)
///
VOID WINAPI EapPeerFreeErrorMemory(_In_ EAP_ERROR *ppEapError)
{
    if (ppEapError)
        g_peer.free_error_memory(ppEapError);
}


///
/// Converts XML into the configuration BLOB.
///
/// \sa [EapPeerConfigXml2Blob function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363602.aspx)
///
DWORD WINAPI EapPeerConfigXml2Blob(
    _In_  DWORD            dwFlags,
    _In_  EAP_METHOD_TYPE  eapMethodType,
    _In_  IXMLDOMDocument2 *pConfigDoc,
    _Out_ BYTE             **ppConfigOut,
    _Out_ DWORD            *pdwConfigOutSize,
    _Out_ EAP_ERROR        **ppEapError)
{
    DWORD dwResult = ERROR_SUCCESS;
#ifdef _DEBUG
    //MessageBox(NULL, _T("Attach debugger!"), _T(__FUNCTION__), MB_OK);
#endif

    // Parameter check
    if (!ppEapError)
        dwResult = ERROR_INVALID_PARAMETER;
    else if (eapMethodType.eapType.type != EAPMETHOD_TYPE)
        *ppEapError = g_peer.make_error(dwResult = ERROR_NOT_SUPPORTED, 0, NULL, NULL, NULL, winstd::wstring_printf(_T(__FUNCTION__) _T(" Input EAP type (%d) does not match the supported EAP type (%d)."), (int)eapMethodType.eapType.type, (int)EAPMETHOD_TYPE).c_str(), NULL);
    else if (eapMethodType.dwAuthorId != 67532)
        *ppEapError = g_peer.make_error(dwResult = ERROR_NOT_SUPPORTED, 0, NULL, NULL, NULL, winstd::wstring_printf(_T(__FUNCTION__) _T(" EAP author (%d) does not match the supported author (%d)."), (int)eapMethodType.dwAuthorId, (int)67532).c_str(), NULL);
    else if (!pConfigDoc)
        *ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" pConfigDoc is NULL."), NULL);
    else if (!ppConfigOut)
        *ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" ppConfigOut is NULL."), NULL);
    else if (!pdwConfigOutSize)
        *ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" pdwConfigOutSize is NULL."), NULL);
    else
        dwResult = g_peer.config_xml_to_blob(
            dwFlags,
            pConfigDoc,
            ppConfigOut,
            pdwConfigOutSize,
            ppEapError);

    return dwResult;
}


///
/// Converts the configuration BLOB to XML.
///
/// The configuration BLOB is returned in the ppConnectionDataOut parameter of the EapPeerInvokeConfigUI function.
///
/// \sa [EapPeerConfigBlob2Xml function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363601.aspx)
///
DWORD WINAPI EapPeerConfigBlob2Xml(
    _In_                             DWORD            dwFlags,
    _In_                             EAP_METHOD_TYPE  eapMethodType,
    _In_count_(dwConfigInSize) const BYTE             *pConfigIn,
    _In_                             DWORD            dwConfigInSize,
    _Out_                            IXMLDOMDocument2 **ppConfigDoc,
    _Out_                            EAP_ERROR        **ppEapError)
{
    DWORD dwResult = ERROR_SUCCESS;
#ifdef _DEBUG
    //MessageBox(NULL, _T("Attach debugger!"), _T(__FUNCTION__), MB_OK);
#endif

    // Parameter check
    if (!ppEapError)
        dwResult = ERROR_INVALID_PARAMETER;
    else if (eapMethodType.eapType.type != EAPMETHOD_TYPE)
        *ppEapError = g_peer.make_error(dwResult = ERROR_NOT_SUPPORTED, 0, NULL, NULL, NULL, winstd::wstring_printf(_T(__FUNCTION__) _T(" Input EAP type (%d) does not match the supported EAP type (%d)."), (int)eapMethodType.eapType.type, (int)EAPMETHOD_TYPE).c_str(), NULL);
    else if (eapMethodType.dwAuthorId != 67532)
        *ppEapError = g_peer.make_error(dwResult = ERROR_NOT_SUPPORTED, 0, NULL, NULL, NULL, winstd::wstring_printf(_T(__FUNCTION__) _T(" EAP author (%d) does not match the supported author (%d)."), (int)eapMethodType.dwAuthorId, (int)67532).c_str(), NULL);
    else if (!pConfigIn && dwConfigInSize)
        *ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" pConfigIn is NULL."), NULL);
    else if (!ppConfigDoc)
        *ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" ppConfigDoc is NULL."), NULL);
    else
        dwResult = g_peer.config_blob_to_xml(
            dwFlags,
            pConfigIn,
            dwConfigInSize,
            ppConfigDoc,
            ppEapError);

    return dwResult;
}


///
/// Raises the EAP method's specific connection configuration user interface dialog on the client.
///
/// \sa [EapPeerInvokeConfigUI function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363614.aspx)
///
DWORD WINAPI EapPeerInvokeConfigUI(
    _In_                               const EAP_METHOD_TYPE *pEapType,
    _In_                                     HWND            hwndParent,
    _In_                                     DWORD           dwFlags,
    _In_                                     DWORD           dwConnectionDataInSize,
    _In_count_(dwConnectionDataInSize) const BYTE            *pConnectionDataIn,
    _Out_                                    DWORD           *pdwConnectionDataOutSize,
    _Out_                                    BYTE            **ppConnectionDataOut,
    _Out_                                    EAP_ERROR       **ppEapError)
{
    DWORD dwResult = ERROR_SUCCESS;
#ifdef _DEBUG
    //MessageBox(NULL, _T("Attach debugger!"), _T(__FUNCTION__), MB_OK);
#endif

    // Parameter check
    if (!ppEapError)
        dwResult = ERROR_INVALID_PARAMETER;
    else if (!pEapType)
        *ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" pEapType is NULL."), NULL);
    else if (pEapType->eapType.type != EAPMETHOD_TYPE)
        *ppEapError = g_peer.make_error(dwResult = ERROR_NOT_SUPPORTED, 0, NULL, NULL, NULL, winstd::wstring_printf(_T(__FUNCTION__) _T(" Input EAP type (%d) does not match the supported EAP type (%d)."), (int)pEapType->eapType.type, (int)EAPMETHOD_TYPE).c_str(), NULL);
    else if (pEapType->dwAuthorId != 67532)
        *ppEapError = g_peer.make_error(dwResult = ERROR_NOT_SUPPORTED, 0, NULL, NULL, NULL, winstd::wstring_printf(_T(__FUNCTION__) _T(" EAP author (%d) does not match the supported author (%d)."), (int)pEapType->dwAuthorId, (int)67532).c_str(), NULL);
    else if (!pConnectionDataIn && dwConnectionDataInSize)
        *ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" pConnectionDataIn is NULL."), NULL);
    else if (!pdwConnectionDataOutSize)
        *ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" pdwConnectionDataOutSize is NULL."), NULL);
    else if (!ppConnectionDataOut)
        *ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" ppConnectionDataOut is NULL."), NULL);
    else
        dwResult = g_peer.invoke_config_ui(
            hwndParent,
            dwFlags,
            dwConnectionDataInSize,
            pConnectionDataIn,
            pdwConnectionDataOutSize,
            ppConnectionDataOut,
            ppEapError);

    return dwResult;
}


///
/// Raises a custom interactive user interface dialog to obtain user identity information for the EAP method on the client.
///
/// \sa [EapPeerInvokeIdentityUI function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363615.aspx)
///
DWORD WINAPI EapPeerInvokeIdentityUI(
    _In_                             const EAP_METHOD_TYPE *pEapType,
    _In_                                   DWORD           dwFlags,
    _In_                                   HWND            hwndParent,
    _In_                                   DWORD           dwConnectionDataSize,
    _In_count_(dwConnectionDataSize) const BYTE            *pConnectionData,
    _In_                                   DWORD           dwUserDataSize,
    _In_count_(dwUserDataSize)       const BYTE            *pUserData,
    _Out_                                  DWORD           *pdwUserDataOutSize,
    _Out_                                  BYTE            **ppUserDataOut,
    _Out_                                  LPWSTR          *ppwszIdentity,
    _Out_                                  EAP_ERROR       **ppEapError)
{
    DWORD dwResult = ERROR_SUCCESS;
#ifdef _DEBUG
    //MessageBox(NULL, _T("Attach debugger!"), _T(__FUNCTION__), MB_OK);
#endif

    // Parameter check
    if (!ppEapError)
        dwResult = ERROR_INVALID_PARAMETER;
    else if (!pEapType)
        *ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" pEapType is NULL."), NULL);
    else if (pEapType->eapType.type != EAPMETHOD_TYPE)
        *ppEapError = g_peer.make_error(dwResult = ERROR_NOT_SUPPORTED, 0, NULL, NULL, NULL, winstd::wstring_printf(_T(__FUNCTION__) _T(" Input EAP type (%d) does not match the supported EAP type (%d)."), (int)pEapType->eapType.type, (int)EAPMETHOD_TYPE).c_str(), NULL);
    else if (pEapType->dwAuthorId != 67532)
        *ppEapError = g_peer.make_error(dwResult = ERROR_NOT_SUPPORTED, 0, NULL, NULL, NULL, winstd::wstring_printf(_T(__FUNCTION__) _T(" EAP author (%d) does not match the supported author (%d)."), (int)pEapType->dwAuthorId, (int)67532).c_str(), NULL);
    else if (!pConnectionData && dwConnectionDataSize)
        *ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" pConnectionData is NULL."), NULL);
    else if (!pUserData && dwUserDataSize)
        *ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" pUserData is NULL."), NULL);
    else if (!pdwUserDataOutSize)
        *ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" pdwUserDataOutSize is NULL."), NULL);
    else if (!ppUserDataOut)
        *ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" ppUserDataOut is NULL."), NULL);
    else if (!ppwszIdentity)
        *ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" ppwszIdentity is NULL."), NULL);
    else
        dwResult = g_peer.invoke_identity_ui(
            dwFlags,
            hwndParent,
            dwConnectionDataSize,
            pConnectionData,
            dwUserDataSize,
            pUserData,
            pdwUserDataOutSize,
            ppUserDataOut,
            ppwszIdentity,
            ppEapError);

    return dwResult;
}


///
/// Raises a custom interactive user interface dialog for the EAP method on the client.
///
/// \sa [EapPeerInvokeInteractiveUI function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363616.aspx)
///
DWORD WINAPI EapPeerInvokeInteractiveUI(
    _In_                            const EAP_METHOD_TYPE *pEapType,
    _In_                                  HWND            hwndParent,
    _In_                                  DWORD           dwUIContextDataSize,
    _In_count_(dwUIContextDataSize) const BYTE            *pUIContextData,
    _Out_                                 DWORD           *pdwDataFromInteractiveUISize,
    _Out_                                 BYTE            **ppDataFromInteractiveUI,
    _Out_                                 EAP_ERROR       **ppEapError)
{
    DWORD dwResult = ERROR_SUCCESS;
#ifdef _DEBUG
    //MessageBox(NULL, _T("Attach debugger!"), _T(__FUNCTION__), MB_OK);
#endif

    // Parameter check
    if (!ppEapError)
        dwResult = ERROR_INVALID_PARAMETER;
    else if (!pEapType)
        *ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" pEapType is NULL."), NULL);
    else if (pEapType->eapType.type != EAPMETHOD_TYPE)
        *ppEapError = g_peer.make_error(dwResult = ERROR_NOT_SUPPORTED, 0, NULL, NULL, NULL, winstd::wstring_printf(_T(__FUNCTION__) _T(" Input EAP type (%d) does not match the supported EAP type (%d)."), (int)pEapType->eapType.type, (int)EAPMETHOD_TYPE).c_str(), NULL);
    else if (pEapType->dwAuthorId != 67532)
        *ppEapError = g_peer.make_error(dwResult = ERROR_NOT_SUPPORTED, 0, NULL, NULL, NULL, winstd::wstring_printf(_T(__FUNCTION__) _T(" EAP author (%d) does not match the supported author (%d)."), (int)pEapType->dwAuthorId, (int)67532).c_str(), NULL);
    else if (!pUIContextData && dwUIContextDataSize)
        *ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" pUIContextData is NULL."), NULL);
    else if (!pdwDataFromInteractiveUISize)
        *ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" pdwDataFromInteractiveUISize is NULL."), NULL);
    else if (!ppDataFromInteractiveUI)
        *ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, 0, NULL, NULL, NULL, _T(__FUNCTION__) _T(" ppDataFromInteractiveUI is NULL."), NULL);
    else
        dwResult = g_peer.invoke_interactive_ui(
            hwndParent,
            dwUIContextDataSize,
            pUIContextData,
            pdwDataFromInteractiveUISize,
            ppDataFromInteractiveUI,
            ppEapError);

    return dwResult;
}
