#
#    Copyright 1991-2016 Amebis
#    Copyright 2016 GÉANT
#
#    This file is part of GÉANTLink.
#
#    GÉANTLink is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    GÉANTLink is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with GÉANTLink. If not, see <http://www.gnu.org/licenses/>.
#

!INCLUDE "include\MSIBuildCfg.mak"

PRODUCT_NAME=GEANTLink
OUTPUT_DIR=output
PUBLISH_PACKAGE_DIR=..\dist\master

!IF "$(PROCESSOR_ARCHITECTURE)" == "AMD64"
PLAT=x64
REG_FLAGS=/f /reg:64
REG_FLAGS32=/f /reg:32
!ELSE
PLAT=Win32
REG_FLAGS=/f
!ENDIF

EVENT_CHANNEL_OPERATIONAL_ENABLED=0
EVENT_CHANNEL_ANALYTIC_ENABLED=0


All ::

Clean :: \
	CleanSetup
	devenv.com "VS10Solution.sln" /clean "Release|Win32"
	devenv.com "VS10Solution.sln" /clean "Debug|Win32"
	devenv.com "VS10Solution.sln" /clean "Release|x64"
	devenv.com "VS10Solution.sln" /clean "Debug|x64"
	-if exist "$(OUTPUT_DIR)\locale\ca_ES\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\ca_ES\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\cs_CZ\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\cs_CZ\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\de_DE\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\de_DE\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\el_GR\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\el_GR\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\es_ES\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\es_ES\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\eu_ES\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\eu_ES\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\fi_FI\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\fi_FI\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\fr_CA\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\fr_CA\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\fr_FR\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\fr_FR\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\gl_ES\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\gl_ES\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\hu_HU\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\hu_HU\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\it_IT\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\it_IT\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\ko_KR\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\ko_KR\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\lt_LT\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\lt_LT\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\nb_NO\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\nb_NO\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\nl_NL\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\nl_NL\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\pl_PL\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\pl_PL\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\pt_PT\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\pt_PT\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\ru_RU\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\ru_RU\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\sk_SK\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\sk_SK\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\sl_SI\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\sl_SI\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\sv_SE\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\sv_SE\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\tr_TR\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\tr_TR\wxstd.mo"
	-if exist "$(OUTPUT_DIR)\locale\vi_VN\wxstd.mo"        del /f /q "$(OUTPUT_DIR)\locale\vi_VN\wxstd.mo"

CleanSetup ::
	cd "MSI\MSIBuild\Version"
	$(MAKE) /f "Makefile" /$(MAKEFLAGS) Clean
	cd "$(MAKEDIR)"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)32.ddf"        del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)32.ddf"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.ddf"       del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.ddf"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)64.ddf"        del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)64.ddf"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.ddf"       del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.ddf"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)32.cab"        del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)32.cab"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)32.inf"        del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)32.inf"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)32.rpt"        del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)32.rpt"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.cab"       del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.cab"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.inf"       del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.inf"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.rpt"       del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.rpt"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)64.cab"        del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)64.cab"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)64.inf"        del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)64.inf"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)64.rpt"        del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)64.rpt"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.cab"       del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.cab"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.inf"       del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.inf"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.rpt"       del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.rpt"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)32.sign"       del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)32.sign"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.sign"      del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.sign"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)64.sign"       del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)64.sign"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.sign"      del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.sign"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)32.msi"        del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)32.msi"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.msi"       del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.msi"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)64.msi"        del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)64.msi"
	-if exist "$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.msi"       del /f /q "$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.msi"
	-if exist "$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)32.msi"  del /f /q "$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)32.msi"
	-if exist "$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)32D.msi" del /f /q "$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)32D.msi"
	-if exist "$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)64.msi"  del /f /q "$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)64.msi"
	-if exist "$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)64D.msi" del /f /q "$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)64D.msi"
	-if exist "$(OUTPUT_DIR)\Setup\CredWrite.exe"          del /f /q "$(OUTPUT_DIR)\Setup\CredWrite.exe"
	-if exist "$(OUTPUT_DIR)\Setup\MsiUseFeature.exe"      del /f /q "$(OUTPUT_DIR)\Setup\MsiUseFeature.exe"
	-if exist "$(OUTPUT_DIR)\Setup\WLANManager-Win32.exe"  del /f /q "$(OUTPUT_DIR)\Setup\WLANManager-Win32.exe"
	-if exist "$(OUTPUT_DIR)\Setup\WLANManager-x64.exe"    del /f /q "$(OUTPUT_DIR)\Setup\WLANManager-x64.exe"


######################################################################
# Version info parsing
######################################################################

All \
Setup \
SetupDebug \
Publish :: "MSI\MSIBuild\Version\Version.mak"

"MSI\MSIBuild\Version\Version.mak" ::
	cd "MSI\MSIBuild\Version"
	$(MAKE) /f "Makefile" /$(MAKEFLAGS) Version
	cd "$(MAKEDIR)"


######################################################################
# Default target
######################################################################

All :: \
	Setup


######################################################################
# Private/public RSA key-pair generation
######################################################################

GenRSAKeypair :: \
	"include\KeyPrivate.bin" \
	"include\KeyPublic.bin"

"include\KeyPrivate.bin" :
	if exist $@ del /f /q $@
	if exist "$(@:"=).tmp" del /f /q "$(@:"=).tmp"
	openssl.exe genrsa 2048 | openssl.exe rsa -inform PEM -outform DER -out "$(@:"=).tmp"
	move /y "$(@:"=).tmp" $@ > NUL

"include\KeyPublic.bin" : "include\KeyPrivate.bin"
	if exist $@ del /f /q $@
	if exist "$(@:"=).tmp" del /f /q "$(@:"=).tmp"
	openssl.exe rsa -in $** -inform DER -outform DER -out "$(@:"=).tmp" -pubout
	move /y "$(@:"=).tmp" $@ > NUL


######################################################################
# Setup
######################################################################

Setup :: \
	"$(OUTPUT_DIR)\Setup" \
	"$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)32.msi" \
	"$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)64.msi" \
	"$(OUTPUT_DIR)\Setup\CredWrite.exe" \
	"$(OUTPUT_DIR)\Setup\MsiUseFeature.exe" \
	"$(OUTPUT_DIR)\Setup\WLANManager-Win32.exe" \
	"$(OUTPUT_DIR)\Setup\WLANManager-x64.exe"

SetupDebug :: \
	"$(OUTPUT_DIR)\Setup" \
	"$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)32D.msi" \
	"$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)64D.msi"


######################################################################
# Publishing
######################################################################

Publish :: \
	"$(PUBLISH_PACKAGE_DIR)" \
	"$(PUBLISH_PACKAGE_DIR)\$(PRODUCT_NAME)32.msi" \
	"$(PUBLISH_PACKAGE_DIR)\$(PRODUCT_NAME)64.msi" \
	"$(PUBLISH_PACKAGE_DIR)\CredWrite.exe" \
	"$(PUBLISH_PACKAGE_DIR)\MsiUseFeature.exe" \
	"$(PUBLISH_PACKAGE_DIR)\WLANManager-Win32.exe" \
	"$(PUBLISH_PACKAGE_DIR)\WLANManager-x64.exe"


######################################################################
# Registration
######################################################################

Register :: \
	StopServices \
	RegisterSettings \
	RegisterDLLs \
	StartServices \
	RegisterShortcuts

Unregister :: \
	UnregisterShortcuts \
	StopServices \
	UnregisterDLLs \
	UnregisterSettings \
	StartServices

StartServices ::
	cmd.exe /c <<"$(TEMP)\start_EapHost.bat"
@echo off
net.exe start EapHost
if errorlevel 3 exit %errorlevel%
if errorlevel 2 exit 0
exit %errorlevel%
<<NOKEEP
# Enable dot3svc service (Wired AutoConfig) and start it
	sc.exe config dot3svc start= auto
	cmd.exe /c <<"$(TEMP)\start_dot3svc.bat"
@echo off
net.exe start dot3svc
if errorlevel 3 exit %errorlevel%
if errorlevel 2 exit 0
exit %errorlevel%
<<NOKEEP
# Enable Wlansvc service (WLAN AutoConfig) and start it
	sc.exe config Wlansvc start= auto
	cmd.exe /c <<"$(TEMP)\start_Wlansvc.bat"
@echo off
net.exe start Wlansvc
if errorlevel 3 exit %errorlevel%
if errorlevel 2 exit 0
exit %errorlevel%
<<NOKEEP

StopServices ::
	-net.exe stop Wlansvc
	-net.exe stop dot3svc
	-net.exe stop EapHost

RegisterSettings ::
	reg.exe add "HKLM\Software\$(MSIBUILD_VENDOR_NAME)\$(MSIBUILD_PRODUCT_NAME)" /v "LocalizationRepositoryPath" /t REG_SZ /d "$(MAKEDIR)\$(OUTPUT_DIR)\locale" $(REG_FLAGS) > NUL
!IF "$(PROCESSOR_ARCHITECTURE)" == "AMD64"
	reg.exe add "HKLM\Software\$(MSIBUILD_VENDOR_NAME)\$(MSIBUILD_PRODUCT_NAME)" /v "LocalizationRepositoryPath" /t REG_SZ /d "$(MAKEDIR)\$(OUTPUT_DIR)\locale" $(REG_FLAGS32) > NUL
!ENDIF

UnregisterSettings ::
	-reg.exe delete "HKLM\Software\$(MSIBUILD_VENDOR_NAME)\$(MSIBUILD_PRODUCT_NAME)" /v "LocalizationRepositoryPath" $(REG_FLAGS) > NUL
!IF "$(PROCESSOR_ARCHITECTURE)" == "AMD64"
	-reg.exe delete "HKLM\Software\$(MSIBUILD_VENDOR_NAME)\$(MSIBUILD_PRODUCT_NAME)" /v "LocalizationRepositoryPath" $(REG_FLAGS32) > NUL
!ENDIF

RegisterDLLs :: \
	"$(OUTPUT_DIR)\$(PLAT).Debug\Events.dll" \
	"$(OUTPUT_DIR)\$(PLAT).Debug\EAPTTLS.dll" \
	"$(OUTPUT_DIR)\$(PLAT).Debug\EAPTTLSUI.dll"
