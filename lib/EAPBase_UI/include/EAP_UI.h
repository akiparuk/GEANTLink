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

#include <wx/hyperlink.h>
#include <wx/icon.h>
#include <wx/menuitem.h>
#include <wx/scrolwin.h>
#include <wx/statbmp.h>
#include <wx/aui/auibar.h>
#include <Windows.h>


///
/// Reusable EAP dialog banner for `wxEAPConfigDialog` and `wxEAPCredentialsDialog`
///
class wxEAPBannerPanel;

///
/// EAP top-most configuration dialog
///
template <class _wxT> class wxEAPConfigDialog;

///
/// EAP general-use dialog
///
class wxEAPGeneralDialog;

///
/// EAP top-most credential dialog
///
class wxEAPCredentialsDialog;

///
/// EAP general note
///
class wxEAPNotePanel;

///
/// EAP provider-locked congifuration note
///
class wxEAPProviderLockedPanel;

///
/// EAP credential warning note
///
class wxEAPCredentialWarningPanel;

///
/// EAP Configuration window
///
class wxEAPConfigWindow;

///
/// EAP provider identity config panel
///
class wxEAPProviderIdentityPanel;

///
/// EAP provider configuration dialog
///
class wxEAPConfigProvider;

///
/// Base template for credential configuration panel
///
template <class _Tcred, class _wxT> class wxEAPCredentialsConfigPanel;

///
/// Base template for all credential entry panels
///
template <class _Tcred, class _Tbase> class wxEAPCredentialsPanelBase;

///
/// Generic password credential entry panel
///
template <class _Tcred, class _Tbase> class wxPasswordCredentialsPanel;

///
/// Loads icon from resource
///
inline wxIcon wxLoadIconFromResource(HINSTANCE hinst, PCWSTR pszName, int cx, int cy);

///
/// Loads icon from resource
///
inline wxIcon wxLoadIconFromResource(HINSTANCE hinst, PCWSTR pszName, const wxSize &size);

///
/// Sets icon from resource
///
inline bool wxSetIconFromResource(wxStaticBitmap *bmp, wxIcon &icon, HINSTANCE hinst, PCWSTR pszName);

///
/// Sets icon from resource
///
inline bool wxSetIconFromResource(wxAuiToolBarItem *bmp, wxIcon &icon, HINSTANCE hinst, PCWSTR pszName, const wxSize &size);

///
/// Sets icon from resource
///
inline bool wxSetIconFromResource(wxMenuItem *item, wxIcon &icon, HINSTANCE hinst, PCWSTR pszName);

///
/// Returns GUI displayable provider name
///
inline wxString wxEAPGetProviderName(const std::wstring &id);

namespace eap
{
    ///
    /// Base class to prevent multiple instances of the same dialog
    ///
    class monitor_ui;
}

#pragma once

#include <wx/msw/winundef.h> // Fixes `CreateDialog` name collision
#include "../res/wxEAP_UI.h"

#include "../../EAPBase/include/Config.h"
#include "../../EAPBase/include/Credentials.h"

#include <WinStd/Common.h>
#include <WinStd/Cred.h>
#include <WinStd/Win.h>

#include <wx/log.h>

#include <CommCtrl.h>

#include <list>
#include <memory>


class wxEAPBannerPanel : public wxEAPBannerPanelBase
{
public:
    ///
    /// Constructs a banner pannel and set the title text to product name
    ///
    wxEAPBannerPanel(wxWindow* parent);

protected:
    /// \cond internal
    virtual bool AcceptsFocusFromKeyboard() const;
    /// \endcond
};


