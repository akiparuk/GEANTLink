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

#include <WinStd/Base64.h>
#include <WinStd/COM.h>
#include <MsXml.h>

namespace eapxml
{
    inline DWORD get_document(_In_ IXMLDOMNode *pXmlNode, _Out_ IXMLDOMDocument2 **ppXmlDoc);
    inline DWORD select_node(_In_ IXMLDOMNode *pXmlParent, _In_z_ const BSTR bstrNodeName, _Out_ IXMLDOMNode **ppXmlNode);
    inline DWORD select_nodes(_In_ IXMLDOMNode *pXmlParent, _In_z_ const BSTR bstrNodeName, _Out_ IXMLDOMNodeList **ppXmlNodes);
    inline DWORD select_element(_In_ IXMLDOMNode *pXmlParent, _In_z_ const BSTR bstrElementName, _Out_ IXMLDOMElement **ppXmlElement);
    inline DWORD get_element_value(_In_ IXMLDOMNode *pXmlParent, _In_z_ const BSTR bstrElementName, _Out_ BSTR *pbstrValue);
    inline DWORD get_element_value(_In_ IXMLDOMNode *pXmlParent, _In_z_ const BSTR bstrElementName, _Out_ std::wstring &sValue);
    inline DWORD get_element_value(_In_ IXMLDOMNode *pXmlParent, _In_z_ const BSTR bstrElementName, _Out_ DWORD *pdwValue);
    inline DWORD get_element_value(_In_ IXMLDOMNode *pXmlParent, _In_z_ const BSTR bstrElementName, _Out_ bool *pbValue);
    inline DWORD get_element_base64(_In_ IXMLDOMNode *pXmlParent, _In_z_ const BSTR bstrElementName, _Out_ std::vector<unsigned char> &aValue);
    inline DWORD get_element_localized(_In_ IXMLDOMNode *pXmlParent, _In_z_ const BSTR bstrElementName, _In_z_ LPCWSTR pszLang, _Out_ BSTR *pbstrValue);
    inline DWORD get_element_localized(_In_ IXMLDOMNode *pXmlParent, _In_z_ const BSTR bstrElementName, _In_z_ LPCWSTR pszLang, _Out_ std::wstring &sValue);
    inline DWORD put_element(_In_ IXMLDOMDocument2 *pDoc, _In_ IXMLDOMNode *pCurrentDOMNode, _In_z_ const BSTR bstrElementName, _In_opt_z_ const BSTR bstrNamespace, _Out_ IXMLDOMElement **ppXmlElement);
    inline DWORD put_element_value(_In_ IXMLDOMDocument2 *pDoc, _In_ IXMLDOMNode *pCurrentDOMNode, _In_z_ const BSTR bstrElementName, _In_opt_z_ const BSTR bstrNamespace, _In_z_ const BSTR bstrValue);
    inline DWORD put_element_value(_In_ IXMLDOMDocument2 *pDoc, _In_ IXMLDOMNode *pCurrentDOMNode, _In_z_ const BSTR bstrElementName, _In_opt_z_ const BSTR bstrNamespace, _In_ DWORD dwValue);
    inline DWORD put_element_value(_In_ IXMLDOMDocument2 *pDoc, _In_ IXMLDOMNode *pCurrentDOMNode, _In_z_ const BSTR bstrElementName, _In_opt_z_ const BSTR bstrNamespace, _In_ bool bValue);
    inline DWORD put_element_base64(_In_ IXMLDOMDocument2 *pDoc, _In_ IXMLDOMNode *pCurrentDOMNode, _In_z_ const BSTR bstrElementName, _In_opt_z_ const BSTR bstrNamespace, _In_count_(nValueLen) LPCVOID pValue, _In_ SIZE_T nValueLen);
}

#pragma once


namespace eapxml
{
    inline DWORD get_document(_In_ IXMLDOMNode *pXmlNode, _Out_ IXMLDOMDocument2 **ppXmlDoc)
    {
        HRESULT hr;

        winstd::com_obj<IXMLDOMDocument> doc;
        hr = pXmlNode->get_ownerDocument(&doc);
        if (FAILED(hr))
            return HRESULT_CODE(hr);

        assert(ppXmlDoc);
        hr = doc.query_interface(ppXmlDoc);
        return SUCCEEDED(hr) ? ERROR_SUCCESS : HRESULT_CODE(hr);
    }