#	wevtutil.exe im "lib\Events\res\EventsETW.man" /rf:"$(MAKEDIR)\$(OUTPUT_DIR)\$(PLAT).Debug\Events.dll" /mf:"$(MAKEDIR)\$(OUTPUT_DIR)\$(PLAT).Debug\Events.dll"
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}"                               /ve                           /t REG_SZ    /d "$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod"             /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}"                               /v "MessageFileName"          /t REG_SZ    /d "$(MAKEDIR)\$(OUTPUT_DIR)\$(PLAT).Debug\Events.dll"                      /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}"                               /v "ResourceFileName"         /t REG_SZ    /d "$(MAKEDIR)\$(OUTPUT_DIR)\$(PLAT).Debug\Events.dll"                      /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}"                               /v "Enabled"                  /t REG_DWORD /d 1                                                                        /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational" /v "OwningPublisher"          /t REG_SZ    /d "{3f65af01-ce8f-4c7d-990b-673b244aac7b}"                                 /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational" /v "Enabled"                  /t REG_DWORD /d "$(EVENT_CHANNEL_OPERATIONAL_ENABLED)"                                   /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational" /v "Isolation"                /t REG_DWORD /d 0                                                                        /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational" /v "ChannelAccess"            /t REG_SZ    /d "O:BAG:SYD:(A;;0xf0007;;;SY)(A;;0x7;;;BA)(A;;0x7;;;SO)(A;;0x3;;;IU)(A;;0x3;;;SU)(A;;0x3;;;S-1-5-3)(A;;0x3;;;S-1-5-33)(A;;0x1;;;S-1-5-32-573)" /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational" /v "MaxSize"                  /t REG_DWORD /d 1048576                                                                  /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational" /v "MaxSizeUpper"             /t REG_DWORD /d 0                                                                        /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational" /v "Retention"                /t REG_DWORD /d 0                                                                        /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational" /v "AutoBackupLogFiles"       /t REG_DWORD /d 0                                                                        /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational" /v "Type"                     /t REG_DWORD /d 1                                                                        /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Analytic"    /v "OwningPublisher"          /t REG_SZ    /d "{3f65af01-ce8f-4c7d-990b-673b244aac7b}"                                 /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Analytic"    /v "Enabled"                  /t REG_DWORD /d "$(EVENT_CHANNEL_ANALYTIC_ENABLED)"                                      /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Analytic"    /v "Isolation"                /t REG_DWORD /d 0                                                                        /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Analytic"    /v "ChannelAccess"            /t REG_SZ    /d "O:BAG:SYD:(A;;0xf0007;;;SY)(A;;0x7;;;BA)(A;;0x7;;;SO)(A;;0x3;;;IU)(A;;0x3;;;SU)(A;;0x3;;;S-1-5-3)(A;;0x3;;;S-1-5-33)(A;;0x1;;;S-1-5-32-573)" /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Analytic"    /v "MaxSize"                  /t REG_DWORD /d 1048576                                                                  /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Analytic"    /v "MaxSizeUpper"             /t REG_DWORD /d 0                                                                        /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Analytic"    /v "Retention"                /t REG_DWORD /d 4294967295                                                               /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Analytic"    /v "Type"                     /t REG_DWORD /d 2                                                                        /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}\ChannelReferences\0"           /ve                           /t REG_SZ    /d "$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Operational" /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}\ChannelReferences\0"           /v "Id"                       /t REG_DWORD /d 16                                                                       /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}\ChannelReferences\0"           /v "Flags"                    /t REG_DWORD /d 0                                                                        /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}\ChannelReferences\1"           /ve                           /t REG_SZ    /d "$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod/Analytic"    /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}\ChannelReferences\1"           /v "Id"                       /t REG_DWORD /d 17                                                                       /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}\ChannelReferences\1"           /v "Flags"                    /t REG_DWORD /d 0                                                                        /f > NUL
	reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}\ChannelReferences"             /v "Count"                    /t REG_DWORD /d 2                                                                        /f > NUL
	reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532"                                                                          /ve                           /t REG_SZ    /d "$(MSIBUILD_PRODUCT_NAME)"                                               /f > NUL
	reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532\21"                                                                       /v "PeerDllPath"              /t REG_SZ    /d "$(MAKEDIR)\$(OUTPUT_DIR)\$(PLAT).Debug\EAPTTLS.dll"                     /f > NUL
	reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532\21"                                                                       /v "PeerConfigUIPath"         /t REG_SZ    /d "$(MAKEDIR)\$(OUTPUT_DIR)\$(PLAT).Debug\EAPTTLSUI.dll"                   /f > NUL
	reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532\21"                                                                       /v "PeerIdentityPath"         /t REG_SZ    /d "$(MAKEDIR)\$(OUTPUT_DIR)\$(PLAT).Debug\EAPTTLSUI.dll"                   /f > NUL
	reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532\21"                                                                       /v "PeerInteractiveUIPath"    /t REG_SZ    /d "$(MAKEDIR)\$(OUTPUT_DIR)\$(PLAT).Debug\EAPTTLSUI.dll"                   /f > NUL
	reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532\21"                                                                       /v "PeerFriendlyName"         /t REG_SZ    /d "@$(MAKEDIR)\$(OUTPUT_DIR)\$(PLAT).Debug\EAPTTLS.dll,-1"                 /f > NUL
	reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532\21"                                                                       /v "PeerInvokePasswordDialog" /t REG_DWORD /d 0                                                                        /f > NUL
	reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532\21"                                                                       /v "PeerInvokeUsernameDialog" /t REG_DWORD /d 0                                                                        /f > NUL
	reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532\21"                                                                       /v "Properties"               /t REG_DWORD /d 389871807                                                                /f > NUL

UnregisterDLLs ::
	-reg.exe delete "HKLM\SYSTEM\CurrentControlSet\services\EapHost\Methods\67532"                                                              /f > NUL
	-reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\$(MSIBUILD_VENDOR_NAME)-$(MSIBUILD_PRODUCT_NAME)-EAPMethod" /f > NUL
	-reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{3f65af01-ce8f-4c7d-990b-673b244aac7b}"                   /f > NUL
#	-wevtutil.exe um "lib\Events\res\EventsETW.man"

RegisterShortcuts :: \
	"$(PROGRAMDATA)\Microsoft\Windows\Start Menu\Programs\$(MSIBUILD_PRODUCT_NAME)" \
	"$(PROGRAMDATA)\Microsoft\Windows\Start Menu\Programs\$(MSIBUILD_PRODUCT_NAME)\$(MSIBUILD_PRODUCT_NAME) Event Monitor.lnk"

UnregisterShortcuts ::
	-if exist "$(PROGRAMDATA)\Microsoft\Windows\Start Menu\Programs\$(MSIBUILD_PRODUCT_NAME)" rd /s /q "$(PROGRAMDATA)\Microsoft\Windows\Start Menu\Programs\$(MSIBUILD_PRODUCT_NAME)"


######################################################################
# Localization
######################################################################

Localization :: \
	"$(OUTPUT_DIR)\locale\ca_ES" \
	"$(OUTPUT_DIR)\locale\ca_ES\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\cs_CZ" \
	"$(OUTPUT_DIR)\locale\cs_CZ\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\de_DE" \
	"$(OUTPUT_DIR)\locale\de_DE\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\el_GR" \
	"$(OUTPUT_DIR)\locale\el_GR\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\es_ES" \
	"$(OUTPUT_DIR)\locale\es_ES\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\eu_ES" \
	"$(OUTPUT_DIR)\locale\eu_ES\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\fi_FI" \
	"$(OUTPUT_DIR)\locale\fi_FI\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\fr_CA" \
	"$(OUTPUT_DIR)\locale\fr_CA\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\fr_FR" \
	"$(OUTPUT_DIR)\locale\fr_FR\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\gl_ES" \
	"$(OUTPUT_DIR)\locale\gl_ES\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\hu_HU" \
	"$(OUTPUT_DIR)\locale\hu_HU\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\it_IT" \
	"$(OUTPUT_DIR)\locale\it_IT\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\ko_KR" \
	"$(OUTPUT_DIR)\locale\ko_KR\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\lt_LT" \
	"$(OUTPUT_DIR)\locale\lt_LT\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\nb_NO" \
	"$(OUTPUT_DIR)\locale\nb_NO\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\nl_NL" \
	"$(OUTPUT_DIR)\locale\nl_NL\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\pl_PL" \
	"$(OUTPUT_DIR)\locale\pl_PL\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\pt_PT" \
	"$(OUTPUT_DIR)\locale\pt_PT\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\ru_RU" \
	"$(OUTPUT_DIR)\locale\ru_RU\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\sk_SK" \
	"$(OUTPUT_DIR)\locale\sk_SK\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\sl_SI" \
	"$(OUTPUT_DIR)\locale\sl_SI\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\sv_SE" \
	"$(OUTPUT_DIR)\locale\sv_SE\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\tr_TR" \
	"$(OUTPUT_DIR)\locale\tr_TR\wxstd.mo" \
	"$(OUTPUT_DIR)\locale\vi_VN" \
	"$(OUTPUT_DIR)\locale\vi_VN\wxstd.mo"