template <class _wxT>
class wxEAPConfigDialog : public wxEAPConfigDialogBase
{
public:
    ///
    /// Constructs a configuration dialog
    ///
    /// \param[inout] cfg     Connection configuration
    /// \param[in]    parent  Parent window
    ///
    wxEAPConfigDialog(eap::config_connection &cfg, wxWindow* parent) :
        m_cfg(cfg),
        wxEAPConfigDialogBase(parent)
    {
        // Set extra style here, as wxFormBuilder overrides all default flags.
        this->SetExtraStyle(this->GetExtraStyle() | wxWS_EX_VALIDATE_RECURSIVELY);

        for (std::vector<eap::config_provider>::iterator provider = m_cfg.m_providers.begin(), provider_end = m_cfg.m_providers.end(); provider != provider_end; ++provider) {
            bool is_single = provider->m_methods.size() == 1;
            std::vector<std::unique_ptr<eap::config_method> >::size_type count = 0;
            std::vector<std::unique_ptr<eap::config_method> >::iterator method = provider->m_methods.begin(), method_end = provider->m_methods.end();
            for (; method != method_end; ++method, count++)
                m_providers->AddPage(
                    new _wxT(
                        *provider,
                        *method->get(),
                        provider->m_id.c_str(),
                        m_providers),
                    is_single ?
                        wxEAPGetProviderName(provider->m_id) :
                        winstd::tstring_printf(_T("%s (%u)"), wxEAPGetProviderName(provider->m_id), count));
        }

        this->Layout();
        this->GetSizer()->Fit(this);

        m_buttonsOK->SetDefault();
    }


protected:
    /// \cond internal

    virtual void OnInitDialog(wxInitDialogEvent& event)
    {
        // Forward the event to child panels.
        for (wxWindowList::compatibility_iterator provider = m_providers->GetChildren().GetFirst(); provider; provider = provider->GetNext()) {
            wxWindow *prov = wxDynamicCast(provider->GetData(), wxWindow);
            if (prov)
                prov->GetEventHandler()->ProcessEvent(event);
        }
    }

    virtual void OnUpdateUI(wxUpdateUIEvent& event)
    {
        UNREFERENCED_PARAMETER(event);

        m_advanced->Enable(!m_cfg.m_providers.at(m_providers->GetSelection()).m_read_only);
    }

    virtual void OnAdvanced(wxCommandEvent& event)
    {
        UNREFERENCED_PARAMETER(event);

        wxEAPConfigProvider dlg(m_cfg.m_providers.at(m_providers->GetSelection()), this);
        dlg.ShowModal();
    }

    /// \endcond


protected:
    eap::config_connection &m_cfg;  ///< Connection configuration
};


class wxEAPGeneralDialog : public wxEAPGeneralDialogBase
{
public:
    ///
    /// Constructs a dialog
    ///
    wxEAPGeneralDialog(wxWindow *parent, wxWindowID id = wxID_ANY, const wxString &title = wxEmptyString, const wxPoint &pos = wxDefaultPosition, const wxSize &size = wxDefaultSize, long style = wxDEFAULT_DIALOG_STYLE);

    ///
    /// Adds panels to the dialog
    ///
    void AddContent(wxPanel **contents, size_t content_count);

    ///
    /// Adds single panel to the dialog
    ///
    void AddContent(wxPanel *content);

protected:
    /// \cond internal
    virtual void OnInitDialog(wxInitDialogEvent& event);
    /// \endcond
};


class wxEAPCredentialsDialog : public wxEAPGeneralDialog
{
public:
    ///
    /// Constructs a credential dialog
    ///
    wxEAPCredentialsDialog(const eap::config_provider &prov, wxWindow *parent, wxWindowID id = wxID_ANY, const wxString &title = _("EAP Credentials"), const wxPoint &pos = wxDefaultPosition, const wxSize &size = wxDefaultSize, long style = wxDEFAULT_DIALOG_STYLE);
};


class wxEAPNotePanel : public wxEAPNotePanelBase
{
public:
    ///
    /// Constructs an empty notice pannel
    ///
    wxEAPNotePanel(wxWindow* parent);

protected:
    /// \cond internal

    virtual bool AcceptsFocusFromKeyboard() const;

    template<class _Elem, class _Traits, class _Ax>
    static std::basic_string<_Elem, _Traits, _Ax> GetPhoneNumber(_In_z_ const _Elem *num)
    {
        assert(num);

        std::basic_string<_Elem, _Traits, _Ax> str;
        for (; *num; num++) {
            _Elem c = *num;
            if ('0' <= c && c <= '9' || c == '+' || c == '*' || c == '#')
                str += c;
        }

        return str;
    }

    template<class _Elem>
    static std::basic_string<_Elem, std::char_traits<_Elem>, std::allocator<_Elem> > GetPhoneNumber(_In_z_ const _Elem *num)
    {
        return GetPhoneNumber<_Elem, std::char_traits<_Elem>, std::allocator<_Elem> >(num);
    }

    void CreateContactFields(const eap::config_provider &prov);

