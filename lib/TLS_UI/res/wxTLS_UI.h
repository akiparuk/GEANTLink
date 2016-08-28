﻿///////////////////////////////////////////////////////////////////////////
// C++ code generated with wxFormBuilder (version Jun 17 2015)
// http://www.wxformbuilder.org/
//
// PLEASE DO "NOT" EDIT THIS FILE!
///////////////////////////////////////////////////////////////////////////

#ifndef __WXTLS_UI_H__
#define __WXTLS_UI_H__

#include <wx/artprov.h>
#include <wx/xrc/xmlres.h>
#include <wx/intl.h>
#include <wx/bitmap.h>
#include <wx/image.h>
#include <wx/icon.h>
#include <wx/statbmp.h>
#include <wx/gdicmn.h>
#include <wx/font.h>
#include <wx/colour.h>
#include <wx/settings.h>
#include <wx/string.h>
#include <wx/stattext.h>
#include <wx/listbox.h>
#include <wx/button.h>
#include <wx/sizer.h>
#include <wx/textctrl.h>
#include <wx/statbox.h>
#include <wx/panel.h>
#include <wx/radiobut.h>
#include <wx/choice.h>
#include <wx/checkbox.h>

///////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
/// Class wxEAPTLSServerTrustConfigPanelBase
///////////////////////////////////////////////////////////////////////////////
class wxEAPTLSServerTrustConfigPanelBase : public wxPanel 
{
	private:
	
	protected:
		wxStaticBitmap* m_server_trust_icon;
		wxStaticText* m_server_trust_label;
		wxStaticText* m_root_ca_lbl;
		wxListBox* m_root_ca;
		wxButton* m_root_ca_add_store;
		wxButton* m_root_ca_add_file;
		wxButton* m_root_ca_remove;
		wxStaticText* m_server_names_label;
		wxTextCtrl* m_server_names;
		wxStaticText* m_server_names_note;
		
		// Virtual event handlers, overide them in your derived class
		virtual void OnUpdateUI( wxUpdateUIEvent& event ) { event.Skip(); }
		virtual void OnRootCADClick( wxCommandEvent& event ) { event.Skip(); }
		virtual void OnRootCAAddStore( wxCommandEvent& event ) { event.Skip(); }
		virtual void OnRootCAAddFile( wxCommandEvent& event ) { event.Skip(); }
		virtual void OnRootCARemove( wxCommandEvent& event ) { event.Skip(); }
		
	
	public:
		
		wxEAPTLSServerTrustConfigPanelBase( wxWindow* parent, wxWindowID id = wxID_ANY, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxSize( 500,-1 ), long style = wxTAB_TRAVERSAL ); 
		~wxEAPTLSServerTrustConfigPanelBase();
	
};

///////////////////////////////////////////////////////////////////////////////
/// Class wxTLSCredentialsPanelBase
///////////////////////////////////////////////////////////////////////////////
class wxTLSCredentialsPanelBase : public wxPanel 
{
	private:
	
	protected:
		wxStaticBitmap* m_credentials_icon;
		wxStaticText* m_credentials_label;
		wxRadioButton* m_cert_none;
		wxRadioButton* m_cert_select;
		wxChoice* m_cert_select_val;
		wxStaticText* m_identity_label;
		wxTextCtrl* m_identity;
		wxStaticText* m_identity_note;
		wxCheckBox* m_remember;
		
		// Virtual event handlers, overide them in your derived class
		virtual void OnUpdateUI( wxUpdateUIEvent& event ) { event.Skip(); }
		
	
	public:
		
		wxTLSCredentialsPanelBase( wxWindow* parent, wxWindowID id = wxID_ANY, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxSize( 500,-1 ), long style = wxTAB_TRAVERSAL ); 
		~wxTLSCredentialsPanelBase();
	
};

#endif //__WXTLS_UI_H__