LocalizationImport : \
	"EAPMethods\locale\bg_BG.po" \
	"EAPMethods\locale\ca_ES.po" \
	"EAPMethods\locale\cs_CZ.po" \
	"EAPMethods\locale\cy_UK.po" \
	"EAPMethods\locale\de_DE.po" \
	"EAPMethods\locale\el_GR.po" \
	"EAPMethods\locale\es_ES.po" \
	"EAPMethods\locale\eu_ES.po" \
	"EAPMethods\locale\fi_FI.po" \
	"EAPMethods\locale\fr_CA.po" \
	"EAPMethods\locale\fr_FR.po" \
	"EAPMethods\locale\gl_ES.po" \
	"EAPMethods\locale\hr_HR.po" \
	"EAPMethods\locale\hu_HU.po" \
	"EAPMethods\locale\is_IS.po" \
	"EAPMethods\locale\it_IT.po" \
	"EAPMethods\locale\lt_LT.po" \
	"EAPMethods\locale\nb_NO.po" \
	"EAPMethods\locale\nl_NL.po" \
	"EAPMethods\locale\pl_PL.po" \
	"EAPMethods\locale\pt_PT.po" \
	"EAPMethods\locale\ru_RU.po" \
	"EAPMethods\locale\sk_SK.po" \
	"EAPMethods\locale\sl_SI.po" \
	"EAPMethods\locale\sr_RS.po" \
	"EAPMethods\locale\sv_SE.po" \
	"EAPMethods\locale\tr_TR.po" \
	"EAPMethods\locale\vi_VN.po" \
	"EventMonitor\locale\bg_BG.po" \
	"EventMonitor\locale\ca_ES.po" \
	"EventMonitor\locale\cs_CZ.po" \
	"EventMonitor\locale\cy_UK.po" \
	"EventMonitor\locale\de_DE.po" \
	"EventMonitor\locale\el_GR.po" \
	"EventMonitor\locale\es_ES.po" \
	"EventMonitor\locale\eu_ES.po" \
	"EventMonitor\locale\fi_FI.po" \
	"EventMonitor\locale\fr_CA.po" \
	"EventMonitor\locale\fr_FR.po" \
	"EventMonitor\locale\gl_ES.po" \
	"EventMonitor\locale\hr_HR.po" \
	"EventMonitor\locale\hu_HU.po" \
	"EventMonitor\locale\is_IS.po" \
	"EventMonitor\locale\it_IT.po" \
	"EventMonitor\locale\lt_LT.po" \
	"EventMonitor\locale\nb_NO.po" \
	"EventMonitor\locale\nl_NL.po" \
	"EventMonitor\locale\pl_PL.po" \
	"EventMonitor\locale\pt_PT.po" \
	"EventMonitor\locale\ru_RU.po" \
	"EventMonitor\locale\sk_SK.po" \
	"EventMonitor\locale\sl_SI.po" \
	"EventMonitor\locale\sr_RS.po" \
	"EventMonitor\locale\sv_SE.po" \
	"EventMonitor\locale\tr_TR.po" \
	"EventMonitor\locale\vi_VN.po" \
	"lib\wxExtend\locale\bg_BG.po" \
	"lib\wxExtend\locale\ca_ES.po" \
	"lib\wxExtend\locale\cs_CZ.po" \
	"lib\wxExtend\locale\cy_UK.po" \
	"lib\wxExtend\locale\de_DE.po" \
	"lib\wxExtend\locale\el_GR.po" \
	"lib\wxExtend\locale\es_ES.po" \
	"lib\wxExtend\locale\eu_ES.po" \
	"lib\wxExtend\locale\fi_FI.po" \
	"lib\wxExtend\locale\fr_CA.po" \
	"lib\wxExtend\locale\fr_FR.po" \
	"lib\wxExtend\locale\gl_ES.po" \
	"lib\wxExtend\locale\hr_HR.po" \
	"lib\wxExtend\locale\hu_HU.po" \
	"lib\wxExtend\locale\is_IS.po" \
	"lib\wxExtend\locale\it_IT.po" \
	"lib\wxExtend\locale\lt_LT.po" \
	"lib\wxExtend\locale\nb_NO.po" \
	"lib\wxExtend\locale\nl_NL.po" \
	"lib\wxExtend\locale\pl_PL.po" \
	"lib\wxExtend\locale\pt_PT.po" \
	"lib\wxExtend\locale\ru_RU.po" \
	"lib\wxExtend\locale\sk_SK.po" \
	"lib\wxExtend\locale\sl_SI.po" \
	"lib\wxExtend\locale\sr_RS.po" \
	"lib\wxExtend\locale\sv_SE.po" \
	"lib\wxExtend\locale\tr_TR.po" \
	"lib\wxExtend\locale\vi_VN.po" \
	"MSI\Base\locale\bg_BG.po" \
	"MSI\Base\locale\ca_ES.po" \
	"MSI\Base\locale\cs_CZ.po" \
	"MSI\Base\locale\cy_UK.po" \
	"MSI\Base\locale\de_DE.po" \
	"MSI\Base\locale\el_GR.po" \
	"MSI\Base\locale\es_ES.po" \
	"MSI\Base\locale\eu_ES.po" \
	"MSI\Base\locale\fi_FI.po" \
	"MSI\Base\locale\fr_CA.po" \
	"MSI\Base\locale\fr_FR.po" \
	"MSI\Base\locale\gl_ES.po" \
	"MSI\Base\locale\hr_HR.po" \
	"MSI\Base\locale\hu_HU.po" \
	"MSI\Base\locale\is_IS.po" \
	"MSI\Base\locale\it_IT.po" \
	"MSI\Base\locale\lt_LT.po" \
	"MSI\Base\locale\nb_NO.po" \
	"MSI\Base\locale\nl_NL.po" \
	"MSI\Base\locale\pl_PL.po" \
	"MSI\Base\locale\pt_PT.po" \
	"MSI\Base\locale\ru_RU.po" \
	"MSI\Base\locale\sk_SK.po" \
	"MSI\Base\locale\sl_SI.po" \
	"MSI\Base\locale\sr_RS.po" \
	"MSI\Base\locale\sv_SE.po" \
	"MSI\Base\locale\tr_TR.po" \
	"MSI\Base\locale\vi_VN.po" \
	"MSI\MSIBuild\Core\locale\bg_BG.po" \
	"MSI\MSIBuild\Core\locale\ca_ES.po" \
	"MSI\MSIBuild\Core\locale\cs_CZ.po" \
	"MSI\MSIBuild\Core\locale\cy_UK.po" \
	"MSI\MSIBuild\Core\locale\de_DE.po" \
	"MSI\MSIBuild\Core\locale\el_GR.po" \
	"MSI\MSIBuild\Core\locale\es_ES.po" \
	"MSI\MSIBuild\Core\locale\eu_ES.po" \
	"MSI\MSIBuild\Core\locale\fi_FI.po" \
	"MSI\MSIBuild\Core\locale\fr_CA.po" \
	"MSI\MSIBuild\Core\locale\fr_FR.po" \
	"MSI\MSIBuild\Core\locale\gl_ES.po" \
	"MSI\MSIBuild\Core\locale\hr_HR.po" \
	"MSI\MSIBuild\Core\locale\hu_HU.po" \
	"MSI\MSIBuild\Core\locale\is_IS.po" \
	"MSI\MSIBuild\Core\locale\it_IT.po" \
	"MSI\MSIBuild\Core\locale\lt_LT.po" \
	"MSI\MSIBuild\Core\locale\nb_NO.po" \
	"MSI\MSIBuild\Core\locale\nl_NL.po" \
	"MSI\MSIBuild\Core\locale\pl_PL.po" \
	"MSI\MSIBuild\Core\locale\pt_PT.po" \
	"MSI\MSIBuild\Core\locale\ru_RU.po" \
	"MSI\MSIBuild\Core\locale\sk_SK.po" \
	"MSI\MSIBuild\Core\locale\sl_SI.po" \
	"MSI\MSIBuild\Core\locale\sr_RS.po" \
	"MSI\MSIBuild\Core\locale\sv_SE.po" \
	"MSI\MSIBuild\Core\locale\tr_TR.po" \
	"MSI\MSIBuild\Core\locale\vi_VN.po" \
	"WLANManager\locale\bg_BG.po" \
	"WLANManager\locale\ca_ES.po" \
	"WLANManager\locale\cs_CZ.po" \
	"WLANManager\locale\cy_UK.po" \
	"WLANManager\locale\de_DE.po" \
	"WLANManager\locale\el_GR.po" \
	"WLANManager\locale\es_ES.po" \
	"WLANManager\locale\eu_ES.po" \
	"WLANManager\locale\fi_FI.po" \
	"WLANManager\locale\fr_CA.po" \
	"WLANManager\locale\fr_FR.po" \
	"WLANManager\locale\gl_ES.po" \
	"WLANManager\locale\hr_HR.po" \
	"WLANManager\locale\hu_HU.po" \
	"WLANManager\locale\is_IS.po" \
	"WLANManager\locale\it_IT.po" \
	"WLANManager\locale\lt_LT.po" \
	"WLANManager\locale\nb_NO.po" \
	"WLANManager\locale\nl_NL.po" \
	"WLANManager\locale\pl_PL.po" \
	"WLANManager\locale\pt_PT.po" \
	"WLANManager\locale\ru_RU.po" \
	"WLANManager\locale\sk_SK.po" \
	"WLANManager\locale\sl_SI.po" \
	"WLANManager\locale\sr_RS.po" \
	"WLANManager\locale\sv_SE.po" \
	"WLANManager\locale\tr_TR.po" \
	"WLANManager\locale\vi_VN.po"


######################################################################
# Folder creation
######################################################################

"$(OUTPUT_DIR)" \
"$(OUTPUT_DIR)\locale" \
"$(OUTPUT_DIR)\locale\bg_BG" \
"$(OUTPUT_DIR)\locale\ca_ES" \
"$(OUTPUT_DIR)\locale\cs_CZ" \
"$(OUTPUT_DIR)\locale\cy_UK" \
"$(OUTPUT_DIR)\locale\de_DE" \
"$(OUTPUT_DIR)\locale\el_GR" \
"$(OUTPUT_DIR)\locale\es_ES" \
"$(OUTPUT_DIR)\locale\eu_ES" \
"$(OUTPUT_DIR)\locale\fi_FI" \
"$(OUTPUT_DIR)\locale\fr_CA" \
"$(OUTPUT_DIR)\locale\fr_FR" \
"$(OUTPUT_DIR)\locale\gl_ES" \
"$(OUTPUT_DIR)\locale\hr_HR" \
"$(OUTPUT_DIR)\locale\hu_HU" \
"$(OUTPUT_DIR)\locale\is_IS" \
"$(OUTPUT_DIR)\locale\it_IT" \
"$(OUTPUT_DIR)\locale\ko_KR" \
"$(OUTPUT_DIR)\locale\lt_LT" \
"$(OUTPUT_DIR)\locale\nb_NO" \
"$(OUTPUT_DIR)\locale\nl_NL" \
"$(OUTPUT_DIR)\locale\pl_PL" \
"$(OUTPUT_DIR)\locale\pt_PT" \
"$(OUTPUT_DIR)\locale\ru_RU" \
"$(OUTPUT_DIR)\locale\sk_SK" \
"$(OUTPUT_DIR)\locale\sl_SI" \
"$(OUTPUT_DIR)\locale\sr_RS" \
"$(OUTPUT_DIR)\locale\sv_SE" \
"$(OUTPUT_DIR)\locale\tr_TR" \
"$(OUTPUT_DIR)\locale\vi_VN" \
"$(OUTPUT_DIR)\Setup" \
"$(PUBLISH_PACKAGE_DIR)" \
"$(PROGRAMDATA)\Microsoft\Windows\Start Menu\Programs\$(MSIBUILD_PRODUCT_NAME)" :
	if not exist $@ md $@

"$(OUTPUT_DIR)\locale" \
"$(OUTPUT_DIR)\Setup" : "$(OUTPUT_DIR)"

