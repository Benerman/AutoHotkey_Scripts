; Test

#NoEnv
#SingleInstance force
#WinActivateForce
SendMode Input
;SetTitleMatchMode, Regex ; not knowing your window title, 1 is probably adequate
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2	
;detecthiddenwindows, on ;Chrome has weird hidden windows and this doesn't need to be on currently.

#InstallKeybdHook
#InstallMouseHook
#UseHook
#KeyHistory 500


F11::showMsgBox(50)

showMsgBox(number1) {
loopcount = 0
a == False
If a == True
	{
	MsgBox,,, This is Message Box 1`n number1 = %number1%`nloopcount = %loopcount%, 1
	If number1 = 0
		{
		MsgBox Number 0`nloopcount = %loopcount%
		loopcount++
		}
	else
		{
		MsgBox, number %number1%`nloopcount = %loopcount%
		loopcount++
		}
	}
else
	MsgBox,,, This is else`nnumber` = %number1%`nloopcount = %loopcount%
	return
}
;==========================================================================================================================================================
;==========================================================================================================================================================
;==========================================================================================================================================================
;==========================================================================================================================================================

F12:: ;Chrome functions
if keypresses > 0 ; SetTimer already started, so we log the keypress instead.
{
    keypresses += 1
    return
}
; Otherwise, this is the first press of a new series. Set count to 1 and start
; the timer:
keypresses = 1
SetTimer, KeyPress, -350 ; Wait for more presses within a 400 millisecond window.
return

KeyPress:
if keypresses = 1 ; The key was pressed once.
{
    switchToChrome(0) ; keypressaction1 := 
	;keyaction1 = %keypressaction1%
}
else if keypresses = 2 ; The key was pressed twice.
{
    switchToChrome(2) ; keypressaction2 := 
	;keyaction2 = %keypressaction2%
}
else if keypresses = 3
{
    switchToChrome(1) ; keypressaction3 := 
	;keyaction3 = %keypressaction3%
}
; Regardless of which action above was triggered, reset the count to
; prepare for the next series of presses:
keypresses = 0
SetTimer, KeyPress, off
return

switchToChrome(chrometab) {
;msgbox,,, chrometab = %chrometab%, .1
If !WinExist("ahk_exe chrome.exe")
	{
	Run, chrome.exe, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" , Max, ChromePID
	;WinGet, ChromePID, PID, ahk_exe chrome.exe
	;MsgBox,,, ChromePID = %ChromePID%, 1
	GroupAdd, ChromeGroup, ahk_exe chome.exe
	return
	}
else 
	{
	If WinActive("ahk_exe chrome.exe")
		{
		;WinMaximize, ahk_exe chrome.exe
		;WinGet, ChromePID, PID, ahk_exe chrome.exe
		;msgbox,,,WinActive`nChrometab = %chrometab%, 1
		If chrometab = 0
			{
			;Sendinput, ^{tab}
			;msgbox,,, Send Next tab, .1
			SendInput, {Ctrl down}{Tab}{Ctrl up}
			;MsgBox,,, Win Active IF `nForward Tab`nchrometab = %chrometab%, 3
			
			}			
		else ;if chrometab > 0
		;If chrometab != 0 ; Switch to JIRA tab
			{
			Send, {Ctrl down}%chrometab%{Ctrl up}
			;MsgBox,,, Win Active Else`nchrometab = %chrometab%, 3
			}
		}
	else ;If !WinActive("ahk_exe chrome.exe")
		{
		WinActivate, ahk_exe chrome.exe
		;WinMaximize, ahk_exe chrome.exe
		;msgbox,,, All else `nchrometab = %chrometab%, 3
		If chrometab > 0
			{
			Send, {Ctrl down}%chrometab%{Ctrl up}
			;MsgBox,,, Else chrometab = %chrometab%, 3
			}			
		else ;chrometab > 0 ; Switch to JIRA tab
			{
			;This just activates Chrome and returns to Tab that was open
			;MsgBox,,, Return`nchrometab = %chrometab%
			return
			}
		return
		}
	return
	}
chrometab = 0
;msgbox,,, Set chrometab to 0, 1
return
}


runFunctionCommand(function, action) {
if function == chrome
	if action == 0
		switchToChrome(0)
	else if action == 1
		switchToChrome(1)
	else if action == 2
		switchToChrome(2)
	else
		return
else if function == shoot
	if action == 0
		switchToSmartShooter()
	else if action == 1
		switchToDJVViewer()
	else
		return
else if function == scanhud
	switchToScanHUD()
else if function == explorer
	if action == 0
		switchToExplorer()
	else if action == 1
		closeExplorer()
	else
		return
else if function == dline
	if action == 0
		switchToDeadline()
	else if action == 1
		switchToAgisoft()
	else
		return
else if function == slack
	if action == 0
		switchToSlack()
	else if action == 1
		switchToNotepadPlusPlus()
	else
		return
else
	return
}
