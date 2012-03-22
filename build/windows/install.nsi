;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"

;--------------------------------
;General

  ;Name and file
  !define VERSION "0033"
  Name "ReplicatorG ${VERSION} - Ultimaker Edition"
  OutFile "../../dist-all/install-ReplicatorG.exe"
  ;Default installation folder
  InstallDir "$PROGRAMFILES\Ultimaker\ReplicatorG"
  
  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\Ultimaker\ReplicatorG" ""

  ;Request application privileges for Windows Vista
  RequestExecutionLevel admin

;Driver config
; BOOL UpdateDriverForPlugAndPlayDevices(HWND, PSTR, PSTR, DWORD, PBOOL);
!define sysUpdateDriverForPlugAndPlayDevices "newdev::UpdateDriverForPlugAndPlayDevices(i, t, t, i, *i) i"
; the masked value of ERROR_NO_SUCH_DEVINST is 523
!define ERROR_NO_SUCH_DEVINST -536870389
 
;BOOL SetupCopyOEMInf(PSTR, PSTR, DWORD, DWORD, PSTR, DWORD, PDWORD, PSTR);
!define sysSetupCopyOEMInf "setupapi::SetupCopyOEMInf(t, t, i, i, i, i, *i, t) i"
!define SPOST_NONE 0
!define SPOST_PATH 1
!define SPOST_URL 2
!define SP_COPY_DELETESOURCE 0x1
!define SP_COPY_REPLACEONLY 0x2
!define SP_COPY_NOOVERWRITE 0x8
!define SP_COPY_OEMINF_CATALOG_ONLY 0x40000

;--------------------------------
;Interface Configuration

  !define MUI_HEADERIMAGE
  !define MUI_HEADERIMAGE_BITMAP "./installer/header.bmp" ; optional
  !define MUI_ABORTWARNING
; Definitions for Java 1.6 Detection
!define JRE_VERSION "1.6"
!define JRE_URL "http://javadl.sun.com/webapps/download/AutoDL?BundleId=18714&/jre-6u5-windows-i586-p.exe"

;--------------------------------
;Pages
  !insertmacro MUI_PAGE_LICENSE "./dist/license.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  
;Some extra macro's
!macro GetWindowsVersion OUTPUT_VALUE
	Call GetWindowsVersion
	Pop `${OUTPUT_VALUE}`
!macroend
 
!define GetWindowsVersion '!insertmacro "GetWindowsVersion"'


;--------------------------------
;Languages
 
  !insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

Section "ReplicatorG" ReplicatorG
 userInfo::getAccountType
   
    ; pop the result from the stack into $0
    pop $0
 
    ; compare the result with the string "Admin" to see if the user is admin.
    ; If match, jump 3 lines down.
    strCmp $0 "Admin" +3
 
    ; if there is not a match, print message and return
    messageBox MB_OK "Please run this installer as Administrator."
    abort

  ;Call DetectJRE
SetOutPath "$INSTDIR" 
 File "../../dist-all/windows/replicatorg-${VERSION}/*"
SetOutPath "$INSTDIR/docs" 
 File "../../dist-all/windows/replicatorg-${VERSION}/docs/*"
SetOutPath "$INSTDIR/drivers" 
; File "../../dist-all/windows/replicatorg-${VERSION}/drivers/*"
SetOutPath "$INSTDIR/drivers/Arduino Mega 2560 usbser Driver" 
 File "../../dist-all/windows/replicatorg-${VERSION}/drivers/Arduino Mega 2560 usbser Driver/*"
SetOutPath "$INSTDIR/drivers/FTDI USB Drivers" 
 File "../../dist-all/windows/replicatorg-${VERSION}/drivers/FTDI USB Drivers/*"
SetOutPath "$INSTDIR/drivers/FTDI USB Drivers/amd64" 
 File "../../dist-all/windows/replicatorg-${VERSION}/drivers/FTDI USB Drivers/amd64/*"
SetOutPath "$INSTDIR/drivers/FTDI USB Drivers/i386" 
 File "../../dist-all/windows/replicatorg-${VERSION}/drivers/FTDI USB Drivers/i386/*"
SetOutPath "$INSTDIR/drivers/FTDI USB Drivers/Static" 
; File "../../dist-all/windows/replicatorg-${VERSION}/drivers/FTDI USB Drivers/Static/*"
SetOutPath "$INSTDIR/drivers/FTDI USB Drivers/Static/amd64" 
 File "../../dist-all/windows/replicatorg-${VERSION}/drivers/FTDI USB Drivers/Static/amd64/*"
SetOutPath "$INSTDIR/drivers/FTDI USB Drivers/Static/i386" 
 File "../../dist-all/windows/replicatorg-${VERSION}/drivers/FTDI USB Drivers/Static/i386/*"
SetOutPath "$INSTDIR/examples" 
 File "../../dist-all/windows/replicatorg-${VERSION}/examples/*"
SetOutPath "$INSTDIR/examples/objects" 
 File "../../dist-all/windows/replicatorg-${VERSION}/examples/objects/*"
SetOutPath "$INSTDIR/examples/test" 
 File "../../dist-all/windows/replicatorg-${VERSION}/examples/test/*"
SetOutPath "$INSTDIR/examples/ultimaker" 
 File "../../dist-all/windows/replicatorg-${VERSION}/examples/ultimaker/*"