"$(OUTPUT_DIR)\locale\bg_BG" \
"$(OUTPUT_DIR)\locale\ca_ES" \
"$(OUTPUT_DIR)\locale\cs_CZ" \
"$(OUTPUT_DIR)\locale\cy_UK" \
"$(OUTPUT_DIR)\locale\de_DE" \
"$(OUTPUT_DIR)\locale\el_GR" \
"$(OUTPUT_DIR)\locale\es_ES" \
"$(OUTPUT_DIR)\locale\eu_ES" \
"$(OUTPUT_DIR)\locale\fi_FI" \
"$(OUTPUT_DIR)\locale\fr_CA" \
"$(OUTPUT_DIR)\locale\fr_FR" \
"$(OUTPUT_DIR)\locale\gl_ES" \
"$(OUTPUT_DIR)\locale\hr_HR" \
"$(OUTPUT_DIR)\locale\hu_HU" \
"$(OUTPUT_DIR)\locale\is_IS" \
"$(OUTPUT_DIR)\locale\it_IT" \
"$(OUTPUT_DIR)\locale\ko_KR" \
"$(OUTPUT_DIR)\locale\lt_LT" \
"$(OUTPUT_DIR)\locale\nb_NO" \
"$(OUTPUT_DIR)\locale\nl_NL" \
"$(OUTPUT_DIR)\locale\pl_PL" \
"$(OUTPUT_DIR)\locale\pt_PT" \
"$(OUTPUT_DIR)\locale\ru_RU" \
"$(OUTPUT_DIR)\locale\sk_SK" \
"$(OUTPUT_DIR)\locale\sl_SI" \
"$(OUTPUT_DIR)\locale\sr_RS" \
"$(OUTPUT_DIR)\locale\sv_SE" \
"$(OUTPUT_DIR)\locale\tr_TR" \
"$(OUTPUT_DIR)\locale\vi_VN" : "$(OUTPUT_DIR)\locale"


######################################################################
# File copy
######################################################################

$(PUBLISH_PACKAGE_DIR)\$(PRODUCT_NAME)32.msi : "$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)32.msi"
	copy /y $** $@ > NUL

"$(PUBLISH_PACKAGE_DIR)\$(PRODUCT_NAME)64.msi" : "$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)64.msi"
	copy /y $** $@ > NUL

"$(OUTPUT_DIR)\Setup\CredWrite.exe" \
"$(PUBLISH_PACKAGE_DIR)\CredWrite.exe" : "$(OUTPUT_DIR)\Win32.Release\CredWrite.exe"
	copy /y $** $@ > NUL

"$(OUTPUT_DIR)\Setup\MsiUseFeature.exe" \
"$(PUBLISH_PACKAGE_DIR)\MsiUseFeature.exe" : "$(OUTPUT_DIR)\Win32.Release\MsiUseFeature.exe"
	copy /y $** $@ > NUL

"$(OUTPUT_DIR)\Setup\WLANManager-Win32.exe" \
"$(PUBLISH_PACKAGE_DIR)\WLANManager-Win32.exe" : "$(OUTPUT_DIR)\Win32.Release\WLANManager.exe"
	copy /y $** $@ > NUL

"$(OUTPUT_DIR)\Setup\WLANManager-x64.exe" \
"$(PUBLISH_PACKAGE_DIR)\WLANManager-x64.exe" : "$(OUTPUT_DIR)\x64.Release\WLANManager.exe"
	copy /y $** $@ > NUL


######################################################################
# Localization import from Transifex
######################################################################

"EAPMethods\locale\bg_BG.po" : "EAPMethods\locale\eapmethods_bg_BG.po"
	copy /y $** $@ > NUL

"EAPMethods\locale\ca_ES.po" : "EAPMethods\locale\eapmethods_ca_ES.po"
	copy /y $** $@ > NUL

"EAPMethods\locale\cs_CZ.po" : "EAPMethods\locale\eapmethods_cs_CZ.po"
	copy /y $** $@ > NUL

"EAPMethods\locale\cy_UK.po" : "EAPMethods\locale\eapmethods_cy.po"
	copy /y $** $@ > NUL

"EAPMethods\locale\de_DE.po" : "EAPMethods\locale\eapmethods_de.po"
	copy /y $** $@ > NUL

"EAPMethods\locale\el_GR.po" : "EAPMethods\locale\eapmethods_el.po"
	copy /y $** $@ > NUL

"EAPMethods\locale\es_ES.po" : "EAPMethods\locale\eapmethods_es.po"
	copy /y $** $@ > NUL

"EAPMethods\locale\eu_ES.po" : "EAPMethods\locale\eapmethods_eu_ES.po"
	copy /y $** $@ > NUL

"EAPMethods\locale\fi_FI.po" : "EAPMethods\locale\eapmethods_fi_FI.po"
	copy /y $** $@ > NUL

"EAPMethods\locale\fr_CA.po" : "EAPMethods\locale\eapmethods_fr_CA.po"
	copy /y $** $@ > NUL

"EAPMethods\locale\fr_FR.po" : "EAPMethods\locale\eapmethods_fr_FR.po"
	copy /y $** $@ > NUL

"EAPMethods\locale\gl_ES.po" : "EAPMethods\locale\eapmethods_gl_ES.po"
	copy /y $** $@ > NUL

"EAPMethods\locale\hr_HR.po" : "EAPMethods\locale\eapmethods_hr_HR.po"
	copy /y $** $@ > NUL

"EAPMethods\locale\hu_HU.po" : "EAPMethods\locale\eapmethods_hu.po"
	copy /y $** $@ > NUL

"EAPMethods\locale\is_IS.po" : "EAPMethods\locale\eapmethods_is.po"
	copy /y $** $@ > NUL

"EAPMethods\locale\it_IT.po" : "EAPMethods\locale\eapmethods_it_IT.po"
	copy /y $** $@ > NUL

"EAPMethods\locale\lt_LT.po" : "EAPMethods\locale\eapmethods_lt.po"
	copy /y $** $@ > NUL

"EAPMethods\locale\nb_NO.po" : "EAPMethods\locale\eapmethods_nb.po"
	copy /y $** $@ > NUL

"EAPMethods\locale\nl_NL.po" : "EAPMethods\locale\eapmethods_nl.po"
	copy /y $** $@ > NUL

"EAPMethods\locale\pl_PL.po" : "EAPMethods\locale\eapmethods_pl_PL.po"
	copy /y $** $@ > NUL

"EAPMethods\locale\pt_PT.po" : "EAPMethods\locale\eapmethods_pt_PT.po"
	copy /y $** $@ > NUL

"EAPMethods\locale\ru_RU.po" : "EAPMethods\locale\eapmethods_ru_RU.po"
	copy /y $** $@ > NUL

"EAPMethods\locale\sk_SK.po" : "EAPMethods\locale\eapmethods_sk_SK.po"
	copy /y $** $@ > NUL

"EAPMethods\locale\sl_SI.po" : "EAPMethods\locale\eapmethods_sl_SI.po"
	copy /y $** $@ > NUL

"EAPMethods\locale\sr_RS.po" : "EAPMethods\locale\eapmethods_sr.po"
	copy /y $** $@ > NUL

"EAPMethods\locale\sv_SE.po" : "EAPMethods\locale\eapmethods_sv.po"
	copy /y $** $@ > NUL

"EAPMethods\locale\tr_TR.po" : "EAPMethods\locale\eapmethods_tr.po"
	copy /y $** $@ > NUL

"EAPMethods\locale\vi_VN.po" : "EAPMethods\locale\eapmethods_vi.po"
	copy /y $** $@ > NUL

"EventMonitor\locale\bg_BG.po" : "EventMonitor\locale\eventmonitor_bg_BG.po"
	copy /y $** $@ > NUL

"EventMonitor\locale\ca_ES.po" : "EventMonitor\locale\eventmonitor_ca_ES.po"
	copy /y $** $@ > NUL

"EventMonitor\locale\cs_CZ.po" : "EventMonitor\locale\eventmonitor_cs_CZ.po"
	copy /y $** $@ > NUL

"EventMonitor\locale\cy_UK.po" : "EventMonitor\locale\eventmonitor_cy.po"
	copy /y $** $@ > NUL

"EventMonitor\locale\de_DE.po" : "EventMonitor\locale\eventmonitor_de.po"
	copy /y $** $@ > NUL

"EventMonitor\locale\el_GR.po" : "EventMonitor\locale\eventmonitor_el.po"
	copy /y $** $@ > NUL

"EventMonitor\locale\es_ES.po" : "EventMonitor\locale\eventmonitor_es.po"
	copy /y $** $@ > NUL

"EventMonitor\locale\eu_ES.po" : "EventMonitor\locale\eventmonitor_eu_ES.po"
	copy /y $** $@ > NUL

"EventMonitor\locale\fi_FI.po" : "EventMonitor\locale\eventmonitor_fi_FI.po"
	copy /y $** $@ > NUL

"EventMonitor\locale\fr_CA.po" : "EventMonitor\locale\eventmonitor_fr_CA.po"
	copy /y $** $@ > NUL

"EventMonitor\locale\fr_FR.po" : "EventMonitor\locale\eventmonitor_fr_FR.po"
	copy /y $** $@ > NUL

"EventMonitor\locale\gl_ES.po" : "EventMonitor\locale\eventmonitor_gl_ES.po"
	copy /y $** $@ > NUL

"EventMonitor\locale\hr_HR.po" : "EventMonitor\locale\eventmonitor_hr_HR.po"
	copy /y $** $@ > NUL

"EventMonitor\locale\hu_HU.po" : "EventMonitor\locale\eventmonitor_hu.po"
	copy /y $** $@ > NUL

"EventMonitor\locale\is_IS.po" : "EventMonitor\locale\eventmonitor_is.po"
	copy /y $** $@ > NUL

"EventMonitor\locale\it_IT.po" : "EventMonitor\locale\eventmonitor_it_IT.po"
	copy /y $** $@ > NUL

"EventMonitor\locale\lt_LT.po" : "EventMonitor\locale\eventmonitor_lt.po"
	copy /y $** $@ > NUL

"EventMonitor\locale\nb_NO.po" : "EventMonitor\locale\eventmonitor_nb.po"
	copy /y $** $@ > NUL

"EventMonitor\locale\nl_NL.po" : "EventMonitor\locale\eventmonitor_nl.po"
	copy /y $** $@ > NUL

"EventMonitor\locale\pl_PL.po" : "EventMonitor\locale\eventmonitor_pl_PL.po"
	copy /y $** $@ > NUL