    /// \endcond

protected:
    wxStaticText *m_provider_notice;
    wxStaticText *m_help_web_label;
    wxHyperlinkCtrl *m_help_web_value;
    wxStaticText *m_help_email_label;
    wxHyperlinkCtrl *m_help_email_value;
    wxStaticText *m_help_phone_label;
    wxHyperlinkCtrl *m_help_phone_value;
};


class wxEAPProviderLockedPanel : public wxEAPNotePanel
{
public:
    ///
    /// Constructs a notice pannel and set the title text
    ///
    wxEAPProviderLockedPanel(const eap::config_provider &prov, wxWindow* parent);

protected:
    winstd::library m_shell32;  ///< shell32.dll resource library reference
    wxIcon m_icon;              ///< Panel icon
};


class wxEAPCredentialWarningPanel : public wxEAPNotePanel
{
public:
    ///
    /// Constructs a notice pannel and set the title text
    ///
    wxEAPCredentialWarningPanel(const eap::config_provider &prov, wxWindow* parent);

protected:
    winstd::library m_shell32;  ///< shell32.dll resource library reference
    wxIcon m_icon;              ///< Panel icon
};


class wxEAPConfigWindow : public wxScrolledWindow
{
public:
    ///
    /// Constructs a configuration window
    ///
    /// \param[in]    prov    Provider configuration data
    /// \param[inout] cfg     Configuration data
    /// \param[in]    parent  Parent window
    ///
    wxEAPConfigWindow(const eap::config_provider &prov, eap::config_method &cfg, wxWindow* parent);

    ///
    /// Destructs the configuration window
    ///
    virtual ~wxEAPConfigWindow();

protected:
    /// \cond internal
    virtual void OnInitDialog(wxInitDialogEvent& event);
    virtual void OnUpdateUI(wxUpdateUIEvent& event);
    /// \endcond

protected:
    const eap::config_provider &m_prov;     ///< EAP provider
    eap::config_method &m_cfg;              ///< Method configuration
};


class wxEAPProviderIdentityPanel : public wxEAPProviderIdentityPanelBase
{
public:
    ///
    /// Constructs a provider identity pannel
    ///
    /// \param[inout] prov    Provider configuration data
    /// \param[in]    parent  Parent window
    ///
    wxEAPProviderIdentityPanel(eap::config_provider &prov, wxWindow* parent);

    friend class wxEAPConfigProvider; // Allows direct setting of keyboard focus

protected:
    /// \cond internal
    virtual bool TransferDataToWindow();
    virtual bool TransferDataFromWindow();
    /// \endcond

protected:
    eap::config_provider &m_prov;   ///< EAP method configuration
    winstd::library m_shell32;      ///< shell32.dll resource library reference
    wxIcon m_icon;                  ///< Panel icon
};


class wxEAPProviderLockPanel : public wxEAPProviderLockPanelBase
{
public:
    ///
    /// Constructs a provider lock pannel
    ///
    /// \param[inout] prov    Provider configuration data
    /// \param[in]    parent  Parent window
    ///
    wxEAPProviderLockPanel(eap::config_provider &prov, wxWindow* parent);

protected:
    /// \cond internal
    virtual bool TransferDataToWindow();
    virtual bool TransferDataFromWindow();
    /// \endcond

protected:
    eap::config_provider &m_prov;   ///< EAP method configuration
    winstd::library m_shell32;      ///< shell32.dll resource library reference
    wxIcon m_icon;                  ///< Panel icon
};


class wxEAPConfigProvider : public wxEAPGeneralDialog
{
public:
    ///
    /// Constructs a provider config dialog
    ///
    /// \param[inout] prov    Provider configuration data
    /// \param[in]    parent  Parent window
    ///
    wxEAPConfigProvider(eap::config_provider &prov, wxWindow *parent, wxWindowID id = wxID_ANY, const wxString &title = _("Provider Settings"), const wxPoint &pos = wxDefaultPosition, const wxSize &size = wxDefaultSize, long style = wxDEFAULT_DIALOG_STYLE);

protected:
    eap::config_provider &m_prov;           ///< EAP method configuration
    wxEAPProviderIdentityPanel *m_identity; ///< Provider identity panel
    wxEAPProviderLockPanel *m_lock;         ///< Provider lock panel
};


