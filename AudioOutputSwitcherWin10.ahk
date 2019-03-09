; Inspired by
; https://gist.github.com/Phoenix616/4b6bef3fe2ad622b21527043a7acd679
; AND
; https://autohotkey.com/board/topic/68257-toggle-set-default-audio-device-in-windows-7/page-2#entry632858)



; Windows key + A to swap between the first and third audio output option in Windows 10
; Desinged for a 4k UHD monitor
; Change the variables to get customize the coordinates for the screen.
; audTaskBarIconX = 3648
; audTaskBarIconY = 2139
; audDropdownMenuX = 3613
; audDropdownMenuY = 2006


#SingleInstance Force
#NoEnv
#WinActivateForce
SetTitleMatchMode, 2
SendMode Input
CoordMode, Mouse, Screen
DetectHiddenWindows, on

headphones:=false
#a::


If (headphones)
		{
		swapAudioOutput(0)
		
		}
	else
		{
		swapAudioOutput(2)
		title = Corsair Headphones
		}
	headphones := !headphones
return

swapAudioOutput(device)	{
audTaskBarIconX = 3648
audTaskBarIconY = 2139
audDropdownMenuX = 3613
audDropdownMenuY = 2006
If device = 0
		title = Planar Monitor
	else
		title = Corsair Headphones
TBarGrey =
MouseGetPos, mouseX, mouseY, Wid, control
WinActivate, ahk_class Windows.UI.Core.CoreWindow
Click, %audTaskBarIconX%, %audTaskBarIconY% ; Clicking on the Audio Icon on Task Bar (I have Small Taskbar Icons on)
If WinExist("ahk_class Windows.UI.Core.CoreWindow")
Sleep, 320
Click, %audDropdownMenuX%, %audDropdownMenuY%
Sleep, 100
Send, {tab}
;Sleep, 50
Send, {Home}
If device != 0
		{
		Send, {Down %device%}
		}
	else
		{
		Send, {Home}
		}
Send, {Enter}
Send, {Esc}
MouseMove, mouseX, mouseY
WinActivate, ahk_id %Wid%
SoundPlay, *64  ; Asterisk (info)
TrayTip, %MatchedTitle%, %title% is now active, 2, 17 ; 2 seconds, info icon (1) without sound (+16)
SetTimer, removeTrayTip1, 2000  ; TrayTip durations under 10 seconds don't work, remove ourselves after 2 second timer		
} ;End Function

removeTrayTip1() {
   SetTimer, RemoveTrayTip1, Off
   TrayTip  ; without parameters, removes displayed traytip
}
