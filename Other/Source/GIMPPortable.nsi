;Copyright (C) 2004-2008 John T. Haller

;Website: http://PortableApps.com/GIMPPortable

;This software is OSI Certified Open Source Software.
;OSI Certified is a certification mark of the Open Source Initiative.

;This program is free software; you can redistribute it and/or
;modify it under the terms of the GNU General Public License
;as published by the Free Software Foundation; either version 2
;of the License, or (at your option) any later version.

;This program is distributed in the hope that it will be useful,
;but WITHOUT ANY WARRANTY; without even the implied warranty of
;MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;GNU General Public License for more details.

;You should have received a copy of the GNU General Public License
;along with this program; if not, write to the Free Software
;Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

!define PORTABLEAPPNAME "GIMP Portable"
!define APPNAME "GIMP"
!define NAME "GIMPPortable"
!define VER "1.6.7.0"
!define WEBSITE "PortableApps.com/GIMPPortable"
!define DEFAULTEXE "gimp-2.6.exe"
!define DEFAULTAPPDIR "gimp"
!define DEFAULTGTKDIR "gtk"
!define DEFAULTSETTINGSDIR "settings"
!define LAUNCHERLANGUAGE "English"

;=== Program Details
Name "${PORTABLEAPPNAME}"
OutFile "..\..\${NAME}.exe"
Caption "${PORTABLEAPPNAME} | PortableApps.com"
VIProductVersion "${VER}"
VIAddVersionKey ProductName "${PORTABLEAPPNAME}"
VIAddVersionKey Comments "Allows ${APPNAME} to be run from a removable drive.  For additional details, visit ${WEBSITE}"
VIAddVersionKey CompanyName "PortableApps.com"
VIAddVersionKey LegalCopyright "John T. Haller"
VIAddVersionKey FileDescription "${PORTABLEAPPNAME}"
VIAddVersionKey FileVersion "${VER}"
VIAddVersionKey ProductVersion "${VER}"
VIAddVersionKey InternalName "${PORTABLEAPPNAME}"
VIAddVersionKey LegalTrademarks "PortableApps.com is a Trademark of Rare Ideas, LLC."
VIAddVersionKey OriginalFilename "${NAME}.exe"
;VIAddVersionKey PrivateBuild ""
;VIAddVersionKey SpecialBuild ""


;=== Runtime Switches
CRCCheck On
WindowIcon Off
SilentInstall Silent
AutoCloseWindow True
RequestExecutionLevel user
XPStyle On

; Best Compression
SetCompress Auto
SetCompressor /SOLID lzma
SetCompressorDictSize 32
SetDatablockOptimize On

;=== Include
;(Standard NSIS)
!include FileFunc.nsh
!insertmacro GetParameters
!insertmacro GetParent
!insertmacro GetRoot
!include Registry.nsh

;(NSIS Plugins)
!include TextReplace.nsh

;(Custom)
!include ReplaceInFileWithTextReplace.nsh
!include ReadINIStrWithDefault.nsh
!include StrRep.nsh

;=== Program Icon
Icon "..\..\App\AppInfo\appicon.ico"

;=== Icon & Stye ===
;!define MUI_ICON "..\..\App\AppInfo\appicon.ico"

;=== Languages
LoadLanguageFile "${NSISDIR}\Contrib\Language files\${LAUNCHERLANGUAGE}.nlf"
!include PortableApps.comLauncherLANG_${LAUNCHERLANGUAGE}.nsh

Var PROGRAMDIRECTORY
Var GTKDIRECTORY
Var SETTINGSDIRECTORY
Var ADDITIONALPARAMETERS
Var EXECSTRING
Var PROGRAMEXECUTABLE
Var ISDEFAULTDIRECTORY
Var GIMPLANGUAGE
Var RENAMEDINCOMPATIBLEFILES
Var AUTOFIXINCOMPATIBLEFILES
Var EXISTSTHUMBNAILS
Var EXISTSFONTSCACHE
Var EXISTSGTKBOOKMARKS
Var EXISTSFONTCONFIG
Var EXISTSFILECHOOSER
Var USERPROFILE
Var MISSINGFILEORPATH
Var USERTYPE
Var FAILEDTORESTOREKEY
Var WORKINGDIRECTORY

