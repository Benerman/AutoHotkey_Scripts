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


; global variables were used to get this working across the board as it was an include.

#SingleInstance Force
#NoEnv
#WinActivateForce
SetTitleMatchMode, 2
SendMode Input
CoordMode, Mouse, Screen
DetectHiddenWindows, on
SetWorkingDir, C:\Users\ADINN\Documents\AutoHotkey ; Change this as needed


headphones:=false
global audDev1 := 0  ; Starting at 0 count down from the top of the available audio outputs to find your selection
global audDev2 := 3  ; These are feeding the swapAudioOutput() and need to be global, not sure if a better way exists currently


#a::
If (headphones) ; this is for toggling between the two options
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
audDevName1 := "Planar Monitor"
audDevName2 := "Corsair Headphones"
audTaskBarIconX := 3684
audTaskBarIconY := 2140
scalingPercent := 125 ; input scaling percent NUMBERS ONLY Only if you have second screen with different scaling settings

If device = %audDev1% ; assigns a title for the traytip
		{
		audiotitle = %audDevName1% ; name of first audio Output
		}
	else
		{
		audiotitle = %audDevName2% ; name of other audio output
		}
MouseGetPos, mouseX, mouseY, Wid, control
; Fixing the different scaling settings for mouse later. Second screen is to the left of my main so I can easily detect which screen I am on.
; If you 
If mouseX < 0  
		{
		display := -1 ; 1080p screen with 100% scaling
		mouseXold := mouseX  ; Just for testing purposes so I could print out values
		mouseYold := mouseY  ; Just for testing purposes so I could print out values
		mouseX := mouseX / (scalingPercent / 100)  ; Factors the Windows scaling in and outputs proper coordinates when returning position
		mouseY := mouseY / (scalingPercent / 100)
		}
	else
		{
		display := 1 ; 4k screen with 125% scaling
		}
Click, %audTaskBarIconX%, %audTaskBarIconY%  ; Needed to click twice for some reason for it to reliably work.
Click, %audTaskBarIconX%, %audTaskBarIconY%  ; Clicking on the Audio Icon on Task Bar (I have Small Taskbar Icons on)
WinWaitActive, ahk_class Windows.UI.Core.CoreWindow  ; Waits for the audio output menu to open
Send, {tab}
Send, {Enter}
SLEEP, 50
if device == 0 
	{
	Send, {tab}
	Send, {Home}
	Send, {Enter}
	Send, {Esc}
	}
else ;if device > 0
		{
		Send, {tab}
		Send, {Home}
		Send, {Down %device%}
		Send, {Esc}
		}
MouseMove, mouseX, mouseY ; moves cursor to where it was previously
WinActivate, ahk_id %Wid% ; activates window that was active last
SoundPlay, *64  ; Asterisk (info)
TrayTip, %MatchedTitle%, %audiotitle% is now active, 2, 17 ; 2 seconds, info icon (1) without sound (+16)
SetTimer, removeTrayTip1, 2000  ; TrayTip durations under 10 seconds don't work, remove ourselves after 2 second timer		
;MsgBox, audiotitle = %audiotitle%`ndevice = %device%`ndisplay = %display%`nOld Mouse X = %mouseXold% || Old Mouse Y = %mouseYold%`n Mouse X = %mouseX% || Mouse Y = %mouseY%`n Audio Device 1 = %audDev1%`nAudio Device 2 = %audDev2%; For Troubleshooting/Testing
} ;End Function

removeTrayTip1() {
   SetTimer, RemoveTrayTip1, Off
   TrayTip  ; without parameters, removes displayed traytip
}