"EventMonitor\locale\pt_PT.po" : "EventMonitor\locale\eventmonitor_pt_PT.po"
	copy /y $** $@ > NUL

"EventMonitor\locale\ru_RU.po" : "EventMonitor\locale\eventmonitor_ru_RU.po"
	copy /y $** $@ > NUL

"EventMonitor\locale\sk_SK.po" : "EventMonitor\locale\eventmonitor_sk_SK.po"
	copy /y $** $@ > NUL

"EventMonitor\locale\sl_SI.po" : "EventMonitor\locale\eventmonitor_sl_SI.po"
	copy /y $** $@ > NUL

"EventMonitor\locale\sr_RS.po" : "EventMonitor\locale\eventmonitor_sr.po"
	copy /y $** $@ > NUL

"EventMonitor\locale\sv_SE.po" : "EventMonitor\locale\eventmonitor_sv.po"
	copy /y $** $@ > NUL

"EventMonitor\locale\tr_TR.po" : "EventMonitor\locale\eventmonitor_tr.po"
	copy /y $** $@ > NUL

"EventMonitor\locale\vi_VN.po" : "EventMonitor\locale\eventmonitor_vi.po"
	copy /y $** $@ > NUL

"lib\wxExtend\locale\bg_BG.po" : "lib\wxExtend\locale\wxextend_bg_BG.po"
	copy /y $** $@ > NUL

"lib\wxExtend\locale\ca_ES.po" : "lib\wxExtend\locale\wxextend_ca_ES.po"
	copy /y $** $@ > NUL

"lib\wxExtend\locale\cs_CZ.po" : "lib\wxExtend\locale\wxextend_cs_CZ.po"
	copy /y $** $@ > NUL

"lib\wxExtend\locale\cy_UK.po" : "lib\wxExtend\locale\wxextend_cy.po"
	copy /y $** $@ > NUL

"lib\wxExtend\locale\de_DE.po" : "lib\wxExtend\locale\wxextend_de.po"
	copy /y $** $@ > NUL

"lib\wxExtend\locale\el_GR.po" : "lib\wxExtend\locale\wxextend_el.po"
	copy /y $** $@ > NUL

"lib\wxExtend\locale\es_ES.po" : "lib\wxExtend\locale\wxextend_es.po"
	copy /y $** $@ > NUL

"lib\wxExtend\locale\eu_ES.po" : "lib\wxExtend\locale\wxextend_eu_ES.po"
	copy /y $** $@ > NUL

"lib\wxExtend\locale\fi_FI.po" : "lib\wxExtend\locale\wxextend_fi_FI.po"
	copy /y $** $@ > NUL

"lib\wxExtend\locale\fr_CA.po" : "lib\wxExtend\locale\wxextend_fr_CA.po"
	copy /y $** $@ > NUL

"lib\wxExtend\locale\fr_FR.po" : "lib\wxExtend\locale\wxextend_fr_FR.po"
	copy /y $** $@ > NUL

"lib\wxExtend\locale\gl_ES.po" : "lib\wxExtend\locale\wxextend_gl_ES.po"
	copy /y $** $@ > NUL

"lib\wxExtend\locale\hr_HR.po" : "lib\wxExtend\locale\wxextend_hr_HR.po"
	copy /y $** $@ > NUL

"lib\wxExtend\locale\hu_HU.po" : "lib\wxExtend\locale\wxextend_hu.po"
	copy /y $** $@ > NUL

"lib\wxExtend\locale\is_IS.po" : "lib\wxExtend\locale\wxextend_is.po"
	copy /y $** $@ > NUL

"lib\wxExtend\locale\it_IT.po" : "lib\wxExtend\locale\wxextend_it_IT.po"
	copy /y $** $@ > NUL

"lib\wxExtend\locale\lt_LT.po" : "lib\wxExtend\locale\wxextend_lt.po"
	copy /y $** $@ > NUL

"lib\wxExtend\locale\nb_NO.po" : "lib\wxExtend\locale\wxextend_nb.po"
	copy /y $** $@ > NUL

"lib\wxExtend\locale\nl_NL.po" : "lib\wxExtend\locale\wxextend_nl.po"
	copy /y $** $@ > NUL

"lib\wxExtend\locale\pl_PL.po" : "lib\wxExtend\locale\wxextend_pl_PL.po"
	copy /y $** $@ > NUL

"lib\wxExtend\locale\pt_PT.po" : "lib\wxExtend\locale\wxextend_pt_PT.po"
	copy /y $** $@ > NUL

"lib\wxExtend\locale\ru_RU.po" : "lib\wxExtend\locale\wxextend_ru_RU.po"
	copy /y $** $@ > NUL

"lib\wxExtend\locale\sk_SK.po" : "lib\wxExtend\locale\wxextend_sk_SK.po"
	copy /y $** $@ > NUL

"lib\wxExtend\locale\sl_SI.po" : "lib\wxExtend\locale\wxextend_sl_SI.po"
	copy /y $** $@ > NUL

"lib\wxExtend\locale\sr_RS.po" : "lib\wxExtend\locale\wxextend_sr.po"
	copy /y $** $@ > NUL

"lib\wxExtend\locale\sv_SE.po" : "lib\wxExtend\locale\wxextend_sv.po"
	copy /y $** $@ > NUL

"lib\wxExtend\locale\tr_TR.po" : "lib\wxExtend\locale\wxextend_tr.po"
	copy /y $** $@ > NUL

"lib\wxExtend\locale\vi_VN.po" : "lib\wxExtend\locale\wxextend_vi.po"
	copy /y $** $@ > NUL

"MSI\Base\locale\bg_BG.po" : "MSI\Base\locale\msibase_bg_BG.po"
	copy /y $** $@ > NUL

"MSI\Base\locale\ca_ES.po" : "MSI\Base\locale\msibase_ca_ES.po"
	copy /y $** $@ > NUL

"MSI\Base\locale\cs_CZ.po" : "MSI\Base\locale\msibase_cs_CZ.po"
	copy /y $** $@ > NUL

"MSI\Base\locale\cy_UK.po" : "MSI\Base\locale\msibase_cy.po"
	copy /y $** $@ > NUL

"MSI\Base\locale\de_DE.po" : "MSI\Base\locale\msibase_de.po"
	copy /y $** $@ > NUL

"MSI\Base\locale\el_GR.po" : "MSI\Base\locale\msibase_el.po"
	copy /y $** $@ > NUL

"MSI\Base\locale\es_ES.po" : "MSI\Base\locale\msibase_es.po"
	copy /y $** $@ > NUL

"MSI\Base\locale\eu_ES.po" : "MSI\Base\locale\msibase_eu_ES.po"
	copy /y $** $@ > NUL

"MSI\Base\locale\fi_FI.po" : "MSI\Base\locale\msibase_fi_FI.po"
	copy /y $** $@ > NUL

"MSI\Base\locale\fr_CA.po" : "MSI\Base\locale\msibase_fr_CA.po"
	copy /y $** $@ > NUL

"MSI\Base\locale\fr_FR.po" : "MSI\Base\locale\msibase_fr_FR.po"
	copy /y $** $@ > NUL

"MSI\Base\locale\gl_ES.po" : "MSI\Base\locale\msibase_gl_ES.po"
	copy /y $** $@ > NUL

"MSI\Base\locale\hr_HR.po" : "MSI\Base\locale\msibase_hr_HR.po"
	copy /y $** $@ > NUL

"MSI\Base\locale\hu_HU.po" : "MSI\Base\locale\msibase_hu.po"
	copy /y $** $@ > NUL

"MSI\Base\locale\is_IS.po" : "MSI\Base\locale\msibase_is.po"
	copy /y $** $@ > NUL

"MSI\Base\locale\it_IT.po" : "MSI\Base\locale\msibase_it_IT.po"
	copy /y $** $@ > NUL

"MSI\Base\locale\lt_LT.po" : "MSI\Base\locale\msibase_lt.po"
	copy /y $** $@ > NUL

"MSI\Base\locale\nb_NO.po" : "MSI\Base\locale\msibase_nb.po"
	copy /y $** $@ > NUL

"MSI\Base\locale\nl_NL.po" : "MSI\Base\locale\msibase_nl.po"
	copy /y $** $@ > NUL

"MSI\Base\locale\pl_PL.po" : "MSI\Base\locale\msibase_pl_PL.po"
	copy /y $** $@ > NUL

"MSI\Base\locale\pt_PT.po" : "MSI\Base\locale\msibase_pt_PT.po"
	copy /y $** $@ > NUL

"MSI\Base\locale\ru_RU.po" : "MSI\Base\locale\msibase_ru_RU.po"
	copy /y $** $@ > NUL

"MSI\Base\locale\sk_SK.po" : "MSI\Base\locale\msibase_sk_SK.po"
	copy /y $** $@ > NUL

"MSI\Base\locale\sl_SI.po" : "MSI\Base\locale\msibase_sl_SI.po"
	copy /y $** $@ > NUL

"MSI\Base\locale\sr_RS.po" : "MSI\Base\locale\msibase_sr.po"
	copy /y $** $@ > NUL

"MSI\Base\locale\sv_SE.po" : "MSI\Base\locale\msibase_sv.po"
	copy /y $** $@ > NUL

"MSI\Base\locale\tr_TR.po" : "MSI\Base\locale\msibase_tr.po"
	copy /y $** $@ > NUL

"MSI\Base\locale\vi_VN.po" : "MSI\Base\locale\msibase_vi.po"
	copy /y $** $@ > NUL

"MSI\MSIBuild\Core\locale\bg_BG.po" : "MSI\MSIBuild\Core\locale\msibuildcore_bg_BG.po"
	copy /y $** $@ > NUL

"MSI\MSIBuild\Core\locale\ca_ES.po" : "MSI\MSIBuild\Core\locale\msibuildcore_ca_ES.po"
	copy /y $** $@ > NUL

"MSI\MSIBuild\Core\locale\cs_CZ.po" : "MSI\MSIBuild\Core\locale\msibuildcore_cs_CZ.po"
	copy /y $** $@ > NUL

"MSI\MSIBuild\Core\locale\cy_UK.po" : "MSI\MSIBuild\Core\locale\msibuildcore_cy.po"
	copy /y $** $@ > NUL

"MSI\MSIBuild\Core\locale\de_DE.po" : "MSI\MSIBuild\Core\locale\msibuildcore_de.po"
	copy /y $** $@ > NUL

"MSI\MSIBuild\Core\locale\el_GR.po" : "MSI\MSIBuild\Core\locale\msibuildcore_el.po"
	copy /y $** $@ > NUL