SetOutPath "$INSTDIR/examples/upgrades" 
 File "../../dist-all/windows/replicatorg-${VERSION}/examples/upgrades/*"
SetOutPath "$INSTDIR/java" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/*"
SetOutPath "$INSTDIR/java/bin" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/bin/*"
SetOutPath "$INSTDIR/java/bin/client" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/bin/client/*"
SetOutPath "$INSTDIR/java/bin/new_plugin" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/bin/new_plugin/*"
SetOutPath "$INSTDIR/java/bin/server" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/bin/server/*"
SetOutPath "$INSTDIR/java/lib" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/*"
SetOutPath "$INSTDIR/java/lib/images" 
; File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/images/*"
SetOutPath "$INSTDIR/java/lib/images/cursors" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/images/cursors/*"
SetOutPath "$INSTDIR/java/lib/audio" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/audio/*"
SetOutPath "$INSTDIR/java/lib/cmm" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/cmm/*"
SetOutPath "$INSTDIR/java/lib/deploy" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/deploy/*"
SetOutPath "$INSTDIR/java/lib/deploy/jqs" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/deploy/jqs/*"
SetOutPath "$INSTDIR/java/lib/deploy/jqs/ff" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/deploy/jqs/ff/*"
SetOutPath "$INSTDIR/java/lib/deploy/jqs/ff/chrome" 
 ;File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/deploy/jqs/ff/chrome/*"
SetOutPath "$INSTDIR/java/lib/deploy/jqs/ff/chrome/content" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/deploy/jqs/ff/chrome/content/*"
SetOutPath "$INSTDIR/java/lib/deploy/jqs/ie" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/deploy/jqs/ie/*"
SetOutPath "$INSTDIR/java/lib/ext" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/ext/*"
SetOutPath "$INSTDIR/java/lib/fonts" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/fonts/*"
SetOutPath "$INSTDIR/java/lib/i386" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/i386/*"
SetOutPath "$INSTDIR/java/lib/im" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/im/*"
SetOutPath "$INSTDIR/java/lib/management" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/management/*"
SetOutPath "$INSTDIR/java/lib/security" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/security/*"
SetOutPath "$INSTDIR/java/lib/servicetag" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/servicetag/*"
SetOutPath "$INSTDIR/java/lib/zi" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/zi/*"
SetOutPath "$INSTDIR/java/lib/zi/Africa" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/zi/Africa/*"
SetOutPath "$INSTDIR/java/lib/zi/America" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/zi/America/*"
SetOutPath "$INSTDIR/java/lib/zi/America/Argentina" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/zi/America/Argentina/*"
SetOutPath "$INSTDIR/java/lib/zi/America/Indiana" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/zi/America/Indiana/*"
SetOutPath "$INSTDIR/java/lib/zi/America/Kentucky" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/zi/America/Kentucky/*"
SetOutPath "$INSTDIR/java/lib/zi/America/North_Dakota" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/zi/America/North_Dakota/*"
SetOutPath "$INSTDIR/java/lib/zi/Antarctica" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/zi/Antarctica/*"
SetOutPath "$INSTDIR/java/lib/zi/Asia" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/zi/Asia/*"
SetOutPath "$INSTDIR/java/lib/zi/Atlantic" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/zi/Atlantic/*"
SetOutPath "$INSTDIR/java/lib/zi/Australia" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/zi/Australia/*"
SetOutPath "$INSTDIR/java/lib/zi/Etc" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/zi/Etc/*"
SetOutPath "$INSTDIR/java/lib/zi/Europe" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/zi/Europe/*"
SetOutPath "$INSTDIR/java/lib/zi/Indian" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/zi/Indian/*"
SetOutPath "$INSTDIR/java/lib/zi/Pacific" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/zi/Pacific/*"
SetOutPath "$INSTDIR/java/lib/zi/SystemV" 
 File "../../dist-all/windows/replicatorg-${VERSION}/java/lib/zi/SystemV/*"
SetOutPath "$INSTDIR/lib" 
 File "../../dist-all/windows/replicatorg-${VERSION}/lib/*"
SetOutPath "$INSTDIR/machines" 
 File "../../dist-all/windows/replicatorg-${VERSION}/machines/*"
SetOutPath "$INSTDIR/scripts" 
 File "../../dist-all/windows/replicatorg-${VERSION}/scripts/*"
SetOutPath "$INSTDIR/scripts/calibration" 
 File "../../dist-all/windows/replicatorg-${VERSION}/scripts/calibration/*"
SetOutPath "$INSTDIR/scripts/utilities" 
 ;File "../../dist-all/windows/replicatorg-${VERSION}/scripts/utilities/*"
SetOutPath "$INSTDIR/skein_engines" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/documentation" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/documentation/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/fabmetheus_tools" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/fabmetheus_tools/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/fabmetheus_tools/interpret_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/fabmetheus_tools/interpret_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/fabmetheus_tools/interpret_plugins/xml_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/fabmetheus_tools/interpret_plugins/xml_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/fonts" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/fonts/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/geometry" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/geometry/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/geometry/creation" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/geometry/creation/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/geometry/geometry_tools" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/geometry/geometry_tools/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/geometry/geometry_tools/path_elements" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/geometry/geometry_tools/path_elements/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/geometry/geometry_utilities" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/geometry/geometry_utilities/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/geometry/geometry_utilities/evaluate_elements" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/geometry/geometry_utilities/evaluate_elements/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/geometry/geometry_utilities/evaluate_enumerables" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/geometry/geometry_utilities/evaluate_enumerables/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/geometry/geometry_utilities/evaluate_fundamentals" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/geometry/geometry_utilities/evaluate_fundamentals/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/geometry/manipulation" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/geometry/manipulation/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/geometry/manipulation_evaluator" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/geometry/manipulation_evaluator/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/geometry/manipulation_paths" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/geometry/manipulation_paths/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/geometry/manipulation_shapes" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/geometry/manipulation_shapes/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/geometry/solids" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/geometry/solids/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/geometry/statements" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/geometry/statements/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/geometry_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/geometry_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/geometry_plugins/creation" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/geometry_plugins/creation/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/geometry_plugins/manipulation" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/geometry_plugins/manipulation/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/geometry_plugins/manipulation_evaluator" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/geometry_plugins/manipulation_evaluator/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/geometry_plugins/manipulation_paths" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/geometry_plugins/manipulation_paths/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/geometry_plugins/manipulation_shapes" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/geometry_plugins/manipulation_shapes/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/images" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/images/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/miscellaneous" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/miscellaneous/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/miscellaneous/Art of Illusion Scripts" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/miscellaneous/Art of Illusion Scripts/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/miscellaneous/fabricate" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/miscellaneous/fabricate/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/miscellaneous/fabricate/frank_davies" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/miscellaneous/fabricate/frank_davies/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/miscellaneous/nophead" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/miscellaneous/nophead/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/fabmetheus_utilities/templates" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/fabmetheus_utilities/templates/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/models" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/models/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/models/xml_models" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/models/xml_models/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/models/xml_models/art_of_illusion" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/models/xml_models/art_of_illusion/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/alterations" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/alterations/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/prefs" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/prefs/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Quality print" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Quality print/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Quality print/alterations" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Quality print/alterations/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Quality print/profiles" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Quality print/profiles/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Quality print/profiles/extrusion" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Quality print/profiles/extrusion/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Quality print/profiles/extrusion/Ultimaker-ABS" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Quality print/profiles/extrusion/Ultimaker-ABS/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Thin-walled" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Thin-walled/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Thin-walled/alterations" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Thin-walled/alterations/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Thin-walled/profiles" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Thin-walled/profiles/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Thin-walled/profiles/extrusion" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Thin-walled/profiles/extrusion/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Thin-walled/profiles/extrusion/Ultimaker-ABS" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Thin-walled/profiles/extrusion/Ultimaker-ABS/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Very fast" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Very fast/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Very fast/alterations" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Very fast/alterations/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Very fast/profiles" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Very fast/profiles/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Very fast/profiles/extrusion" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Very fast/profiles/extrusion/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Very fast/profiles/extrusion/Ultimaker-ABS" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/prefs/ULTIMAKER - ABS - Very fast/profiles/extrusion/Ultimaker-ABS/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/profiles" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/profiles/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/profiles/cutting" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/profiles/cutting/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/profiles/cutting/End_Mill" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/profiles/cutting/End_Mill/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/profiles/cutting/Laser" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/profiles/cutting/Laser/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/profiles/extrusion" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/profiles/extrusion/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/profiles/extrusion/ABS" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/profiles/extrusion/ABS/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/profiles/extrusion/HDPE" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/profiles/extrusion/HDPE/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/profiles/extrusion/PCL" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/profiles/extrusion/PCL/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/profiles/extrusion/PLA" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/profiles/extrusion/PLA/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/profiles/milling" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/profiles/milling/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/profiles/milling/End_Mill" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/profiles/milling/End_Mill/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/profiles/milling/Laser" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/profiles/milling/Laser/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/skeinforge_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/skeinforge_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/skeinforge_plugins/analyze_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/skeinforge_plugins/analyze_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/skeinforge_plugins/analyze_plugins/analyze_utilities" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/skeinforge_plugins/analyze_plugins/analyze_utilities/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/skeinforge_plugins/analyze_plugins/export_canvas_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/skeinforge_plugins/analyze_plugins/export_canvas_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/skeinforge_plugins/craft_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/skeinforge_plugins/craft_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/skeinforge_plugins/craft_plugins/export_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/skeinforge_plugins/craft_plugins/export_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/skeinforge_plugins/craft_plugins/export_plugins/static_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/skeinforge_plugins/craft_plugins/export_plugins/static_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/skeinforge_plugins/meta_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/skeinforge_plugins/meta_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/skeinforge_plugins/profile_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/skeinforge_plugins/profile_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-31/skeinforge_application/skeinforge_utilities" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-31/skeinforge_application/skeinforge_utilities/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/documentation" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/documentation/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/fabmetheus_tools" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/fabmetheus_tools/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/fabmetheus_tools/interpret_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/fabmetheus_tools/interpret_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/fabmetheus_tools/interpret_plugins/xml_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/fabmetheus_tools/interpret_plugins/xml_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/fonts" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/fonts/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/geometry" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/geometry/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/geometry/creation" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/geometry/creation/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/geometry/geometry_tools" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/geometry/geometry_tools/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/geometry/geometry_tools/path_elements" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/geometry/geometry_tools/path_elements/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/geometry/geometry_utilities" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/geometry/geometry_utilities/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/geometry/geometry_utilities/evaluate_elements" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/geometry/geometry_utilities/evaluate_elements/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/geometry/geometry_utilities/evaluate_enumerables" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/geometry/geometry_utilities/evaluate_enumerables/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/geometry/geometry_utilities/evaluate_fundamentals" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/geometry/geometry_utilities/evaluate_fundamentals/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/geometry/manipulation" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/geometry/manipulation/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/geometry/manipulation_evaluator" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/geometry/manipulation_evaluator/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/geometry/manipulation_paths" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/geometry/manipulation_paths/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/geometry/manipulation_shapes" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/geometry/manipulation_shapes/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/geometry/solids" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/geometry/solids/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/geometry/statements" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/geometry/statements/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/geometry_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/geometry_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/geometry_plugins/creation" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/geometry_plugins/creation/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/geometry_plugins/manipulation" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/geometry_plugins/manipulation/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/geometry_plugins/manipulation_evaluator" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/geometry_plugins/manipulation_evaluator/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/geometry_plugins/manipulation_paths" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/geometry_plugins/manipulation_paths/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/geometry_plugins/manipulation_shapes" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/geometry_plugins/manipulation_shapes/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/images" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/images/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/miscellaneous" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/miscellaneous/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/miscellaneous/Art of Illusion Scripts" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/miscellaneous/Art of Illusion Scripts/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/miscellaneous/fabricate" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/miscellaneous/fabricate/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/miscellaneous/fabricate/frank_davies" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/miscellaneous/fabricate/frank_davies/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/miscellaneous/nophead" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/miscellaneous/nophead/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/fabmetheus_utilities/templates" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/fabmetheus_utilities/templates/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/models" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/models/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/models/xml_models" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/models/xml_models/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/models/xml_models/art_of_illusion" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/models/xml_models/art_of_illusion/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/models/xml_models/creation" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/models/xml_models/creation/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/models/xml_models/geometry_tools" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/models/xml_models/geometry_tools/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/models/xml_models/geometry_tools/path_elements" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/models/xml_models/geometry_tools/path_elements/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/models/xml_models/geometry_utilities" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/models/xml_models/geometry_utilities/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/models/xml_models/geometry_utilities/evaluate_elements" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/models/xml_models/geometry_utilities/evaluate_elements/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/models/xml_models/geometry_utilities/evaluate_enumerables" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/models/xml_models/geometry_utilities/evaluate_enumerables/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/models/xml_models/geometry_utilities/evaluate_fundamentals" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/models/xml_models/geometry_utilities/evaluate_fundamentals/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/models/xml_models/manipulation" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/models/xml_models/manipulation/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/models/xml_models/manipulation_evaluator" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/models/xml_models/manipulation_evaluator/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/models/xml_models/manipulation_paths" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/models/xml_models/manipulation_paths/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/models/xml_models/manipulation_shapes" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/models/xml_models/manipulation_shapes/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/alterations" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/alterations/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/prefs" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/prefs/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/prefs/PLA - Ultimaker - failsafe v1" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/prefs/PLA - Ultimaker - failsafe v1/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/prefs/PLA - Ultimaker - failsafe v1/alterations" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/prefs/PLA - Ultimaker - failsafe v1/alterations/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/prefs/PLA - Ultimaker - failsafe v1/profiles" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/prefs/PLA - Ultimaker - failsafe v1/profiles/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/prefs/PLA - Ultimaker - failsafe v1/profiles/cutting" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/prefs/PLA - Ultimaker - failsafe v1/profiles/cutting/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/prefs/PLA - Ultimaker - failsafe v1/profiles/extrusion" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/prefs/PLA - Ultimaker - failsafe v1/profiles/extrusion/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/prefs/PLA - Ultimaker - failsafe v1/profiles/extrusion/Ultimaker-ABS" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/prefs/PLA - Ultimaker - failsafe v1/profiles/extrusion/Ultimaker-ABS/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/prefs/PLA - Ultimaker - failsafe v1/profiles/milling" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/prefs/PLA - Ultimaker - failsafe v1/profiles/milling/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/prefs/PLA - Ultimaker - failsafe v1/profiles/winding" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/prefs/PLA - Ultimaker - failsafe v1/profiles/winding/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/profiles" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/profiles/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/profiles/cutting" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/profiles/cutting/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/profiles/cutting/End_Mill" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/profiles/cutting/End_Mill/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/profiles/cutting/Laser" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/profiles/cutting/Laser/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/profiles/extrusion" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/profiles/extrusion/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/profiles/extrusion/ABS" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/profiles/extrusion/ABS/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/profiles/extrusion/HDPE" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/profiles/extrusion/HDPE/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/profiles/extrusion/PCL" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/profiles/extrusion/PCL/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/profiles/extrusion/PLA" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/profiles/extrusion/PLA/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/profiles/milling" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/profiles/milling/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/profiles/milling/End_Mill" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/profiles/milling/End_Mill/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/profiles/milling/Laser" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/profiles/milling/Laser/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/skeinforge_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/skeinforge_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/skeinforge_plugins/analyze_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/skeinforge_plugins/analyze_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/skeinforge_plugins/analyze_plugins/analyze_utilities" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/skeinforge_plugins/analyze_plugins/analyze_utilities/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/skeinforge_plugins/analyze_plugins/export_canvas_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/skeinforge_plugins/analyze_plugins/export_canvas_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/skeinforge_plugins/craft_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/skeinforge_plugins/craft_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/skeinforge_plugins/craft_plugins/export_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/skeinforge_plugins/craft_plugins/export_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/skeinforge_plugins/craft_plugins/export_plugins/static_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/skeinforge_plugins/craft_plugins/export_plugins/static_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/skeinforge_plugins/meta_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/skeinforge_plugins/meta_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/skeinforge_plugins/profile_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/skeinforge_plugins/profile_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/skeinforge_utilities" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/skeinforge_utilities/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-35/skeinforge_application/test-objects" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-35/skeinforge_application/test-objects/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/documentation" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/documentation/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/fabmetheus_tools" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/fabmetheus_tools/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/fabmetheus_tools/interpret_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/fabmetheus_tools/interpret_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/fabmetheus_tools/interpret_plugins/xml_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/fabmetheus_tools/interpret_plugins/xml_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/fonts" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/fonts/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/geometry" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/geometry/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/geometry/creation" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/geometry/creation/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/geometry/geometry_tools" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/geometry/geometry_tools/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/geometry/geometry_tools/path_elements" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/geometry/geometry_tools/path_elements/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/geometry/geometry_utilities" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/geometry/geometry_utilities/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/geometry/geometry_utilities/evaluate_elements" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/geometry/geometry_utilities/evaluate_elements/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/geometry/geometry_utilities/evaluate_enumerables" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/geometry/geometry_utilities/evaluate_enumerables/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/geometry/geometry_utilities/evaluate_fundamentals" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/geometry/geometry_utilities/evaluate_fundamentals/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/geometry/manipulation_matrix" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/geometry/manipulation_matrix/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/geometry/manipulation_meta" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/geometry/manipulation_meta/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/geometry/manipulation_paths" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/geometry/manipulation_paths/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/geometry/manipulation_shapes" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/geometry/manipulation_shapes/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/geometry/solids" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/geometry/solids/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/geometry/statements" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/geometry/statements/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/geometry_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/geometry_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/geometry_plugins/creation" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/geometry_plugins/creation/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/geometry_plugins/manipulation_matrix" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/geometry_plugins/manipulation_matrix/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/geometry_plugins/manipulation_meta" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/geometry_plugins/manipulation_meta/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/geometry_plugins/manipulation_paths" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/geometry_plugins/manipulation_paths/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/geometry_plugins/manipulation_shapes" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/geometry_plugins/manipulation_shapes/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/images" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/images/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/miscellaneous" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/miscellaneous/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/miscellaneous/Art of Illusion Scripts" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/miscellaneous/Art of Illusion Scripts/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/miscellaneous/fabricate" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/miscellaneous/fabricate/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/miscellaneous/fabricate/frank_davies" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/miscellaneous/fabricate/frank_davies/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/miscellaneous/nophead" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/miscellaneous/nophead/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/fabmetheus_utilities/templates" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/fabmetheus_utilities/templates/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/models" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/models/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/models/xml_models" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/models/xml_models/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/models/xml_models/art_of_illusion" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/models/xml_models/art_of_illusion/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/models/xml_models/creation" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/models/xml_models/creation/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/models/xml_models/creation/gear" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/models/xml_models/creation/gear/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/models/xml_models/geometry_tools" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/models/xml_models/geometry_tools/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/models/xml_models/geometry_tools/path_elements" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/models/xml_models/geometry_tools/path_elements/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/models/xml_models/geometry_utilities" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/models/xml_models/geometry_utilities/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/models/xml_models/geometry_utilities/evaluate_elements" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/models/xml_models/geometry_utilities/evaluate_elements/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/models/xml_models/geometry_utilities/evaluate_enumerables" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/models/xml_models/geometry_utilities/evaluate_enumerables/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/models/xml_models/geometry_utilities/evaluate_fundamentals" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/models/xml_models/geometry_utilities/evaluate_fundamentals/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/models/xml_models/manipulation_matrix" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/models/xml_models/manipulation_matrix/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/models/xml_models/manipulation_meta" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/models/xml_models/manipulation_meta/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/models/xml_models/manipulation_paths" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/models/xml_models/manipulation_paths/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/models/xml_models/manipulation_shapes" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/models/xml_models/manipulation_shapes/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/models/xml_models/manipulation_shapes/flip" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/models/xml_models/manipulation_shapes/flip/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/models/xml_models/manipulation_shapes/mirror" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/models/xml_models/manipulation_shapes/mirror/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/models/xml_models/solids" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/models/xml_models/solids/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/models/xml_models/statements" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/models/xml_models/statements/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/alterations" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/alterations/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/prefs" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/prefs/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Quality print" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Quality print/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Quality print/alterations" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Quality print/alterations/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Quality print/profiles" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Quality print/profiles/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Quality print/profiles/extrusion" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Quality print/profiles/extrusion/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Quality print/profiles/extrusion/Ultimaker-ABS" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Quality print/profiles/extrusion/Ultimaker-ABS/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Thin-walled" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Thin-walled/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Thin-walled/alterations" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Thin-walled/alterations/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Thin-walled/profiles" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Thin-walled/profiles/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Thin-walled/profiles/extrusion" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Thin-walled/profiles/extrusion/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Thin-walled/profiles/extrusion/Ultimaker-ABS" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Thin-walled/profiles/extrusion/Ultimaker-ABS/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Very fast" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Very fast/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Very fast/alterations" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Very fast/alterations/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Very fast/profiles" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Very fast/profiles/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Very fast/profiles/extrusion" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Very fast/profiles/extrusion/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Very fast/profiles/extrusion/Ultimaker-ABS" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/prefs/Skeinforge 40 - ULTIMAKER - Very fast/profiles/extrusion/Ultimaker-ABS/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/profiles" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/profiles/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/profiles/cutting" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/profiles/cutting/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/profiles/cutting/End_Mill" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/profiles/cutting/End_Mill/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/profiles/cutting/Laser" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/profiles/cutting/Laser/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/profiles/extrusion" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/profiles/extrusion/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/profiles/extrusion/ABS" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/profiles/extrusion/ABS/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/profiles/extrusion/HDPE" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/profiles/extrusion/HDPE/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/profiles/extrusion/PCL" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/profiles/extrusion/PCL/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/profiles/extrusion/PLA" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/profiles/extrusion/PLA/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/profiles/milling" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/profiles/milling/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/profiles/milling/End_Mill" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/profiles/milling/End_Mill/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/profiles/milling/Laser" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/profiles/milling/Laser/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/skeinforge_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/skeinforge_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/skeinforge_plugins/analyze_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/skeinforge_plugins/analyze_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/skeinforge_plugins/analyze_plugins/analyze_utilities" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/skeinforge_plugins/analyze_plugins/analyze_utilities/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/skeinforge_plugins/analyze_plugins/export_canvas_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/skeinforge_plugins/analyze_plugins/export_canvas_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/skeinforge_plugins/craft_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/skeinforge_plugins/craft_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/skeinforge_plugins/craft_plugins/export_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/skeinforge_plugins/craft_plugins/export_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/skeinforge_plugins/craft_plugins/export_plugins/static_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/skeinforge_plugins/craft_plugins/export_plugins/static_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/skeinforge_plugins/meta_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/skeinforge_plugins/meta_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/skeinforge_plugins/profile_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/skeinforge_plugins/profile_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-40/skeinforge_application/skeinforge_utilities" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-40/skeinforge_application/skeinforge_utilities/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/documentation" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/documentation/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/fabmetheus_tools" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/fabmetheus_tools/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/fabmetheus_tools/interpret_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/fabmetheus_tools/interpret_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/fabmetheus_tools/interpret_plugins/xml_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/fabmetheus_tools/interpret_plugins/xml_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/fonts" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/fonts/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/geometry" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/geometry/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/geometry/creation" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/geometry/creation/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/geometry/geometry_tools" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/geometry/geometry_tools/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/geometry/geometry_tools/path_elements" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/geometry/geometry_tools/path_elements/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/geometry/geometry_utilities" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/geometry/geometry_utilities/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/geometry/geometry_utilities/evaluate_elements" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/geometry/geometry_utilities/evaluate_elements/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/geometry/geometry_utilities/evaluate_enumerables" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/geometry/geometry_utilities/evaluate_enumerables/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/geometry/geometry_utilities/evaluate_fundamentals" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/geometry/geometry_utilities/evaluate_fundamentals/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/geometry/manipulation_matrix" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/geometry/manipulation_matrix/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/geometry/manipulation_meta" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/geometry/manipulation_meta/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/geometry/manipulation_paths" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/geometry/manipulation_paths/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/geometry/manipulation_shapes" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/geometry/manipulation_shapes/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/geometry/solids" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/geometry/solids/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/geometry/statements" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/geometry/statements/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/geometry_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/geometry_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/geometry_plugins/creation" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/geometry_plugins/creation/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/geometry_plugins/manipulation_matrix" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/geometry_plugins/manipulation_matrix/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/geometry_plugins/manipulation_meta" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/geometry_plugins/manipulation_meta/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/geometry_plugins/manipulation_paths" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/geometry_plugins/manipulation_paths/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/geometry_plugins/manipulation_shapes" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/geometry_plugins/manipulation_shapes/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/images" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/images/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/miscellaneous" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/miscellaneous/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/miscellaneous/Art of Illusion Scripts" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/miscellaneous/Art of Illusion Scripts/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/miscellaneous/fabricate" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/miscellaneous/fabricate/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/miscellaneous/fabricate/frank_davies" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/miscellaneous/fabricate/frank_davies/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/miscellaneous/nophead" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/miscellaneous/nophead/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/fabmetheus_utilities/templates" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/fabmetheus_utilities/templates/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/models" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/models/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/models/xml_models" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/models/xml_models/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/models/xml_models/art_of_illusion" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/models/xml_models/art_of_illusion/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/models/xml_models/creation" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/models/xml_models/creation/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/models/xml_models/creation/gear" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/models/xml_models/creation/gear/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/models/xml_models/geometry_tools" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/models/xml_models/geometry_tools/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/models/xml_models/geometry_tools/path_elements" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/models/xml_models/geometry_tools/path_elements/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/models/xml_models/geometry_utilities" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/models/xml_models/geometry_utilities/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/models/xml_models/geometry_utilities/evaluate_elements" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/models/xml_models/geometry_utilities/evaluate_elements/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/models/xml_models/geometry_utilities/evaluate_enumerables" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/models/xml_models/geometry_utilities/evaluate_enumerables/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/models/xml_models/geometry_utilities/evaluate_fundamentals" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/models/xml_models/geometry_utilities/evaluate_fundamentals/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/models/xml_models/manipulation_matrix" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/models/xml_models/manipulation_matrix/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/models/xml_models/manipulation_meta" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/models/xml_models/manipulation_meta/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/models/xml_models/manipulation_paths" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/models/xml_models/manipulation_paths/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/models/xml_models/manipulation_paths/bevel" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/models/xml_models/manipulation_paths/bevel/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/models/xml_models/manipulation_shapes" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/models/xml_models/manipulation_shapes/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/models/xml_models/manipulation_shapes/flip" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/models/xml_models/manipulation_shapes/flip/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/models/xml_models/manipulation_shapes/inset" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/models/xml_models/manipulation_shapes/inset/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/models/xml_models/manipulation_shapes/mirror" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/models/xml_models/manipulation_shapes/mirror/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/models/xml_models/manipulation_shapes/outset" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/models/xml_models/manipulation_shapes/outset/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/models/xml_models/solids" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/models/xml_models/solids/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/models/xml_models/statements" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/models/xml_models/statements/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/skeinforge_application" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/skeinforge_application/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/skeinforge_application/alterations" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/skeinforge_application/alterations/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/skeinforge_application/prefs" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/skeinforge_application/prefs/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/skeinforge_application/profiles" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/skeinforge_application/profiles/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/skeinforge_application/profiles/cutting" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/skeinforge_application/profiles/cutting/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/skeinforge_application/profiles/cutting/End_Mill" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/skeinforge_application/profiles/cutting/End_Mill/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/skeinforge_application/profiles/cutting/Laser" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/skeinforge_application/profiles/cutting/Laser/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/skeinforge_application/profiles/extrusion" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/skeinforge_application/profiles/extrusion/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/skeinforge_application/profiles/extrusion/ABS" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/skeinforge_application/profiles/extrusion/ABS/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/skeinforge_application/profiles/extrusion/HDPE" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/skeinforge_application/profiles/extrusion/HDPE/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/skeinforge_application/profiles/extrusion/PCL" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/skeinforge_application/profiles/extrusion/PCL/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/skeinforge_application/profiles/extrusion/PLA" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/skeinforge_application/profiles/extrusion/PLA/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/skeinforge_application/profiles/milling" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/skeinforge_application/profiles/milling/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/skeinforge_application/profiles/milling/End_Mill" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/skeinforge_application/profiles/milling/End_Mill/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/skeinforge_application/profiles/milling/Laser" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/skeinforge_application/profiles/milling/Laser/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/skeinforge_application/profiles/winding" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/skeinforge_application/profiles/winding/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/skeinforge_application/skeinforge_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/skeinforge_application/skeinforge_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/skeinforge_application/skeinforge_plugins/analyze_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/skeinforge_application/skeinforge_plugins/analyze_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/skeinforge_application/skeinforge_plugins/analyze_plugins/analyze_utilities" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/skeinforge_application/skeinforge_plugins/analyze_plugins/analyze_utilities/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/skeinforge_application/skeinforge_plugins/analyze_plugins/export_canvas_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/skeinforge_application/skeinforge_plugins/analyze_plugins/export_canvas_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/skeinforge_application/skeinforge_plugins/craft_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/skeinforge_application/skeinforge_plugins/craft_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/skeinforge_application/skeinforge_plugins/craft_plugins/export_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/skeinforge_application/skeinforge_plugins/craft_plugins/export_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/skeinforge_application/skeinforge_plugins/craft_plugins/export_plugins/static_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/skeinforge_application/skeinforge_plugins/craft_plugins/export_plugins/static_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/skeinforge_application/skeinforge_plugins/meta_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/skeinforge_application/skeinforge_plugins/meta_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/skeinforge_application/skeinforge_plugins/profile_plugins" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/skeinforge_application/skeinforge_plugins/profile_plugins/*"
SetOutPath "$INSTDIR/skein_engines/skeinforge-47/skeinforge_application/skeinforge_utilities" 
 File "../../dist-all/windows/replicatorg-${VERSION}/skein_engines/skeinforge-47/skeinforge_application/skeinforge_utilities/*"
SetOutPath "$INSTDIR/tools" 
 File "../../dist-all/windows/replicatorg-${VERSION}/tools"

${GetWindowsVersion} $R0
StrCmp $R0 'Vista' lbl_pnpUtil
StrCmp $R0 '7' lbl_pnpUtil

messageBox MB_OK "The installer was unable to install the drivers. You need to install them manually."
goto +1

lbl_pnpUtil:
ExecWait '"PnPUtil" /a "$INSTDIR\drivers\Arduino MEGA 2560.inf"  /silent'
	
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall ReplicatorG.exe"

;Create shortcuts
CreateDirectory "$SMPROGRAMS\Ultimaker"
createShortCut "$SMPROGRAMS\Ultimaker\Replicator G.lnk" "$INSTDIR\ReplicatorG.exe"
createShortCut "$SMPROGRAMS\Ultimaker\Uninstall.lnk" "$INSTDIR\uninstall.exe"
  WriteRegStr HKCU "Software\Ultimaker\ReplicatorG" "" $INSTDIR
  

SectionEnd

Section "Python 2.7" Python

  	File "./installer/python-2.7.2.msi"
  	ExecWait '"msiexec" /im "$INSTDIR\python-2.7.2.msi"'
	SectionEnd  

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_Python ${LANG_ENGLISH} "Python 2.7"
  LangString DESC_ReplicatorG ${LANG_ENGLISH} "ReplicatorG requires Python 2.7 to be installed for the included Skeinforge slicer."

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${Python} $(DESC_Python)
    !insertmacro MUI_DESCRIPTION_TEXT ${ReplicatorG} $(DESC_ReplicatorG)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END
 
;--------------------------------
;Uninstaller Section

Section "Uninstall"
	SetOutPath "$INSTDIR"
    	Delete "*"
	SetOutPath "$INSTDIR\tools"
	Delete "*"
	SetOutPath "$INSTDIR\drivers"
  	Delete "*"

	;Delete Java
	SetOutPath "$INSTDIR\java"
	Delete "*"
	SetOutPath "$INSTDIR\java\bin"
	Delete "*"
	SetOutPath "$INSTDIR\java\bin\client"
 	Delete "*"
	SetOutPath "$INSTDIR\java\bin\new_plugin"
	Delete "*"
	SetOutPath "$INSTDIR\java\bin\server"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\audio"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\cmm"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\deploy"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\deploy\jqs"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\deploy\jqs\ff"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\deploy\jqs\ff\chrome"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\deploy\jqs\ff\chrome\content"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\deploy\jqs\ie"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\ext"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\fonts"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\i386"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\im"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\images"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\images\cursors"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\management"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\security"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\servicetag"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\zi"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\zi\Africa"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\zi\America"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\zi\Antartica"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\zi\Asia"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\zi\Atlantic"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\zi\Australia"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\zi\Etc"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\zi\Europe"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\zi\Indian"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\zi\Pacific"
	Delete "*"
	SetOutPath "$INSTDIR\java\lib\zi\SystemV"
	Delete "*"
	RMDir "$INSTDIR"
	RMDir "$SMPROGRAMS\Ultimaker"

  DeleteRegKey /ifempty HKCU "Software\Ultimaker\ReplicatorG"

SectionEnd

Function GetJRE
        MessageBox MB_OK "ReplicatorG uses Java ${JRE_VERSION}, it will now \
                         be downloaded and installed"
 
        StrCpy $2 "$TEMP\Java Runtime Environment.exe"
        nsisdl::download /TIMEOUT=60000 ${JRE_URL} $2
        Pop $R0 ;Get the return value
                StrCmp $R0 "success" +3
                MessageBox MB_OK "Download failed: $R0"
                Quit
        ExecWait $2
        Delete $2
FunctionEnd
 
 
Function DetectJRE
  ReadRegStr $2 HKLM "SOFTWARE\JavaSoft\Java Runtime Environment" \
             "CurrentVersion"
  StrCmp $2 ${JRE_VERSION} done
 
  Call GetJRE
 
  done:
FunctionEnd

Function GetWindowsVersion
 
  Push $R0
  Push $R1
 
  ClearErrors
 
  ReadRegStr $R0 HKLM \
  "SOFTWARE\Microsoft\Windows NT\CurrentVersion" CurrentVersion
 
  IfErrors 0 lbl_winnt
 
  ; we are not NT
  ReadRegStr $R0 HKLM \
  "SOFTWARE\Microsoft\Windows\CurrentVersion" VersionNumber
 
  StrCpy $R1 $R0 1
  StrCmp $R1 '4' 0 lbl_error
 
  StrCpy $R1 $R0 3
 
  StrCmp $R1 '4.0' lbl_win32_95
  StrCmp $R1 '4.9' lbl_win32_ME lbl_win32_98
 
  lbl_win32_95:
    StrCpy $R0 '95'
  Goto lbl_done
 
  lbl_win32_98:
    StrCpy $R0 '98'
  Goto lbl_done
 
  lbl_win32_ME:
    StrCpy $R0 'ME'
  Goto lbl_done
 
  lbl_winnt:
 
  StrCpy $R1 $R0 1
 
  StrCmp $R1 '3' lbl_winnt_x
  StrCmp $R1 '4' lbl_winnt_x
 
  StrCpy $R1 $R0 3
 
  StrCmp $R1 '5.0' lbl_winnt_2000
  StrCmp $R1 '5.1' lbl_winnt_XP
  StrCmp $R1 '5.2' lbl_winnt_2003
  StrCmp $R1 '6.0' lbl_winnt_vista
  StrCmp $R1 '6.1' lbl_winnt_7 lbl_error
 
  lbl_winnt_x:
    StrCpy $R0 "NT $R0" 6
  Goto lbl_done
 
  lbl_winnt_2000:
    Strcpy $R0 '2000'
  Goto lbl_done
 
  lbl_winnt_XP:
    Strcpy $R0 'XP'
  Goto lbl_done
 
  lbl_winnt_2003:
    Strcpy $R0 '2003'
  Goto lbl_done
 
  lbl_winnt_vista:
    Strcpy $R0 'Vista'
  Goto lbl_done
 
  lbl_winnt_7:
    Strcpy $R0 '7'
  Goto lbl_done
 
  lbl_error:
    Strcpy $R0 ''
  lbl_done:
 
  Pop $R1
  Exch $R0
 
FunctionEnd
