; Inspired by
; https://gist.github.com/Phoenix616/4b6bef3fe2ad622b21527043a7acd679
; AND
; https://autohotkey.com/board/topic/68257-toggle-set-default-audio-device-in-windows-7/page-2#entry632858)

; NOTE: I have 1 4k monitor with 125% scaling and another 1080p monitor without scaling. This means for returning mouse position to where
; it was before you will need to be aware of the scaling differences. For me, my 1080p screen is to left of my primary 4k display so it 
; will be negative.

; Windows key + A to swap between the first and third audio output option in Windows 10
; Desinged for a 4k UHD monitor
; Change the variables to get customize the coordinates for the screen.
; audDev1 := 0
; audDev2 := 2
; audTaskBarIconX = 3648
; audTaskBarIconY = 2139
; audDropdownMenuX = 3613
; audDropdownMenuY = 2006
; audDevName1 := Planar Monitor
; audDevName2 := Corsair Headphones


#SingleInstance Force
#NoEnv
#WinActivateForce
SetTitleMatchMode, 2
SendMode Input
CoordMode, Mouse, Screen
DetectHiddenWindows, on

headphones:=false
audiodevice1 := 0
audiodevice2 := 2

#a::
If (headphones) ; this is for toggling between the two
		{
		swapAudioOutput(audDev1)		
		}
	else
		{
		swapAudioOutput(audDev2)	
		}
	headphones := !headphones
return

swapAudioOutput(device)	{
audTaskBarIconX = 3648
audTaskBarIconY = 2139
audDropdownMenuX = 3613
audDropdownMenuY = 2006
If device = 0 ; specify the first device number here
		title = %audDevName1% ; name of first audio Output
	else
		title = %audDevName2% ; name of other audio output
If mouseX < 0
		display := 1080p
	else
		display := 4k 
If display = 1080p ; this fixes the scaling differences between screens
		{
		mouseX := mouseX * 1.25 ; either dived or multiply by percentage.
		mouseY := mouseY * 1.25
		}
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
;	else      ; should not need this else statement
;		{
;		Send, {Home}
;		}
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