"MSI\MSIBuild\Core\locale\es_ES.po" : "MSI\MSIBuild\Core\locale\msibuildcore_es.po"
	copy /y $** $@ > NUL

"MSI\MSIBuild\Core\locale\eu_ES.po" : "MSI\MSIBuild\Core\locale\msibuildcore_eu_ES.po"
	copy /y $** $@ > NUL

"MSI\MSIBuild\Core\locale\fi_FI.po" : "MSI\MSIBuild\Core\locale\msibuildcore_fi_FI.po"
	copy /y $** $@ > NUL

"MSI\MSIBuild\Core\locale\fr_CA.po" : "MSI\MSIBuild\Core\locale\msibuildcore_fr_CA.po"
	copy /y $** $@ > NUL

"MSI\MSIBuild\Core\locale\fr_FR.po" : "MSI\MSIBuild\Core\locale\msibuildcore_fr_FR.po"
	copy /y $** $@ > NUL

"MSI\MSIBuild\Core\locale\gl_ES.po" : "MSI\MSIBuild\Core\locale\msibuildcore_gl_ES.po"
	copy /y $** $@ > NUL

"MSI\MSIBuild\Core\locale\hr_HR.po" : "MSI\MSIBuild\Core\locale\msibuildcore_hr_HR.po"
	copy /y $** $@ > NUL

"MSI\MSIBuild\Core\locale\hu_HU.po" : "MSI\MSIBuild\Core\locale\msibuildcore_hu.po"
	copy /y $** $@ > NUL

"MSI\MSIBuild\Core\locale\is_IS.po" : "MSI\MSIBuild\Core\locale\msibuildcore_is.po"
	copy /y $** $@ > NUL

"MSI\MSIBuild\Core\locale\it_IT.po" : "MSI\MSIBuild\Core\locale\msibuildcore_it_IT.po"
	copy /y $** $@ > NUL

"MSI\MSIBuild\Core\locale\lt_LT.po" : "MSI\MSIBuild\Core\locale\msibuildcore_lt.po"
	copy /y $** $@ > NUL

"MSI\MSIBuild\Core\locale\nb_NO.po" : "MSI\MSIBuild\Core\locale\msibuildcore_nb.po"
	copy /y $** $@ > NUL

"MSI\MSIBuild\Core\locale\nl_NL.po" : "MSI\MSIBuild\Core\locale\msibuildcore_nl.po"
	copy /y $** $@ > NUL

"MSI\MSIBuild\Core\locale\pl_PL.po" : "MSI\MSIBuild\Core\locale\msibuildcore_pl_PL.po"
	copy /y $** $@ > NUL

"MSI\MSIBuild\Core\locale\pt_PT.po" : "MSI\MSIBuild\Core\locale\msibuildcore_pt_PT.po"
	copy /y $** $@ > NUL

"MSI\MSIBuild\Core\locale\ru_RU.po" : "MSI\MSIBuild\Core\locale\msibuildcore_ru_RU.po"
	copy /y $** $@ > NUL

"MSI\MSIBuild\Core\locale\sk_SK.po" : "MSI\MSIBuild\Core\locale\msibuildcore_sk_SK.po"
	copy /y $** $@ > NUL

"MSI\MSIBuild\Core\locale\sl_SI.po" : "MSI\MSIBuild\Core\locale\msibuildcore_sl_SI.po"
	copy /y $** $@ > NUL

"MSI\MSIBuild\Core\locale\sr_RS.po" : "MSI\MSIBuild\Core\locale\msibuildcore_sr.po"
	copy /y $** $@ > NUL

"MSI\MSIBuild\Core\locale\sv_SE.po" : "MSI\MSIBuild\Core\locale\msibuildcore_sv.po"
	copy /y $** $@ > NUL

"MSI\MSIBuild\Core\locale\tr_TR.po" : "MSI\MSIBuild\Core\locale\msibuildcore_tr.po"
	copy /y $** $@ > NUL

"MSI\MSIBuild\Core\locale\vi_VN.po" : "MSI\MSIBuild\Core\locale\msibuildcore_vi.po"
	copy /y $** $@ > NUL

"WLANManager\locale\bg_BG.po" : "WLANManager\locale\wlanmanager_bg_BG.po"
	copy /y $** $@ > NUL

"WLANManager\locale\ca_ES.po" : "WLANManager\locale\wlanmanager_ca_ES.po"
	copy /y $** $@ > NUL

"WLANManager\locale\cs_CZ.po" : "WLANManager\locale\wlanmanager_cs_CZ.po"
	copy /y $** $@ > NUL

"WLANManager\locale\cy_UK.po" : "WLANManager\locale\wlanmanager_cy.po"
	copy /y $** $@ > NUL

"WLANManager\locale\de_DE.po" : "WLANManager\locale\wlanmanager_de.po"
	copy /y $** $@ > NUL

"WLANManager\locale\el_GR.po" : "WLANManager\locale\wlanmanager_el.po"
	copy /y $** $@ > NUL

"WLANManager\locale\es_ES.po" : "WLANManager\locale\wlanmanager_es.po"
	copy /y $** $@ > NUL

"WLANManager\locale\eu_ES.po" : "WLANManager\locale\wlanmanager_eu_ES.po"
	copy /y $** $@ > NUL

"WLANManager\locale\fi_FI.po" : "WLANManager\locale\wlanmanager_fi_FI.po"
	copy /y $** $@ > NUL

"WLANManager\locale\fr_CA.po" : "WLANManager\locale\wlanmanager_fr_CA.po"
	copy /y $** $@ > NUL

"WLANManager\locale\fr_FR.po" : "WLANManager\locale\wlanmanager_fr_FR.po"
	copy /y $** $@ > NUL

"WLANManager\locale\gl_ES.po" : "WLANManager\locale\wlanmanager_gl_ES.po"
	copy /y $** $@ > NUL

"WLANManager\locale\hr_HR.po" : "WLANManager\locale\wlanmanager_hr_HR.po"
	copy /y $** $@ > NUL

"WLANManager\locale\hu_HU.po" : "WLANManager\locale\wlanmanager_hu.po"
	copy /y $** $@ > NUL

"WLANManager\locale\is_IS.po" : "WLANManager\locale\wlanmanager_is.po"
	copy /y $** $@ > NUL

"WLANManager\locale\it_IT.po" : "WLANManager\locale\wlanmanager_it_IT.po"
	copy /y $** $@ > NUL

"WLANManager\locale\lt_LT.po" : "WLANManager\locale\wlanmanager_lt.po"
	copy /y $** $@ > NUL

"WLANManager\locale\nb_NO.po" : "WLANManager\locale\wlanmanager_nb.po"
	copy /y $** $@ > NUL

"WLANManager\locale\nl_NL.po" : "WLANManager\locale\wlanmanager_nl.po"
	copy /y $** $@ > NUL

"WLANManager\locale\pl_PL.po" : "WLANManager\locale\wlanmanager_pl_PL.po"
	copy /y $** $@ > NUL

"WLANManager\locale\pt_PT.po" : "WLANManager\locale\wlanmanager_pt_PT.po"
	copy /y $** $@ > NUL

"WLANManager\locale\ru_RU.po" : "WLANManager\locale\wlanmanager_ru_RU.po"
	copy /y $** $@ > NUL

"WLANManager\locale\sk_SK.po" : "WLANManager\locale\wlanmanager_sk_SK.po"
	copy /y $** $@ > NUL

"WLANManager\locale\sl_SI.po" : "WLANManager\locale\wlanmanager_sl_SI.po"
	copy /y $** $@ > NUL

"WLANManager\locale\sr_RS.po" : "WLANManager\locale\wlanmanager_sr.po"
	copy /y $** $@ > NUL

"WLANManager\locale\sv_SE.po" : "WLANManager\locale\wlanmanager_sv.po"
	copy /y $** $@ > NUL

"WLANManager\locale\tr_TR.po" : "WLANManager\locale\wlanmanager_tr.po"
	copy /y $** $@ > NUL

"WLANManager\locale\vi_VN.po" : "WLANManager\locale\wlanmanager_vi.po"
	copy /y $** $@ > NUL


######################################################################
# Shortcut creation
######################################################################

"$(PROGRAMDATA)\Microsoft\Windows\Start Menu\Programs\$(MSIBUILD_PRODUCT_NAME)\$(MSIBUILD_PRODUCT_NAME) Event Monitor.lnk" : "$(OUTPUT_DIR)\$(PLAT).Debug\EventMonitor.exe"
	cscript.exe "bin\MkLnk.wsf" //Nologo $@ "$(MAKEDIR)\$(OUTPUT_DIR)\$(PLAT).Debug\EventMonitor.exe"


######################################################################
# Building
######################################################################

"$(OUTPUT_DIR)\locale\ca_ES\wxstd.mo" : "$(WXWIN)\locale\ca.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\cs_CZ\wxstd.mo" : "$(WXWIN)\locale\cs.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\de_DE\wxstd.mo" : "$(WXWIN)\locale\de.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\el_GR\wxstd.mo" : "$(WXWIN)\locale\el.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\es_ES\wxstd.mo" : "$(WXWIN)\locale\es.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\eu_ES\wxstd.mo" : "$(WXWIN)\locale\eu.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\fi_FI\wxstd.mo" : "$(WXWIN)\locale\fi.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\fr_CA\wxstd.mo" : "$(WXWIN)\locale\fr.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\fr_FR\wxstd.mo" : "$(WXWIN)\locale\fr.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\gl_ES\wxstd.mo" : "$(WXWIN)\locale\gl_ES.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\hu_HU\wxstd.mo" : "$(WXWIN)\locale\hu.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\it_IT\wxstd.mo" : "$(WXWIN)\locale\it.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\ko_KR\wxstd.mo" : "$(WXWIN)\locale\ko_KR.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\lt_LT\wxstd.mo" : "$(WXWIN)\locale\lt.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\nb_NO\wxstd.mo" : "$(WXWIN)\locale\nb.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\nl_NL\wxstd.mo" : "$(WXWIN)\locale\nl.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\pl_PL\wxstd.mo" : "$(WXWIN)\locale\pl.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\pt_PT\wxstd.mo" : "$(WXWIN)\locale\pt.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\ru_RU\wxstd.mo" : "$(WXWIN)\locale\ru.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\sk_SK\wxstd.mo" : "$(WXWIN)\locale\sk.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\sl_SI\wxstd.mo" : "$(WXWIN)\locale\sl.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\sv_SE\wxstd.mo" : "$(WXWIN)\locale\sv.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\tr_TR\wxstd.mo" : "$(WXWIN)\locale\tr.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\locale\vi_VN\wxstd.mo" : "$(WXWIN)\locale\vi.po"
	msgfmt.exe --output-file=$@ --alignment=1 --endianness=little $**