template <class _Tcred, class _wxT>
class wxEAPCredentialsConfigPanel : public wxEAPCredentialsConfigPanelBase
{
public:
    ///
    /// Constructs a credential configuration panel
    ///
    /// \param[in]    prov           Provider configuration data
    /// \param[inout] cfg            Configuration data
    /// \param[in]    pszCredTarget  Target name of credentials in Windows Credential Manager. Can be further decorated to create final target name.
    /// \param[in]    parent         Parent window
    ///
    wxEAPCredentialsConfigPanel(const eap::config_provider &prov, eap::config_method_with_cred &cfg, LPCTSTR pszCredTarget, wxWindow *parent) :
        m_prov(prov),
        m_cfg(cfg),
        m_target(pszCredTarget),
        m_cred(cfg.m_module),
        wxEAPCredentialsConfigPanelBase(parent)
    {
        // Load and set icon.
        if (m_shell32.load(_T("shell32.dll"), NULL, LOAD_LIBRARY_AS_DATAFILE | LOAD_LIBRARY_AS_IMAGE_RESOURCE))
            wxSetIconFromResource(m_credentials_icon, m_icon, m_shell32, MAKEINTRESOURCE(/*16770*/269));
    }

    ///
    /// Sets keyboard focus to the first control that do not capture mouse wheel
    ///
    inline void SetFocusFromKbd()
    {
        m_own->SetFocusFromKbd();
    }

protected:
    /// \cond internal

    virtual bool TransferDataToWindow()
    {
        if (!m_cfg.m_use_preshared)
            m_own->SetValue(true);
        else
            m_preshared->SetValue(true);

        m_cred = *(_Tcred*)m_cfg.m_preshared.get();

        return wxEAPCredentialsConfigPanelBase::TransferDataToWindow();
    }


    virtual bool TransferDataFromWindow()
    {
        wxCHECK(wxEAPCredentialsConfigPanelBase::TransferDataFromWindow(), false);

        if (!m_prov.m_read_only) {
            // This is not a provider-locked configuration. Save the data.
            m_cfg.m_use_preshared = !m_own->GetValue();
            *m_cfg.m_preshared    = m_cred;
        }

        return true;
    }


    virtual void OnUpdateUI(wxUpdateUIEvent& event)
    {
        UNREFERENCED_PARAMETER(event);
        DWORD dwResult;

        if (m_cfg.m_allow_save) {
            bool has_own;
            std::unique_ptr<CREDENTIAL, winstd::CredFree_delete<CREDENTIAL> > cred;
            if (CredRead(m_cred.target_name(m_target.c_str()).c_str(), CRED_TYPE_GENERIC, 0, (PCREDENTIAL*)&cred)) {
                m_own_identity->SetValue(cred->UserName && cred->UserName[0] != 0 ? cred->UserName : _("<blank>"));
                has_own = true;
            } else if ((dwResult = GetLastError()) == ERROR_NOT_FOUND) {
                m_own_identity->Clear();
                has_own = false;
            } else {
                m_own_identity->SetValue(wxString::Format(_("<error %u>"), dwResult));
                has_own = true;
            }

            if (m_own->GetValue()) {
                m_own_identity->Enable(true);
                m_own_set     ->Enable(true);
                m_own_clear   ->Enable(has_own);
            } else {
                m_own_identity->Enable(false);
                m_own_set     ->Enable(false);
                m_own_clear   ->Enable(false);
            }
        } else {
            m_own_identity->Clear();

            m_own_identity->Enable(false);
            m_own_set     ->Enable(false);
            m_own_clear   ->Enable(false);
        }

        m_preshared_identity->SetValue(!m_cred.empty() ? m_cred.get_name() : _("<blank>"));

        if (m_prov.m_read_only) {
            // This is provider-locked configuration. Disable controls.
            // To avoid run-away selection of radio buttons, disable the selected one last.
            if (m_own->GetValue()) {
                m_preshared->Enable(false);
                m_own      ->Enable(false);
            } else {
                m_own      ->Enable(false);
                m_preshared->Enable(false);
            }
            m_preshared_identity->Enable(false);
            m_preshared_set     ->Enable(false);
        } else {
            // This is not a provider-locked configuration. Selectively enable/disable controls.
            m_own               ->Enable(true);
            m_preshared         ->Enable(true);
            if (m_own->GetValue()) {
                m_preshared_identity->Enable(false);
                m_preshared_set     ->Enable(false);
            } else {
                m_preshared_identity->Enable(true);
                m_preshared_set     ->Enable(true);
            }
        }
    }