Section "Main"
	;=== Find the INI file, if there is one
	IfFileExists "$EXEDIR\${NAME}.ini" "" NoINI
		;=== Read the parameters from the INI file
		${ReadINIStrWithDefault} $0 "$EXEDIR\${NAME}.ini" "${NAME}" "${APPNAME}Directory" "App\${DEFAULTAPPDIR}"
		StrCpy $PROGRAMDIRECTORY "$EXEDIR\$0"
		${ReadINIStrWithDefault} $0 "$EXEDIR\${NAME}.ini" "${NAME}" "GTKDirectory" "NONE"
		StrCpy $GTKDIRECTORY "$EXEDIR\$0"
		${ReadINIStrWithDefault} $0 "$EXEDIR\${NAME}.ini" "${NAME}" "SettingsDirectory" "Data\${DEFAULTSETTINGSDIR}"
		StrCpy $SETTINGSDIRECTORY "$EXEDIR\$0"
		${ReadINIStrWithDefault} $ADDITIONALPARAMETERS "$EXEDIR\${NAME}.ini" "${NAME}" "AdditionalParameters" ""
		${ReadINIStrWithDefault} $AUTOFIXINCOMPATIBLEFILES "$EXEDIR\${NAME}.ini" "${NAME}" "AutofixIncompatibleFiles" "false"
		${ReadINIStrWithDefault} $PROGRAMEXECUTABLE "$EXEDIR\${NAME}.ini" "${NAME}" "${APPNAME}Executable" "${DEFAULTEXE}"
		Goto EndINI

	NoINI:
		;=== No INI file, so we'll use the defaults
		StrCpy $ADDITIONALPARAMETERS ""
		StrCpy $PROGRAMEXECUTABLE "${DEFAULTEXE}"

		IfFileExists "$EXEDIR\App\${DEFAULTAPPDIR}\bin\${DEFAULTEXE}" "" NoProgramEXE
			StrCpy $PROGRAMDIRECTORY "$EXEDIR\App\${DEFAULTAPPDIR}"
			StrCpy $SETTINGSDIRECTORY "$EXEDIR\Data\${DEFAULTSETTINGSDIR}"
			StrCpy $ISDEFAULTDIRECTORY "true"
			;=== Check GTK directory
			IfFileExists "$EXEDIR\App\${DEFAULTAPPDIR}\bin\libgtk-win32*.*" "" GTKSeparate
				StrCpy $GTKDIRECTORY "NONE"
				Goto EndINI

			GTKSeparate:
				IfFileExists "$EXEDIR\App\${DEFAULTGTKDIR}\bin\*.*" "" GTKCommonFiles
					StrCpy $GTKDIRECTORY "$EXEDIR\App\${DEFAULTGTKDIR}"
					Goto EndINI

			GTKCommonFiles:
				${GetParent} "$EXEDIR" $0
				StrCpy $GTKDIRECTORY "$0\CommonFiles\GTK"
				GoTo EndINI
	
	EndINI:
		StrCpy $WORKINGDIRECTORY "$PROGRAMDIRECTORY\bin"
		;ReadEnvStr $WORKINGDIRECTORY "PortableApps.comPictures"
		;StrCmp $WORKINGDIRECTORY "" +2
		;	IfFileExists "$WORKINGDIRECTORY\*.*" CheckIfRunning
		;${GetRoot} $EXEDIR $0
		;StrCpy $WORKINGDIRECTORY "$0\Documents\Pictures"
		;IfFileExists "$WORKINGDIRECTORY\*.*" CheckIfRunning
		;StrCpy $WORKINGDIRECTORY "$0\Documents"
		;IfFileExists "$WORKINGDIRECTORY\*.*" CheckIfRunning
		;StrCpy $WORKINGDIRECTORY "$0\"
		
	
	;CheckIfRunning:
		;=== Check if already running
		System::Call 'kernel32::CreateMutexA(i 0, i 0, t "${NAME}") i .r1 ?e'
		Pop $0
		StrCmp $0 0 CheckForEXE LaunchAndExit
	
	CheckForEXE:
		IfFileExists "$PROGRAMDIRECTORY\bin\$PROGRAMEXECUTABLE" FoundProgramEXE

	NoProgramEXE:
		;=== Program executable not where expected
		StrCpy $MISSINGFILEORPATH $PROGRAMEXECUTABLE
		MessageBox MB_OK|MB_ICONEXCLAMATION `$(LauncherFileNotFound)`
		Abort
		
	FoundProgramEXE:
		FindProcDLL::FindProc "$PROGRAMEXECUTABLE"
		StrCmp $R0 "1" "" CheckForIncompatibleFiles
		MessageBox MB_OK|MB_ICONINFORMATION `$(LauncherAlreadyRunning)`
		Abort
	
	CheckForIncompatibleFiles:
		;=== Check for incompatible files
		IfFileExists "$WINDIR\system32\xmlparse.dll" IncompatibleFilesFound
		IfFileExists "$WINDIR\system32\xmltok.dll" IncompatibleFilesFound
		IfFileExists "$WINDIR\system\xmlparse.dll" IncompatibleFilesFound
		IfFileExists "$WINDIR\system\xmltok.dll" IncompatibleFilesFound
		Goto IncompatibleFilesHandled
		
	IncompatibleFilesFound:
		StrCmp $AUTOFIXINCOMPATIBLEFILES "true" FixIncompatibleFiles
		MessageBox MB_YESNO|MB_ICONQUESTION `Some files (xmlparse.dll, xmltok.dll) were found on this PC that are incompatible with ${PORTABLEAPPNAME}.  Would you like to temporariliy disable these files while ${PORTABLEAPPNAME} is running?` IDYES FixIncompatibleFiles
		MessageBox MB_YESNO|MB_ICONQUESTION `Without disabling these files, ${PORTABLEAPPNAME} may fail to work correctly.  Would you like to continue using ${PORTABLEAPPNAME} anyway?` IDYES IncompatibleFilesHandled
		Goto TheEnd
		
	FixIncompatibleFiles:
		Rename "$WINDIR\system32\xmlparse.dll" "$WINDIR\system32\xmlparse.dll.disabled"
		Rename "$WINDIR\system32\xmltok.dll" "$WINDIR\system32\xmltok.dll.disabled"
		Rename "$WINDIR\system\xmlparse.dll" "$WINDIR\system\xmlparse.dll.disabled"
		Rename "$WINDIR\system\xmltok.dll" "$WINDIR\system\xmltok.dll.disabled"
		StrCpy $RENAMEDINCOMPATIBLEFILES "true"
	
	IncompatibleFilesHandled:
		;=== Get any passed parameters
		${GetParameters} $0
		StrCmp "'$0'" "''" "" LaunchProgramParameters

		;=== No parameters
		StrCpy $EXECSTRING `"$PROGRAMDIRECTORY\bin\$PROGRAMEXECUTABLE"`
		Goto AdditionalParameters

	LaunchProgramParameters:
		StrCpy $EXECSTRING `"$PROGRAMDIRECTORY\bin\$PROGRAMEXECUTABLE" $0`

	AdditionalParameters:
		StrCmp $ADDITIONALPARAMETERS "" GIMPEnvironment
		StrCpy $EXECSTRING `$EXECSTRING $ADDITIONALPARAMETERS`

	GIMPEnvironment:
		;=== Set the %GAIMHOME% directory if we have a path
		StrCmp $SETTINGSDIRECTORY "" GIMPSettingsNotFound
		IfFileExists "$SETTINGSDIRECTORY\*.*" GIMPSettingsFound
	
	GIMPSettingsNotFound:
		StrCmp $ISDEFAULTDIRECTORY "true" SetupDefaultSettings
		StrCpy $MISSINGFILEORPATH $SETTINGSDIRECTORY
		MessageBox MB_OK|MB_ICONEXCLAMATION `$(LauncherFileNotFound)`
		Abort

	SetupDefaultSettings:
		CreateDirectory "$EXEDIR\Data"
		CreateDirectory "$EXEDIR\Data\settings"
		CopyFiles /SILENT $EXEDIR\App\DefaultData\settings\*.* $EXEDIR\Data\settings
	
	GIMPSettingsFound:
		System::Call 'Kernel32::SetEnvironmentVariableA(t, t) i("GIMP2_DIRECTORY", "$SETTINGSDIRECTORY").r0'
		System::Call 'Kernel32::SetEnvironmentVariableA(t, t) i("HOME", "$SETTINGSDIRECTORY").r0'
		GoTo GTKDirectory

	GTKDirectory:
		StrCmp $GTKDIRECTORY "NONE" NoGTKPath
		IfFileExists "$GTKDIRECTORY\libgtk-win32*.*" "" NoGTKPath
		;=== Add GTK to the %PATH% directory if we have a path, otherwise, skip it
		;StrCpy $0 "$GTKDIRECTORY\bin;$PROGRAMDIRECTORY\bin"
		;System::Call 'Kernel32::SetEnvironmentVariableA(t, t) i("PATH", "$0").r0'
		System::Call 'Kernel32::SetEnvironmentVariableA(t, t) i("GTK_BASEPATH", "$GTKDIRECTORY").r0'
		Goto GIMPLanguage
		
	NoGTKPath:
		;StrCpy $0 "$PROGRAMDIRECTORY\bin"
		;System::Call 'Kernel32::SetEnvironmentVariableA(t, t) i("PATH", "$0").r0'
	
	GIMPLANGUAGE:
		ReadEnvStr $GIMPLANGUAGE "PortableApps.comLocaleglibc"
		StrCmp $GIMPLANGUAGE "" GIMPLanguageSettingsFile
		StrCmp $GIMPLANGUAGE "en_US" SetGIMPLanuageVariable
		IfFileExists "$PROGRAMDIRECTORY\share\locale\$GIMPLANGUAGE\*.*" SetGIMPLanuageVariable GIMPLanguageSettingsFile
		
	GIMPLanguageSettingsFile:
		ReadINIStr $GIMPLANGUAGE "$SETTINGSDIRECTORY\${NAME}Settings.ini" "Language" "LANG"
		StrCmp $GIMPLANGUAGE "" UpdatePluginsRC
		StrCmp $GIMPLANGUAGE "en_US" SetGIMPLanuageVariable
		IfFileExists "$PROGRAMDIRECTORY\share\locale\$GIMPLANGUAGE\*.*" SetGIMPLanuageVariable UpdatePluginsRC
		
	SetGIMPLanuageVariable:
		System::Call 'Kernel32::SetEnvironmentVariableA(t, t) i("LANG", "$GIMPLANGUAGE").r0'

	UpdatePluginsRC:
		; double up back slashes and store current directory in $2
		${StrReplace} '$1' '\' '??' '$EXEDIR'
		${StrReplace} '$2' '??' '\\' '$1'
		;get last directory and store in $0
		ReadINIStr $0 "$SETTINGSDIRECTORY\${NAME}Settings.ini" "GIMPPortableSettings" "LastDirectory"
		StrCmp $0 "" StoreLastDirectory
		StrCmp $0 $2 CheckForUserProfileFolders ; No change, so just start
		IfFileExists "$SETTINGSDIRECTORY\pluginrc" "" UpdateGIMPRC
		${ReplaceInFile} "$SETTINGSDIRECTORY\pluginrc" "$0" "$$OLDDIRECTORY$$"
		${ReplaceInFile} "$SETTINGSDIRECTORY\pluginrc" "$$OLDDIRECTORY$$" "$2"
		
	UpdateGIMPRC:
		IfFileExists "$SETTINGSDIRECTORY\gimprc" "" StoreLastDirectory
		${ReplaceInFile} "$SETTINGSDIRECTORY\gimprc" "$0" "$$OLDDIRECTORY$$"
		${ReplaceInFile} "$SETTINGSDIRECTORY\gimprc" "$$OLDDIRECTORY$$" "$2"
		StrCpy $3 $0 2
		StrCpy $4 $2 2
		${ReplaceInFile} "$SETTINGSDIRECTORY\gimprc" "$3\\" "$4\\"

	StoreLastDirectory:
		WriteINIStr "$SETTINGSDIRECTORY\${NAME}Settings.ini" "GIMPPortableSettings" "LastDirectory" $2
	
	CheckForUserProfileFolders:
		ReadEnvStr $USERPROFILE "USERPROFILE"
		IfFileExists "$USERPROFILE\.fonts.cache-1" 0 +2
			StrCpy $EXISTSFONTSCACHE "true"
		IfFileExists "$USERPROFILE\.gtk-bookmarks" 0 +2
			StrCpy $EXISTSGTKBOOKMARKS "true"
		IfFileExists "$USERPROFILE\.thumbnails\*.*" 0 +2
			StrCpy $EXISTSTHUMBNAILS "true"
		IfFileExists "$TEMP\fontconfig\*.*" 0 CopyFontConfigLocally
			StrCpy $EXISTSFONTCONFIG "true"
			Goto CheckForFileChooser

		CopyFontConfigLocally:
			CreateDirectory "$TEMP\fontconfig\cache\"
			CopyFiles /SILENT "$SETTINGSDIRECTORY\fontconfig\cache\*.*" "$TEMP\fontconfig\cache"

		CheckForFileChooser:
		IfFileExists "$APPDATA\gtk-2.0\gtkfilechooser.ini" 0 +2
			StrCpy $EXISTSFILECHOOSER "true"
		
		IfFileExists "$PROGRAMDIRECTORY\lib\gimp\2.0\plug-ins\gimpportablebgwindow.exe" "" LaunchNow
		UserInfo::GetAccountType
		Pop $USERTYPE
		StrCmp $USERTYPE "Guest" LaunchNow
		StrCmp $USERTYPE "User" LaunchNow
		${registry::KeyExists} "HKEY_LOCAL_MACHINE\SOFTWARE\GIMPBgPortable" $R0
		StrCmp $R0 "-1" +3 ;=== If it doesn't exist, skip the next 2 lines
		${registry::MoveKey} "HKEY_LOCAL_MACHINE\SOFTWARE\GIMPBgPortable" "HKEY_LOCAL_MACHINE\SOFTWARE\GIMPBgPortable-BackupByGIMPPortable" $R0
		Sleep 100
		IfFileExists "$SETTINGSDIRECTORY\gimpportablebgwindow.reg" "" LaunchNow
	
		IfFileExists "$WINDIR\system32\reg.exe" "" RestoreTheKey9x
			ExecDos::exec `"$WINDIR\system32\reg.exe" import "$SETTINGSDIRECTORY\gimpportablebgwindow.reg"`
			Pop $R0
			StrCmp $R0 '0' LaunchNow ;successfully restored key
	RestoreTheKey9x:
		${registry::RestoreKey} "$SETTINGSDIRECTORY\gimpportablebgwindow.reg" $R0
		StrCmp $R0 '0' LaunchNow ;successfully restored key
		StrCpy $FAILEDTORESTOREKEY "true"
		
	LaunchNow:
		SetOutPath $WORKINGDIRECTORY
		ExecWait $EXECSTRING
		StrCmp $RENAMEDINCOMPATIBLEFILES "true" "" CleanupBackgroundPluginRegistry
		Rename "$WINDIR\system32\xmlparse.dll.disabled" "$WINDIR\system32\xmlparse.dll"
		Rename "$WINDIR\system32\xmltok.dll.disabled" "$WINDIR\system32\xmltok.dll"
		Rename "$WINDIR\system\xmlparse.dll.disabled" "$WINDIR\system\xmlparse.dll"
		Rename "$WINDIR\system\xmltok.dll.disabled" "$WINDIR\system\xmltok.dll"

	CleanupBackgroundPluginRegistry:
		IfFileExists "$PROGRAMDIRECTORY\lib\gimp\2.0\plug-ins\gimpportablebgwindow.exe" "" TheEnd
		StrCmp $USERTYPE "Guest" TheEnd
		StrCmp $USERTYPE "User" TheEnd
		StrCmp $FAILEDTORESTOREKEY "true" SetOriginalKeyBack
		${registry::SaveKey} "HKEY_LOCAL_MACHINE\SOFTWARE\GIMPBgPortable" "$SETTINGSDIRECTORY\gimpportablebgwindow.reg" "" $0
		Sleep 100
	
	SetOriginalKeyBack:
		${registry::DeleteKey} "HKEY_LOCAL_MACHINE\SOFTWARE\GIMPBgPortable" $R0
		Sleep 100
		${registry::KeyExists} "HKEY_LOCAL_MACHINE\SOFTWARE\GIMPBgPortable-BackupByGIMPPortable" $R0
		StrCmp $R0 "-1" TheEnd
		${registry::MoveKey} "HKEY_LOCAL_MACHINE\SOFTWARE\GIMPBgPortable-BackupByGIMPPortable" "HKEY_LOCAL_MACHINE\SOFTWARE\GIMPBgPortable" $R0
		Sleep 100
		Goto TheEnd
		
	LaunchAndExit:
		SetOutPath $WORKINGDIRECTORY
		${GetParameters} $0
		StrCmp "'$0'" "''" BringGIMPToFront
		Exec `"$PROGRAMDIRECTORY\bin\$PROGRAMEXECUTABLE" $0`
		Goto TheRealEnd
		
	BringGIMPToFront:
		FindWindow $0 "gdkWindowTopLevel" "Toolbox"
		IntCmp $0 0 TheRealEnd
			System::Call "user32::ShowWindow(i $0,i 9) i."         ; If minimized then maximize
			System::Call 'user32::SetForegroundWindow(i $0) i ?e'
		Goto TheRealEnd
		
	TheEnd:
		StrCmp $EXISTSFONTSCACHE "true" +2
			Delete "$USERPROFILE\.fonts.cache-1"
		StrCmp $EXISTSGTKBOOKMARKS "true" +2
			Delete "$USERPROFILE\.gtk-bookmarks"
		StrCmp $EXISTSTHUMBNAILS "true" +2
			RMDir /r "$USERPROFILE\.thumbnails\"
		StrCmp $EXISTSFONTCONFIG "true" +5
			Delete $SETTINGSDIRECTORY\fontconfig\cache\*.*
			CreateDirectory $SETTINGSDIRECTORY\fontconfig\cache
			CopyFiles /SILENT "$TEMP\fontconfig\cache\*.*" "$SETTINGSDIRECTORY\fontconfig\cache"
			RmDir /r "$TEMP\fontconfig\"
		StrCmp $EXISTSFILECHOOSER "true" TheRealEnd
			Delete "$APPDATA\gtk-2.0\gtkfilechooser.ini"
			RmDir "$APPDATA\gtk-2.0\"		

	TheRealEnd:
		${registry::Unload}
SectionEnd