"$(OUTPUT_DIR)\Win32.Release\CredWrite.exe" \
"$(OUTPUT_DIR)\Win32.Release\MsiUseFeature.exe" \
"$(OUTPUT_DIR)\Win32.Release\WLANManager.exe" \
"$(OUTPUT_DIR)\Win32.Release\Events.dll" \
"$(OUTPUT_DIR)\Win32.Release\EAPTTLS.dll" \
"$(OUTPUT_DIR)\Win32.Release\EAPTTLSUI.dll" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ko_KR.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.32.2.msi" :: Localization

"$(OUTPUT_DIR)\Win32.Debug\CredWrite.exe" \
"$(OUTPUT_DIR)\Win32.Debug\MsiUseFeature.exe" \
"$(OUTPUT_DIR)\Win32.Debug\WLANManager.exe" \
"$(OUTPUT_DIR)\Win32.Debug\Events.dll" \
"$(OUTPUT_DIR)\Win32.Debug\EAPTTLS.dll" \
"$(OUTPUT_DIR)\Win32.Debug\EAPTTLSUI.dll" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ko_KR.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.32D.2.msi" :: Localization

"$(OUTPUT_DIR)\x64.Release\CredWrite.exe" \
"$(OUTPUT_DIR)\x64.Release\MsiUseFeature.exe" \
"$(OUTPUT_DIR)\x64.Release\WLANManager.exe" \
"$(OUTPUT_DIR)\x64.Release\Events.dll" \
"$(OUTPUT_DIR)\x64.Release\EAPTTLS.dll" \
"$(OUTPUT_DIR)\x64.Release\EAPTTLSUI.dll" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ko_KR.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.64.2.msi" :: Localization

"$(OUTPUT_DIR)\x64.Debug\CredWrite.exe" \
"$(OUTPUT_DIR)\x64.Debug\MsiUseFeature.exe" \
"$(OUTPUT_DIR)\x64.Debug\WLANManager.exe" \
"$(OUTPUT_DIR)\x64.Debug\Events.dll" \
"$(OUTPUT_DIR)\x64.Debug\EAPTTLS.dll" \
"$(OUTPUT_DIR)\x64.Debug\EAPTTLSUI.dll" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ko_KR.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.64D.2.msi" :: Localization

"$(OUTPUT_DIR)\Win32.Release\CredWrite.exe" \
"$(OUTPUT_DIR)\Win32.Release\MsiUseFeature.exe" \
"$(OUTPUT_DIR)\Win32.Release\WLANManager.exe" \
"$(OUTPUT_DIR)\Win32.Release\Events.dll" \
"$(OUTPUT_DIR)\Win32.Release\EAPTTLS.dll" \
"$(OUTPUT_DIR)\Win32.Release\EAPTTLSUI.dll" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ko_KR.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.32.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.32.2.msi" ::
	devenv.com "VS10Solution.sln" /build "Release|Win32"

"$(OUTPUT_DIR)\Win32.Debug\CredWrite.exe" \
"$(OUTPUT_DIR)\Win32.Debug\MsiUseFeature.exe" \
"$(OUTPUT_DIR)\Win32.Debug\WLANManager.exe" \
"$(OUTPUT_DIR)\Win32.Debug\Events.dll" \
"$(OUTPUT_DIR)\Win32.Debug\EAPTTLS.dll" \
"$(OUTPUT_DIR)\Win32.Debug\EAPTTLSUI.dll" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ko_KR.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.32D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.32D.2.msi" ::
	devenv.com "VS10Solution.sln" /build "Debug|Win32"

"$(OUTPUT_DIR)\x64.Release\CredWrite.exe" \
"$(OUTPUT_DIR)\x64.Release\MsiUseFeature.exe" \
"$(OUTPUT_DIR)\x64.Release\WLANManager.exe" \
"$(OUTPUT_DIR)\x64.Release\Events.dll" \
"$(OUTPUT_DIR)\x64.Release\EAPTTLS.dll" \
"$(OUTPUT_DIR)\x64.Release\EAPTTLSUI.dll" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ko_KR.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.64.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.64.2.msi" ::
	devenv.com "VS10Solution.sln" /build "Release|x64"

"$(OUTPUT_DIR)\x64.Debug\CredWrite.exe" \
"$(OUTPUT_DIR)\x64.Debug\MsiUseFeature.exe" \
"$(OUTPUT_DIR)\x64.Debug\WLANManager.exe" \
"$(OUTPUT_DIR)\x64.Debug\Events.dll" \
"$(OUTPUT_DIR)\x64.Debug\EAPTTLS.dll" \
"$(OUTPUT_DIR)\x64.Debug\EAPTTLSUI.dll" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ko_KR.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.64D.2.msi" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.64D.2.msi" ::
	devenv.com "VS10Solution.sln" /build "Debug|x64"

"$(OUTPUT_DIR)\$(PRODUCT_NAME)32.ddf" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.32.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.32.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.32.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.32.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.32.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.32.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.32.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.32.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.32.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.32.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.32.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ko_KR.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.32.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.32.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.32.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.32.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.32.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.32.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.32.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.32.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32.2.msi"
	-if exist $@ del /f /q $@
	-if exist "$(@:"=).tmp" del /f /q "$(@:"=).tmp"
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:MakeDDF //Nologo "$(@:"=).tmp" $** /O:"$(OUTPUT_DIR)\$(PRODUCT_NAME)32" /C:LZX
	move /y "$(@:"=).tmp" $@ > NUL

"$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.ddf" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.32D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.32D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.32D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.32D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.32D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.32D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.32D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.32D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.32D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.32D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.32D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ko_KR.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.32D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.32D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.32D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.32D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.32D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.32D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.32D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.32D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32D.2.msi"
	-if exist $@ del /f /q $@
	-if exist "$(@:"=).tmp" del /f /q "$(@:"=).tmp"
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:MakeDDF //Nologo "$(@:"=).tmp" $** /O:"$(OUTPUT_DIR)\$(PRODUCT_NAME)32D" /C:LZX
	move /y "$(@:"=).tmp" $@ > NUL

"$(OUTPUT_DIR)\$(PRODUCT_NAME)64.ddf" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.64.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.64.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.64.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.64.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.64.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.64.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.64.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.64.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.64.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.64.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.64.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ko_KR.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.64.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.64.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.64.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.64.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.64.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.64.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.64.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.64.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.64.2.msi"
	-if exist $@ del /f /q $@
	-if exist "$(@:"=).tmp" del /f /q "$(@:"=).tmp"
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:MakeDDF //Nologo "$(@:"=).tmp" $** /O:"$(OUTPUT_DIR)\$(PRODUCT_NAME)64" /C:LZX
	move /y "$(@:"=).tmp" $@ > NUL

"$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.ddf" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.64D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.64D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.64D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.64D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.64D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.64D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.64D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.64D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.64D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.64D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.64D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ko_KR.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.64D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.64D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.64D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.64D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.64D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.64D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.64D.2.msi" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.64D.2.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.64D.2.msi"
	-if exist $@ del /f /q $@
	-if exist "$(@:"=).tmp" del /f /q "$(@:"=).tmp"
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:MakeDDF //Nologo "$(@:"=).tmp" $** /O:"$(OUTPUT_DIR)\$(PRODUCT_NAME)64D" /C:LZX
	move /y "$(@:"=).tmp" $@ > NUL

"$(OUTPUT_DIR)\$(PRODUCT_NAME)32.cab" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME)32.inf" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME)32.rpt" : "$(OUTPUT_DIR)\$(PRODUCT_NAME)32.ddf"
	makecab.exe /F $**

"$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.cab" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.inf" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.rpt" : "$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.ddf"
	makecab.exe /F $**

"$(OUTPUT_DIR)\$(PRODUCT_NAME)64.cab" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME)64.inf" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME)64.rpt" : "$(OUTPUT_DIR)\$(PRODUCT_NAME)64.ddf"
	makecab.exe /F $**

"$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.cab" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.inf" \
"$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.rpt" : "$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.ddf"
	makecab.exe /F $**

!IFDEF MANIFESTCERTIFICATETHUMBPRINT

.SUFFIXES : .cab

.cab.sign :
	-if exist $@ del /f /q $@
	-if exist "$(@:"=).tmp" del /f /q "$(@:"=).tmp"
	signtool.exe sign /sha1 "$(MANIFESTCERTIFICATETHUMBPRINT)" /t "$(MANIFESTTIMESTAMPURL)" /d "$(MSIBUILD_PRODUCT_NAME)" /q $** > "$(@:"=).tmp"
	move /y "$(@:"=).tmp" $@ > NUL

"$(OUTPUT_DIR)\$(PRODUCT_NAME)32.sign" : "$(OUTPUT_DIR)\$(PRODUCT_NAME)32.cab"

"$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.sign" : "$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.cab"

"$(OUTPUT_DIR)\$(PRODUCT_NAME)64.sign" : "$(OUTPUT_DIR)\$(PRODUCT_NAME)64.cab"

"$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.sign" : "$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.cab"

!ENDIF

"$(OUTPUT_DIR)\$(PRODUCT_NAME)32.msi" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.32.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.32.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.32.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.32.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.32.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.32.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.32.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.32.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.32.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.32.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.32.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.32.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.32.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.32.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.32.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.32.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ko_KR.32.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.32.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.32.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.32.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.32.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.32.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.32.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.32.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.32.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.32.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.32.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.32.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.32.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32.msi"
	-if exist $@ del /f /q $@
	-if exist "$(@:"=).tmp" del /f /q "$(@:"=).tmp"
	copy /y "$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32.msi" "$(@:"=).tmp" > NUL
	attrib.exe -r "$(@:"=).tmp"
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.32.mst" 1026 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.32.mst" 1027 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.32.mst" 1029 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.32.mst" 1106 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.32.mst" 1031 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.32.mst" 1032 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.32.mst" 1034 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.32.mst" 1069 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.32.mst" 1035 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.32.mst" 3084 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.32.mst" 1036 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.32.mst" 1110 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.32.mst" 1050 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.32.mst" 1038 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.32.mst" 1039 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.32.mst" 1040 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).ko_KR.32.mst" 1042 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.32.mst" 1063 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.32.mst" 1044 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.32.mst" 1043 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.32.mst" 1045 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.32.mst" 2070 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.32.mst" 1049 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.32.mst" 1051 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.32.mst" 1060 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.32.mst" 2074 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.32.mst" 1053 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.32.mst" 1055 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.32.mst" 1066 /L
	move /y "$(@:"=).tmp" $@ > NUL