    virtual void OnSetOwn(wxCommandEvent& event)
    {
        UNREFERENCED_PARAMETER(event);

        // Read credentials from Credential Manager
        _Tcred cred(m_cfg.m_module);
        try {
            cred.retrieve(m_target.c_str());
        } catch (winstd::win_runtime_error &err) {
            if (err.number() != ERROR_NOT_FOUND)
                wxLogError(winstd::tstring_printf(_("Error reading credentials from Credential Manager: %hs (error %u)"), err.what(), err.number()).c_str());
        } catch (...) {
            wxLogError(_("Reading credentials failed."));
        }

        // Display credential prompt.
        wxEAPCredentialsDialog dlg(m_prov, this);
        _wxT *panel = new _wxT(m_prov, m_cfg, cred, m_target.c_str(), &dlg, true);
        dlg.AddContent(panel);
        if (dlg.ShowModal() == wxID_OK && panel->GetRememberValue()) {
            // Write credentials to credential manager.
            try {
                cred.store(m_target.c_str());
            } catch (winstd::win_runtime_error &err) {
                wxLogError(winstd::tstring_printf(_("Error writing credentials to Credential Manager: %hs (error %u)"), err.what(), err.number()).c_str());
            } catch (...) {
                wxLogError(_("Writing credentials failed."));
            }
        }
    }


    virtual void OnClearOwn(wxCommandEvent& event)
    {
        UNREFERENCED_PARAMETER(event);

        if (!CredDelete(m_cred.target_name(m_target.c_str()).c_str(), CRED_TYPE_GENERIC, 0))
            wxLogError(_("Deleting credentials failed (error %u)."), GetLastError());
    }


    virtual void OnSetPreshared(wxCommandEvent& event)
    {
        UNREFERENCED_PARAMETER(event);

        wxEAPCredentialsDialog dlg(m_prov, this);

        _wxT *panel = new _wxT(m_prov, m_cfg, m_cred, _T(""), &dlg, true);

        dlg.AddContent(panel);
        dlg.ShowModal();
    }

    /// \endcond

protected:
    const eap::config_provider &m_prov;     ///< EAP provider
    eap::config_method_with_cred &m_cfg;    ///< EAP method configuration
    winstd::library m_shell32;              ///< shell32.dll resource library reference
    wxIcon m_icon;                          ///< Panel icon
    winstd::tstring m_target;               ///< Credential Manager target

private:
    _Tcred m_cred;                          ///< Temporary credential data
};


template <class _Tcred, class _Tbase>
class wxEAPCredentialsPanelBase : public _Tbase
{
private:
    /// \cond internal
    typedef wxEAPCredentialsPanelBase<_Tcred, _Tbase> _Tthis;
    /// \endcond

public:
    ///
    /// Constructs a credentials panel
    ///
    /// \param[in]    prov           Provider configuration data
    /// \param[in]    cfg            Configuration data
    /// \param[inout] cred           Credentials data
    /// \param[in]    pszCredTarget  Target name of credentials in Windows Credential Manager. Can be further decorated to create final target name.
    /// \param[in]    parent         Parent window
    /// \param[in]    is_config      Is this panel used to pre-enter credentials? When \c true, the "Remember" checkbox is always selected and disabled.
    ///
    wxEAPCredentialsPanelBase(const eap::config_provider &prov, const eap::config_method_with_cred &cfg, _Tcred &cred, LPCTSTR pszCredTarget, wxWindow* parent, bool is_config = false) :
        m_prov(prov),
        m_cfg(cfg),
        m_cred(cred),
        m_target(pszCredTarget),
        m_is_config(is_config),
        _Tbase(parent)
    {
        this->Connect(wxEVT_UPDATE_UI, wxUpdateUIEventHandler(_Tthis::OnUpdateUI));
    }

    virtual ~wxEAPCredentialsPanelBase()
    {
        this->Disconnect(wxEVT_UPDATE_UI, wxUpdateUIEventHandler(_Tthis::OnUpdateUI));
    }

    inline void SetRememberValue(bool val)
    {
        return m_remember->SetValue(val);
    }

    inline bool GetRememberValue() const
    {
        return m_remember->GetValue();
    }

protected:
    /// \cond internal

