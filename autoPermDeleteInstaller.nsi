RequestExecutionLevel admin
Outfile "AutoPermDeleteInstaller.exe"
Icon "D:\Downloads1\delete.ico"
InstallDir "$PROGRAMFILES\AutoPermDelete"
InstallDirRegKey HKCU "Software\AutoPermDelete" "Install_Dir"

Page components
ComponentText "Select optional shortcuts:"
Page instfiles

Section "Main Files" SEC01
  ; Check if the process is running and terminate it
  ExecShell "open" "taskkill" "/F /IM autoPermDelete.exe /T"

  ; Install main files
  SetOutPath "$INSTDIR"
  File "autoPermDelete.exe"
SectionEnd

Section "Start Menu Shortcut" SEC02
  CreateDirectory "$SMPROGRAMS\AutoPermDelete"
  CreateShortCut "$SMPROGRAMS\AutoPermDelete\Automatic Perm Delete.lnk" "$INSTDIR\autoPermDelete.exe"
SectionEnd

Section "Startup Shortcut" SEC03
  CreateShortCut "$SMSTARTUP\Automatic Perm Delete.lnk" "$INSTDIR\autoPermDelete.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\Uninstall.exe"

  ; Register uninstall entry for Add/Remove and Start Menu right-click
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\AutoPermDelete" "DisplayName" "AutoPermDelete"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\AutoPermDelete" "UninstallString" "$\"$INSTDIR\Uninstall.exe$\""
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\AutoPermDelete" "InstallLocation" "$INSTDIR"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\AutoPermDelete" "Publisher" "Pavle"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\AutoPermDelete" "DisplayIcon" "$INSTDIR\autoPermDelete.exe"
  WriteRegStr HKCU "Software\AutoPermDelete" "Install_Dir" "$INSTDIR"
SectionEnd

Section "Uninstall"
  ; Check if the process is running and terminate it
  ExecShell "open" "taskkill" "/F /IM autoPermDelete.exe /T"

  ; Delete installed files
  Delete "$INSTDIR\autoPermDelete.exe"
  Delete "$INSTDIR\Uninstall.exe"

  ; Delete Start Menu shortcut and directory
  Delete "$SMPROGRAMS\AutoPermDelete\Automatic Perm Delete.lnk"
  RMDir "$SMPROGRAMS\AutoPermDelete"

  ; Delete Startup shortcut
  Delete "$SMSTARTUP\Automatic Perm Delete.lnk"

  ; Remove installation directory (if empty)
  RMDir "$INSTDIR"

  ; Remove registry keys
  DeleteRegKey HKCU "Software\AutoPermDelete"
  DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\AutoPermDelete"

  ; Clean up any remaining empty parent directories
  RMDir /r "$SMPROGRAMS\AutoPermDelete"
  RMDir /r "$SMSTARTUP"
SectionEnd