"$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.msi" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.32D.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.32D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.32D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.32D.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.32D.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.32D.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.32D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.32D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.32D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.32D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.32D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.32D.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.32D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.32D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.32D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.32D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ko_KR.32D.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.32D.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.32D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.32D.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.32D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.32D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.32D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.32D.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.32D.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.32D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.32D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.32D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.32D.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32D.msi"
	-if exist $@ del /f /q $@
	-if exist "$(@:"=).tmp" del /f /q "$(@:"=).tmp"
	copy /y "$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.32D.msi" "$(@:"=).tmp" > NUL
	attrib.exe -r "$(@:"=).tmp"
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.32D.mst" 1026 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.32D.mst" 1027 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.32D.mst" 1029 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.32D.mst" 1106 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.32D.mst" 1031 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.32D.mst" 1032 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.32D.mst" 1034 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.32D.mst" 1069 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.32D.mst" 1035 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.32D.mst" 3084 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.32D.mst" 1036 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.32D.mst" 1110 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.32D.mst" 1050 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.32D.mst" 1038 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.32D.mst" 1039 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.32D.mst" 1040 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).ko_KR.32D.mst" 1042 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.32D.mst" 1063 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.32D.mst" 1044 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.32D.mst" 1043 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.32D.mst" 1045 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.32D.mst" 2070 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.32D.mst" 1049 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.32D.mst" 1051 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.32D.mst" 1060 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.32D.mst" 2074 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.32D.mst" 1053 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.32D.mst" 1055 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.32D.mst" 1066 /L
	move /y "$(@:"=).tmp" $@ > NUL

"$(OUTPUT_DIR)\$(PRODUCT_NAME)64.msi" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.64.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.64.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.64.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.64.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.64.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.64.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.64.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.64.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.64.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.64.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.64.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.64.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.64.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.64.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.64.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.64.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ko_KR.64.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.64.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.64.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.64.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.64.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.64.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.64.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.64.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.64.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.64.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.64.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.64.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.64.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.64.msi"
	-if exist $@ del /f /q $@
	-if exist "$(@:"=).tmp" del /f /q "$(@:"=).tmp"
	copy /y "$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.64.msi" "$(@:"=).tmp" > NUL
	attrib.exe -r "$(@:"=).tmp"
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.64.mst" 1026 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.64.mst" 1027 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.64.mst" 1029 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.64.mst" 1106 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.64.mst" 1031 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.64.mst" 1032 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.64.mst" 1034 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.64.mst" 1069 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.64.mst" 1035 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.64.mst" 3084 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.64.mst" 1036 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.64.mst" 1110 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.64.mst" 1050 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.64.mst" 1038 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.64.mst" 1039 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.64.mst" 1040 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).ko_KR.64.mst" 1042 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.64.mst" 1063 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.64.mst" 1044 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.64.mst" 1043 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.64.mst" 1045 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.64.mst" 2070 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.64.mst" 1049 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.64.mst" 1051 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.64.mst" 1060 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.64.mst" 2074 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.64.mst" 1053 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.64.mst" 1055 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.64.mst" 1066 /L
	move /y "$(@:"=).tmp" $@ > NUL

"$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.msi" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.64D.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.64D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.64D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.64D.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.64D.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.64D.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.64D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.64D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.64D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.64D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.64D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.64D.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.64D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.64D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.64D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.64D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ko_KR.64D.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.64D.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.64D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.64D.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.64D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.64D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.64D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.64D.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.64D.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.64D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.64D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.64D.mst" \
#	"$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.64D.mst" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.64D.msi"
	-if exist $@ del /f /q $@
	-if exist "$(@:"=).tmp" del /f /q "$(@:"=).tmp"
	copy /y "$(OUTPUT_DIR)\$(PRODUCT_NAME).en_US.64D.msi" "$(@:"=).tmp" > NUL
	attrib.exe -r "$(@:"=).tmp"
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).bg_BG.64D.mst" 1026 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).ca_ES.64D.mst" 1027 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).cs_CZ.64D.mst" 1029 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).cy_UK.64D.mst" 1106 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).de_DE.64D.mst" 1031 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).el_GR.64D.mst" 1032 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).es_ES.64D.mst" 1034 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).eu_ES.64D.mst" 1069 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).fi_FI.64D.mst" 1035 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_FR.64D.mst" 3084 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).fr_CA.64D.mst" 1036 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).gl_ES.64D.mst" 1110 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).hr_HR.64D.mst" 1050 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).hu_HU.64D.mst" 1038 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).is_IS.64D.mst" 1039 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).it_IT.64D.mst" 1040 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).ko_KR.64D.mst" 1042 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).lt_LT.64D.mst" 1063 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).nb_NO.64D.mst" 1044 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).nl_NL.64D.mst" 1043 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).pl_PL.64D.mst" 1045 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).pt_PT.64D.mst" 2070 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).ru_RU.64D.mst" 1049 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sk_SK.64D.mst" 1051 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sl_SI.64D.mst" 1060 /L
	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sr_RS.64D.mst" 2074 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).sv_SE.64D.mst" 1053 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).tr_TR.64D.mst" 1055 /L
#	cscript.exe "MSI\MSIBuild\MSI.wsf" //Job:AddStorage //Nologo "$(@:"=).tmp" "$(OUTPUT_DIR)\$(PRODUCT_NAME).vi_VN.64D.mst" 1066 /L
	move /y "$(@:"=).tmp" $@ > NUL

"$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)32.msi" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)32.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)32.cab" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)32.inf"
	$(MAKE) /f "MSI\MSIBuild\CAB.mak" /$(MAKEFLAGS) MSIBUILD_ROOT="MSI\MSIBuild" MSIBUILD_TARGET_MSI=$@ MSIBUILD_SOURCE_MSI="$(OUTPUT_DIR)\$(PRODUCT_NAME)32.msi" MSIBUILD_INF="$(OUTPUT_DIR)\$(PRODUCT_NAME)32.inf" MSIBUILD_CAB="$(OUTPUT_DIR)\$(PRODUCT_NAME)32.cab" MSIBUILD_PRODUCT_NAME="$(MSIBUILD_PRODUCT_NAME)"

"$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)32D.msi" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.cab" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.inf"
	$(MAKE) /f "MSI\MSIBuild\CAB.mak" /$(MAKEFLAGS) MSIBUILD_ROOT="MSI\MSIBuild" MSIBUILD_TARGET_MSI=$@ MSIBUILD_SOURCE_MSI="$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.msi" MSIBUILD_INF="$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.inf" MSIBUILD_CAB="$(OUTPUT_DIR)\$(PRODUCT_NAME)32D.cab" MSIBUILD_PRODUCT_NAME="$(MSIBUILD_PRODUCT_NAME)"

"$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)64.msi" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)64.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)64.cab" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)64.inf"
	$(MAKE) /f "MSI\MSIBuild\CAB.mak" /$(MAKEFLAGS) MSIBUILD_ROOT="MSI\MSIBuild" MSIBUILD_TARGET_MSI=$@ MSIBUILD_SOURCE_MSI="$(OUTPUT_DIR)\$(PRODUCT_NAME)64.msi" MSIBUILD_INF="$(OUTPUT_DIR)\$(PRODUCT_NAME)64.inf" MSIBUILD_CAB="$(OUTPUT_DIR)\$(PRODUCT_NAME)64.cab" MSIBUILD_PRODUCT_NAME="$(MSIBUILD_PRODUCT_NAME)"

"$(OUTPUT_DIR)\Setup\$(PRODUCT_NAME)64D.msi" : \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.msi" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.cab" \
	"$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.inf"
	$(MAKE) /f "MSI\MSIBuild\CAB.mak" /$(MAKEFLAGS) MSIBUILD_ROOT="MSI\MSIBuild" MSIBUILD_TARGET_MSI=$@ MSIBUILD_SOURCE_MSI="$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.msi" MSIBUILD_INF="$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.inf" MSIBUILD_CAB="$(OUTPUT_DIR)\$(PRODUCT_NAME)64D.cab" MSIBUILD_PRODUCT_NAME="$(MSIBUILD_PRODUCT_NAME)"

LANG=bg_BG
!INCLUDE "MSILocal.mak"

LANG=ca_ES
!INCLUDE "MSILocal.mak"

#LANG=cs_CZ
#!INCLUDE "MSILocal.mak"

#LANG=cy_UK
#!INCLUDE "MSILocal.mak"

LANG=de_DE
!INCLUDE "MSILocal.mak"

LANG=el_GR
!INCLUDE "MSILocal.mak"

LANG=en_US
!INCLUDE "MSILocal.mak"

LANG=es_ES
!INCLUDE "MSILocal.mak"

#LANG=eu_ES
#!INCLUDE "MSILocal.mak"

#LANG=fi_FI
#!INCLUDE "MSILocal.mak"

#LANG=fr_FR
#!INCLUDE "MSILocal.mak"

#LANG=fr_CA
#!INCLUDE "MSILocal.mak"

#LANG=gl_ES
#!INCLUDE "MSILocal.mak"

LANG=hr_HR
!INCLUDE "MSILocal.mak"

#LANG=hu_HU
#!INCLUDE "MSILocal.mak"

#LANG=is_IS
#!INCLUDE "MSILocal.mak"

#LANG=it_IT
#!INCLUDE "MSILocal.mak"

#LANG=ko_KR
#!INCLUDE "MSILocal.mak"

LANG=lt_LT
!INCLUDE "MSILocal.mak"

LANG=nb_NO
!INCLUDE "MSILocal.mak"

#LANG=nl_NL
#!INCLUDE "MSILocal.mak"

LANG=pl_PL
!INCLUDE "MSILocal.mak"

#LANG=pt_PT
#!INCLUDE "MSILocal.mak"

#LANG=ru_RU
#!INCLUDE "MSILocal.mak"

#LANG=sk_SK
#!INCLUDE "MSILocal.mak"

LANG=sl_SI
!INCLUDE "MSILocal.mak"

LANG=sr_RS
!INCLUDE "MSILocal.mak"

#LANG=sv_SE
#!INCLUDE "MSILocal.mak"

#LANG=tr_TR
#!INCLUDE "MSILocal.mak"

#LANG=vi_VN
#!INCLUDE "MSILocal.mak"