    virtual void OnUpdateUI(wxUpdateUIEvent& event)
    {
        UNREFERENCED_PARAMETER(event);

        if (m_is_config) {
            // Configuration mode
            // Always store credentials (somewhere).
            m_remember->SetValue(true);
            m_remember->Enable(false);
        } else if (m_cfg.m_use_preshared) {
            // Credential prompt mode & Using pre-shared credentials
            m_remember->SetValue(false);
            m_remember->Enable(false);
        } else if (!m_cfg.m_allow_save) {
            // Credential prompt mode & using own credentials & saving is not allowed
            m_remember->SetValue(false);
            m_remember->Enable(false);
        }
    }

    /// \endcond

protected:
    const eap::config_provider &m_prov;         ///< Provider configuration
    const eap::config_method_with_cred &m_cfg;  ///< Method configuration
    _Tcred &m_cred;                             ///< Credentials
    winstd::tstring m_target;                   ///< Credential Manager target
    bool m_is_config;                           ///< Is this a configuration dialog?
};


template <class _Tcred, class _Tbase>
class wxPasswordCredentialsPanel : public wxEAPCredentialsPanelBase<_Tcred, _Tbase>
{
public:
    ///
    /// Constructs a password credentials panel
    ///
    /// \param[in]    prov           Provider configuration data
    /// \param[in]    cfg            Configuration data
    /// \param[inout] cred           Credentials data
    /// \param[in]    pszCredTarget  Target name of credentials in Windows Credential Manager. Can be further decorated to create final target name.
    /// \param[in]    parent         Parent window
    /// \param[in]    is_config      Is this panel used to pre-enter credentials? When \c true, the "Remember" checkbox is always selected and disabled.
    ///
    wxPasswordCredentialsPanel(const eap::config_provider &prov, const eap::config_method_with_cred &cfg, _Tcred &cred, LPCTSTR pszCredTarget, wxWindow* parent, bool is_config = false) :
        wxEAPCredentialsPanelBase<_Tcred, _Tbase>(prov, cfg, cred, pszCredTarget, parent, is_config)
    {
        // Load and set icon.
        if (m_shell32.load(_T("shell32.dll"), NULL, LOAD_LIBRARY_AS_DATAFILE | LOAD_LIBRARY_AS_IMAGE_RESOURCE))
            wxSetIconFromResource(m_credentials_icon, m_icon, m_shell32, MAKEINTRESOURCE(269));

        bool layout = false;
        if (!m_prov.m_lbl_alt_credential.empty()) {
            m_credentials_label->SetLabel(m_prov.m_lbl_alt_credential);
            m_credentials_label->Wrap( 446 );
            layout = true;
        }

        if (!m_prov.m_lbl_alt_identity.empty()) {
            m_identity_label->SetLabel(m_prov.m_lbl_alt_identity);
            layout = true;
        }

        if (!m_prov.m_lbl_alt_password.empty()) {
            m_password_label->SetLabel(m_prov.m_lbl_alt_password);
            layout = true;
        }

        if (layout)
            this->Layout();
    }

protected:
    /// \cond internal

    virtual bool TransferDataToWindow()
    {
        m_identity->SetValue(m_cred.m_identity);
        m_identity->SetSelection(0, -1);
        m_password->SetValue(m_cred.m_password.empty() ? wxEmptyString : s_dummy_password);

        return wxEAPCredentialsPanelBase<_Tcred, wxEAPCredentialsPassPanelBase>::TransferDataToWindow();
    }

    virtual bool TransferDataFromWindow()
    {
        if (!wxEAPCredentialsPanelBase<_Tcred, wxEAPCredentialsPassPanelBase>::TransferDataFromWindow())
            return false;

        m_cred.m_identity = m_identity->GetValue();
        wxString pass = m_password->GetValue();
        if (pass.compare(s_dummy_password) != 0) {
            m_cred.m_password = pass;
            pass.assign(pass.length(), wxT('*'));
        }

        return true;
    }

    virtual void OnUpdateUI(wxUpdateUIEvent& event)
    {
        if (!m_is_config && m_cfg.m_use_preshared) {
            // Credential prompt mode & Using pre-shared credentials
            m_identity_label->Enable(false);
            m_identity      ->Enable(false);
            m_password_label->Enable(false);
            m_password      ->Enable(false);
        }

        wxEAPCredentialsPanelBase<_Tcred, wxEAPCredentialsPassPanelBase>::OnUpdateUI(event);
    }