    inline DWORD select_node(_In_ IXMLDOMNode *pXmlParent, _In_z_ const BSTR bstrNodeName, _Out_ IXMLDOMNode **ppXmlNode)
    {
        HRESULT hr;
        return SUCCEEDED(hr = pXmlParent->selectSingleNode(bstrNodeName, ppXmlNode)) && *ppXmlNode != NULL ? ERROR_SUCCESS : HRESULT_CODE(hr);
    }


    inline DWORD select_nodes(_In_ IXMLDOMNode *pXmlParent, _In_z_ const BSTR bstrNodeName, _Out_ IXMLDOMNodeList **ppXmlNodes)
    {
        HRESULT hr;
        return SUCCEEDED(hr = pXmlParent->selectNodes(bstrNodeName, ppXmlNodes)) && *ppXmlNodes != NULL ? ERROR_SUCCESS : HRESULT_CODE(hr);
    }


    inline DWORD select_element(_In_ IXMLDOMNode *pXmlParent, _In_z_ const BSTR bstrElementName, _Out_ IXMLDOMElement **ppXmlElement)
    {
        DWORD dwResult;
        HRESULT hr;
        winstd::com_obj<IXMLDOMNode> pXmlNode;

        return
            (dwResult = select_node(pXmlParent, bstrElementName, &pXmlNode)) == ERROR_SUCCESS ?
            SUCCEEDED(hr = pXmlNode.query_interface(ppXmlElement)) ?
            *ppXmlElement ? ERROR_SUCCESS : ERROR_NO_DATA : HRESULT_CODE(hr) : dwResult;
    }


    inline DWORD get_element_value(_In_ IXMLDOMNode *pXmlParent, _In_z_ const BSTR bstrElementName, _Out_ BSTR *pbstrValue)
    {
        DWORD dwResult;
        HRESULT hr;
        winstd::com_obj<IXMLDOMElement> pXmlElement;

        return
            (dwResult = select_element(pXmlParent, bstrElementName, &pXmlElement)) == ERROR_SUCCESS ?
            SUCCEEDED(hr = pXmlElement->get_text(pbstrValue)) ?
            *pbstrValue ? ERROR_SUCCESS : ERROR_NO_DATA : HRESULT_CODE(hr) : dwResult;
    }


    inline DWORD get_element_value(_In_ IXMLDOMNode *pXmlParent, _In_z_ const BSTR bstrElementName, _Out_ std::wstring &sValue)
    {
        winstd::bstr bstr;
        DWORD dwResult = get_element_value(pXmlParent, bstrElementName, &bstr);
        if (dwResult == ERROR_SUCCESS)
            sValue.assign(bstr, bstr.length());
        return dwResult;
    }



    inline DWORD get_element_value(_In_ IXMLDOMNode *pXmlParent, _In_z_ const BSTR bstrElementName, _Out_ DWORD *pdwValue)
    {
        winstd::bstr bstr;
        DWORD dwResult = get_element_value(pXmlParent, bstrElementName, &bstr);
        if (dwResult == ERROR_SUCCESS)
            *pdwValue = wcstoul(bstr, NULL, 10);
        return dwResult;
    }


    inline DWORD get_element_value(_In_ IXMLDOMNode *pXmlParent, _In_z_ const BSTR bstrElementName, _Out_ bool *pbValue)
    {
        winstd::bstr bstr;
        DWORD dwResult = get_element_value(pXmlParent, bstrElementName, &bstr);
        if (dwResult == ERROR_SUCCESS) {
            if (CompareStringEx(LOCALE_NAME_INVARIANT, NORM_IGNORECASE, bstr, bstr.length(), L"true" , -1, NULL, NULL, 0) == CSTR_EQUAL ||
                CompareStringEx(LOCALE_NAME_INVARIANT, NORM_IGNORECASE, bstr, bstr.length(), L"1"    , -1, NULL, NULL, 0) == CSTR_EQUAL)
                *pbValue = true;
            else if (
                CompareStringEx(LOCALE_NAME_INVARIANT, NORM_IGNORECASE, bstr, bstr.length(), L"false", -1, NULL, NULL, 0) == CSTR_EQUAL ||
                CompareStringEx(LOCALE_NAME_INVARIANT, NORM_IGNORECASE, bstr, bstr.length(), L"0"    , -1, NULL, NULL, 0) == CSTR_EQUAL)
                *pbValue = false;
            else
                dwResult = ERROR_INVALID_DATA;
        }

        return dwResult;
    }


