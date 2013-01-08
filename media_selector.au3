; A custom messagebox that uses the MessageLoop mode

#include <GUIConstantsEx.au3>
#include <ButtonConstants.au3>
#include <WindowsConstants.au3>
#include <Misc.au3>
#include <GuiButton.au3>
#include <StaticConstants.au3>

; Make sure only one instance of this script can run at a time
If _Singleton("pic_my_media_player", 0) = 0 Then
  Exit
EndIf

; If either XBMC or WMC is running... then exit this script
; The WMC executable ehshell.exe was renamed on my system with a _m on my system
; to prevent Windows from launching WMC
;If ProcessExists("ehshell_m.exe") Or ProcessExists("ehshell.exe") Then
If ProcessExists("ehshell_m.exe") Then
  ;Send("#!{ENTER}")
  Exit
EndIf

If ProcessExists("xbmc.exe") Then
  WinActivate("XBMC")
  Exit
EndIf


_Main()


Func _Main()
  Local $xbmcBUTTON, $wmcBUTTON, $pwrBUTTON, $exitBUTTON, $msg

  ; Pack the images and sounds
  FileInstall("gfx\xbmc_default.bmp", @TempDir & "\xbmc_default.bmp" , 1)
  FileInstall("gfx\xbmc_unselected.bmp", @TempDir & "\xbmc_unselected.bmp" , 1)
  FileInstall("gfx\wmc_default.bmp", @TempDir & "\wmc_default.bmp" , 1)
  FileInstall("gfx\wmc_unselected.bmp", @TempDir & "\wmc_unselected.bmp" , 1)
  FileInstall("gfx\poweroff_default.bmp", @TempDir & "\poweroff_default.bmp" , 1)
  FileInstall("gfx\poweroff_unselected.bmp", @TempDir & "\poweroff_unselected.bmp" , 1)
  FileInstall("gfx\exit_64.bmp", @TempDir & "\exit_64.bmp" , 1)
  FileInstall("gfx\exit_128.bmp", @TempDir & "\exit_128.bmp" , 1)
  ;FileInstall("gfx\background.jpg", @TEmpDir & "\background.jpg", 1)
  ;FileInstall("snd\announce.mp3", @TempDir & "\announce.mp3", 1) ; Kind of on the fence about having audio
  ;FileInstall("snd\xbmc.mp3", @TempDir & "\xbmc.mp3", 1) ; Kind of on the fence about having audio 	
  ;FileInstall("snd\wmc.mp3", @TempDir & "\wmc.mp3", 1) ; Kind of on the fence about having audio 

  GUICreate("Custom Media Selector", @DesktopWidth, @DesktopHeight, 0, 0, $WS_POPUP)	
  GUISetBkColor(0x000000)
  ;GuiCtrlCreatePic(@TempDir & "\background.jpg", 0, 0, @DesktopWidth, @DesktopHeight)
	
  $pwrBUTTON = GUICtrlCreateButton("PWR", 32, 920, 128, 128, $BS_BITMAP)
  GUICtrlSetImage(-1, @TempDir & "\poweroff_unselected.bmp")
	
  $xbmcBUTTON = GUICtrlCreateButton("XBMC", 490, 440, 400, 220,  $BS_BITMAP)
  GUICtrlSetImage(-1, @TempDir & "\xbmc_unselected.bmp")
  GUICtrlSetState(-1, $GUI_FOCUS) ; the button's focus is on XBMC by default
	
  $wmcBUTTON = GUICtrlCreateButton("WMC", 1010, 350, 400, 400, $BS_BITMAP)
  GUICtrlSetImage(-1, @TempDir & "\wmc_unselected.bmp")
	
  $exitBUTTON = GUICtrlCreateButton("Close", 1792, 0, 128, 128, $BS_BITMAP)
  GUICtrlSetImage(-1, @TempDir & "\exit_64.bmp", 28)

  GUISetState() ; display the GUI

  WinActivate("Custom Media Selector") ; Make sure this fullscreen window is in the foreground
  ;SoundPlay(@TempDir & "\announce.mp3", 0) ; Play the announcement
	

  Do
    $msg = GUIGetMsg()

    If _GUICtrlButton_GetFocus($xbmcBUTTON) Then
      _GUICtrlButton_SetImage($xbmcBUTTON, @TempDir & "\xbmc_default.bmp")
      _GUICtrlButton_SetImage($wmcBUTTON, @TempDir & "\wmc_unselected.bmp")
      _GUICtrlButton_SetImage($pwrBUTTON, @TempDir & "\poweroff_unselected.bmp")
      _GUICtrlButton_SetImage($exitBUTTON, @TempDir & "\exit_64.bmp")
    ElseIf _GUICtrlButton_GetFocus($wmcBUTTON) Then
      _GUICtrlButton_SetImage($xbmcBUTTON, @TempDir & "\xbmc_unselected.bmp")
      _GUICtrlButton_SetImage($wmcBUTTON, @TempDir & "\wmc_default.bmp")
      _GUICtrlButton_SetImage($pwrBUTTON, @TempDir & "\poweroff_unselected.bmp")
      _GUICtrlButton_SetImage($exitBUTTON, @TempDir & "\exit_64.bmp")
    ElseIf _GUICtrlButton_GetFocus($pwrBUTTON) Then
      _GUICtrlButton_SetImage($xbmcBUTTON, @TempDir & "\xbmc_unselected.bmp")
      _GUICtrlButton_SetImage($wmcBUTTON, @TempDir & "\wmc_unselected.bmp")
      _GUICtrlButton_SetImage($pwrBUTTON, @TempDir & "\poweroff_default.bmp")
      _GUICtrlButton_SetImage($exitBUTTON, @TempDir & "\exit_64.bmp")
    ElseIf _GUICtrlButton_GetFocus($exitBUTTON) Then
      _GUICtrlButton_SetImage($xbmcBUTTON, @TempDir & "\xbmc_unselected.bmp")
      _GUICtrlButton_SetImage($wmcBUTTON, @TempDir & "\wmc_unselected.bmp")
      _GUICtrlButton_SetImage($pwrBUTTON, @TempDir & "\poweroff_unselected.bmp")
      _GUICtrlButton_SetImage($exitBUTTON, @TempDir & "\exit_128.bmp")
    EndIf

  Select
    Case $msg = $xbmcBUTTON
      GuiCtrlSetState($wmcBUTTON, $GUI_HIDE)
      GuiCtrlSetState($pwrBUTTON, $GUI_HIDE)
      GuiCtrlSetState($exitBUTTON, $GUI_HIDE)
      ;SoundPlay(@TempDir & "\xbmc.mp3", 1) ; Play the announcement
      ;Run(@ProgramFilesDir & "\XBMC\xbmc.exe") ; Launch the main app regularly
      Run(@MyDocumentsDir & "\XbmcLauncher.exe") ; Bootstrap custom launcher program
      sleep(1000)
    Case $msg = $wmcBUTTON
      GuiCtrlSetState($xbmcBUTTON, $GUI_HIDE)
      GuiCtrlSetState($pwrBUTTON, $GUI_HIDE)
      GuiCtrlSetState($exitBUTTON, $GUI_HIDE)
      ;SoundPlay(@TempDir & "\wmc.mp3", 1) ; Play the announcement
      ;Run("C:\Windows\ehome\ehshell_m.exe") ; Regular Launch
      Run(@WindowsDir & "\ehome\ehshell_m.exe /nostartupanimation /homepage:VideoFullscreen.xml /PushStartPage:True") ; Launch into Live TV
      ;Run(@WindowsDir & "\ehome\ehshell_m.exe /nostartupanimation /homepage:VideoGuide.xml /PushStartPage:True") ; Launch into TV Guide
      sleep(1500)
    Case $msg = $pwrBUTTON
      GuiCtrlSetState($xbmcBUTTON, $GUI_HIDE)
      GuiCtrlSetState($wmcBUTTON, $GUI_HIDE)
      GuiCtrlSetState($exitBUTTON, $GUI_HIDE)
      Run(@MyDocumentsDir & '\oyremotecl.exe -ip 192.168.0.85 -port 60128 -delay 100 ""ZPW00,PWR00"')
      sleep(250)
      Run(@MyDocumentsDir & "\elitepower\elitepower.exe elite.ea.win 10002 off") ; custom py2exe script sending 'POWR0   \r' to Elite on tcp/10002
      sleep(250)
      Shutdown(9) ; Put this PC into shutdown mcde 9 (shutdown=1 poweroff=8), 32=sleep mode/standby)
      ;Case $msg = $exitBUTTON
      ;_GUICtrlButton_SetImage($exitBUTTON, @TempDir & "\exit_64.bmp")
  EndSelect

  Until $msg = $GUI_EVENT_CLOSE Or $msg = $xbmcBUTTON Or $msg = $wmcBUTTON Or $msg = $pwrBUTTON Or $msg = $exitBUTTON

EndFunc   ;==>_Main
 

 
;OnAutoItExitRegister("myExitFunk")
;Func myExitFunk()
	