    /// \endcond

protected:
    winstd::library m_shell32;      ///< shell32.dll resource library reference
    wxIcon m_icon;                  ///< Panel icon

private:
    static const wxStringCharType *s_dummy_password;
};

template <class _Tcred, class _Tbase>
const wxStringCharType *wxPasswordCredentialsPanel<_Tcred, _Tbase>::s_dummy_password = wxT("dummypass");


inline wxIcon wxLoadIconFromResource(HINSTANCE hinst, PCWSTR pszName, int cx, int cy)
{
    HICON hIcon;
    if (SUCCEEDED(LoadIconWithScaleDown(hinst, pszName, cx, cy, &hIcon))) {
        wxIcon icon;
        icon.CreateFromHICON(hIcon);
        return icon;
    } else
        return wxNullIcon;
}


inline wxIcon wxLoadIconFromResource(HINSTANCE hinst, PCWSTR pszName, const wxSize &size)
{
    HICON hIcon;
    if (SUCCEEDED(LoadIconWithScaleDown(hinst, pszName, size.GetWidth(), size.GetHeight(), &hIcon))) {
        wxIcon icon;
        icon.CreateFromHICON(hIcon);
        return icon;
    } else
        return wxNullIcon;
}


inline bool wxSetIconFromResource(wxStaticBitmap *bmp, wxIcon &icon, HINSTANCE hinst, PCWSTR pszName)
{
    wxASSERT(bmp);

    icon = wxLoadIconFromResource(hinst, pszName, GetSystemMetrics(SM_CXICON), GetSystemMetrics(SM_CYICON));
    if (icon.IsOk()) {
        bmp->SetIcon(icon);
        return true;
    } else
        return false;
}


inline bool wxSetIconFromResource(wxAuiToolBarItem *item, wxIcon &icon, HINSTANCE hinst, PCWSTR pszName, const wxSize &size)
{
    wxASSERT(item);

    icon = wxLoadIconFromResource(hinst, pszName, size.GetWidth(), size.GetHeight());
    if (icon.IsOk()) {
        item->SetBitmap(icon);
        item->SetDisabledBitmap(wxBitmap(icon).ConvertToDisabled());
        return true;
    } else
        return false;
}


inline bool wxSetIconFromResource(wxMenuItem *item, wxIcon &icon, HINSTANCE hinst, PCWSTR pszName)
{
    wxASSERT(item);

    icon = wxLoadIconFromResource(hinst, pszName, GetSystemMetrics(SM_CXSMICON), GetSystemMetrics(SM_CYSMICON));
    if (icon.IsOk()) {
        item->SetBitmaps(icon);
        return true;
    } else
        return false;
}


inline wxString wxEAPGetProviderName(const std::wstring &id)
{
    return
        !id.empty() ? id : _("<Your Organization>");
}


namespace eap
{
    class monitor_ui
    {
    public:
        monitor_ui(_In_ HINSTANCE module, _In_ const GUID &guid);
        virtual ~monitor_ui();

        void set_popup(_In_ HWND hwnd);
        void release_slaves(_In_bytecount_(size) const void *data, _In_ size_t size) const;

        inline bool is_master() const
        {
            return m_is_master;
        }

        inline bool is_slave() const
        {
            return !is_master();
        }

        inline const std::vector<unsigned char>& master_data() const
        {
            return m_data;
        }

    protected:
        virtual LRESULT winproc(
            _In_ UINT   msg,
            _In_ WPARAM wparam,
            _In_ LPARAM lparam);

        static LRESULT CALLBACK winproc(
            _In_ HWND   hwnd,
            _In_ UINT   msg,
            _In_ WPARAM wparam,
            _In_ LPARAM lparam);

    protected:
        bool m_is_master;                   ///< Is this monitor master?
        HWND m_hwnd;                        ///< Message window handle
        std::list<HWND> m_slaves;           ///< List of slaves to notify on finish
        HWND m_hwnd_popup;                  ///< Pop-up window handle
        std::vector<unsigned char> m_data;  ///< Data master sent

        // Custom window messages
        static const UINT s_msg_attach;     ///< Slave sends this message to attach to master
        static const UINT s_msg_finish;     ///< Master sends this message to slaves to notify them it has finished (wparam has size, lparam has data)
    };
}