    inline DWORD get_element_base64(_In_ IXMLDOMNode *pXmlParent, _In_z_ const BSTR bstrElementName, _Out_ std::vector<unsigned char> &aValue)
    {
        winstd::bstr bstr;
        DWORD dwResult = get_element_value(pXmlParent, bstrElementName, &bstr);
        if (dwResult == ERROR_SUCCESS) {
            winstd::base64_dec dec;
            bool is_last;
            dec.decode(aValue, is_last, (BSTR)bstr, bstr.length());
        }

        return dwResult;
    }


    inline DWORD get_element_localized(_In_ IXMLDOMNode *pXmlParent, _In_z_ const BSTR bstrElementName, _In_z_ LPCWSTR pszLang, _Out_ BSTR *pbstrValue)
    {
        HRESULT hr;
        winstd::com_obj<IXMLDOMElement> pXmlElement;

        DWORD dwResult = select_element(pXmlParent, bstrElementName, &pXmlElement);
        if (dwResult != ERROR_SUCCESS)
            return dwResult;

        winstd::com_obj<IXMLDOMNodeList> pXmlListLocalizedText;
        long lCount = 0;
        if (select_nodes(pXmlElement, winstd::bstr(L"eap-metadata:localized-text"), &pXmlListLocalizedText) != ERROR_SUCCESS ||
            FAILED(pXmlListLocalizedText->get_length(&lCount)) ||
            lCount <= 0)
        {
            return
                SUCCEEDED(hr = pXmlElement->get_text(pbstrValue)) ?
                *pbstrValue ? ERROR_SUCCESS : ERROR_NO_DATA : HRESULT_CODE(hr);
        }

        winstd::bstr bstrDefault, bstrEn;
        for (long i = 0; ; i++) {
            if (i >= lCount) {
                if (bstrDefault != NULL) {
                    // Return "C" localization.
                    *pbstrValue = bstrDefault.detach();
                    return ERROR_SUCCESS;
                } else if (bstrEn != NULL) {
                    // Return "en" localization.
                    *pbstrValue = bstrEn.detach();
                    return ERROR_SUCCESS;
                } else
                    return ERROR_NOT_FOUND;
            }

            winstd::com_obj<IXMLDOMNode> pXmlElLocalizedText;
            pXmlListLocalizedText->get_item(i, &pXmlElLocalizedText);

            {
                // Read <lang>.
                winstd::bstr bstrLang;
                if (get_element_value(pXmlElLocalizedText, winstd::bstr(L"eap-metadata:lang"), &bstrLang) != ERROR_SUCCESS ||
                    CompareStringEx(LOCALE_NAME_INVARIANT, NORM_IGNORECASE, bstrLang, bstrLang.length(), L"C" , -1, NULL, NULL, 0) == CSTR_EQUAL)
                {
                    // <lang> is missing or "C" language found.
                    winstd::bstr bstr;
                    if ((dwResult = get_element_value(pXmlElLocalizedText, winstd::bstr(L"eap-metadata:text"), &bstr)) == ERROR_SUCCESS)
                        bstrDefault.attach(bstr.detach());
                } else if (CompareStringEx(LOCALE_NAME_INVARIANT, NORM_IGNORECASE, bstrLang, bstrLang.length(), pszLang, -1, NULL, NULL, 0) == CSTR_EQUAL) {
                    // Found an exact match.
                    return get_element_value(pXmlElLocalizedText, winstd::bstr(L"eap-metadata:text"), pbstrValue);
                } else if (CompareStringEx(LOCALE_NAME_INVARIANT, NORM_IGNORECASE, bstrLang, bstrLang.length(), L"en", -1, NULL, NULL, 0) == CSTR_EQUAL) {
                    // "en" language found.
                    winstd::bstr bstr;
                    if ((dwResult = get_element_value(pXmlElLocalizedText, winstd::bstr(L"eap-metadata:text"), &bstr)) == ERROR_SUCCESS)
                        bstrEn.attach(bstr.detach());
                }
            }
        }
    }


    inline DWORD get_element_localized(_In_ IXMLDOMNode *pXmlParent, _In_z_ const BSTR bstrElementName, _In_z_ LPCWSTR pszLang, _Out_ std::wstring &sValue)
    {
        winstd::bstr bstr;
        DWORD dwResult = get_element_localized(pXmlParent, bstrElementName, pszLang, &bstr);
        if (dwResult == ERROR_SUCCESS)
            sValue.assign(bstr, bstr.length());
        return dwResult;
    }


    inline DWORD put_element(_In_ IXMLDOMDocument2 *pDoc, _In_ IXMLDOMNode *pCurrentDOMNode, _In_z_ const BSTR bstrElementName, _In_opt_z_ const BSTR bstrNamespace, _Out_ IXMLDOMElement **ppXmlElement)
    {
        static const VARIANT varNodeTypeEl = { VT_I4, 0, 0, 0, { NODE_ELEMENT } };
        HRESULT hr;
        winstd::com_obj<IXMLDOMNode> pXmlEl;

        if (FAILED(hr = pDoc->createNode(varNodeTypeEl, bstrElementName, bstrNamespace, &pXmlEl)))
            return HRESULT_CODE(hr);

        if (FAILED(hr = pCurrentDOMNode->appendChild(pXmlEl, NULL)))
            return HRESULT_CODE(hr);

        if (FAILED(hr = pXmlEl.query_interface(ppXmlElement)))
            return HRESULT_CODE(hr);

        return ERROR_SUCCESS;
    }


    inline DWORD put_element_value(_In_ IXMLDOMDocument2 *pDoc, _In_ IXMLDOMNode *pCurrentDOMNode, _In_z_ const BSTR bstrElementName, _In_opt_z_ const BSTR bstrNamespace, _In_z_ const BSTR bstrValue)
    {
        static const VARIANT varNodeTypeEl = { VT_I4, 0, 0, 0, { NODE_ELEMENT } };
        HRESULT hr;
        winstd::com_obj<IXMLDOMNode> pXmlEl;

        if (FAILED(hr = pDoc->createNode(varNodeTypeEl, bstrElementName, bstrNamespace, &pXmlEl)))
            return HRESULT_CODE(hr);

        winstd::com_obj<IXMLDOMText> pXmlElText;
        if (FAILED(hr = pDoc->createTextNode(bstrValue, &pXmlElText)))
            return HRESULT_CODE(hr);

        if (FAILED(hr = pXmlEl->appendChild(pXmlElText, NULL)))
            return HRESULT_CODE(hr);

        if (FAILED(hr = pCurrentDOMNode->appendChild(pXmlEl, NULL)))
            return HRESULT_CODE(hr);

        return ERROR_SUCCESS;
    }


    inline DWORD put_element_value(_In_ IXMLDOMDocument2 *pDoc, _In_ IXMLDOMNode *pCurrentDOMNode, _In_z_ const BSTR bstrElementName, _In_opt_z_ const BSTR bstrNamespace, _In_ DWORD dwValue)
    {
        return put_element_value(pDoc, pCurrentDOMNode, bstrElementName, bstrNamespace, winstd::bstr(winstd::wstring_printf(L"%d", dwValue).c_str()));
    }


    inline DWORD put_element_value(_In_ IXMLDOMDocument2 *pDoc, _In_ IXMLDOMNode *pCurrentDOMNode, _In_z_ const BSTR bstrElementName, _In_opt_z_ const BSTR bstrNamespace, _In_ bool bValue)
    {
        return put_element_value(pDoc, pCurrentDOMNode, bstrElementName, bstrNamespace, winstd::bstr(bValue ? L"true": L"false"));
    }


    inline DWORD put_element_base64(_In_ IXMLDOMDocument2 *pDoc, _In_ IXMLDOMNode *pCurrentDOMNode, _In_z_ const BSTR bstrElementName, _In_opt_z_ const BSTR bstrNamespace, _In_count_(nValueLen) LPCVOID pValue, _In_ SIZE_T nValueLen)
    {
        std::wstring sBase64;
        winstd::base64_enc enc;
        enc.encode(sBase64, pValue, nValueLen);
        return put_element_value(pDoc, pCurrentDOMNode, bstrElementName, bstrNamespace, winstd::bstr(sBase64.c_str()));
    }
}
