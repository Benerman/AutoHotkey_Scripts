
;============================
; Within Sublime Text 3 Editor it will drop in some text for Cypress.io automation
#IfWinActive ahk_exe sublime_text.exe
^+!]::
SendRaw, describe('description', function() {
SendInput, {Del 2}
SendInput, `n
Return

^+!'::
SendRaw, it('action', function () {
SendInput, {Del 2}
SendInput, `n
Return

^+!/::
SendRaw, });
Return

;============================
; Capture One automations

 Capture One Functions
; Subroutines
ResetCrop:
CoordMode, Mouse, Window
MouseGetPos, Xpos, Ypos,
Click, 1546, 54
sleep, 100
Click, Right, 457, 227
sleep, 100
Click, 408, 16
sleep, 100 
MouseMove, -100, -100
Click, 1459, 49
CoordMode, Mouse, Screen
MouseMove, Xpos * 1.125, Ypos * 1.125,
Sleep, 100
SendInput, h
return

#IfWinActive ahk_exe CaptureOne.exe
F19::Gosub ResetCrop

; With G-Shift Held
^F13::
^F14::^5 ; Tool Tab #5
^F15::^1 ; Tool Tab #1
^F16::
^F17::^6 ; Tool Tab #6
^F18::^2 ; Tool Tab #2
^F19::
^F20::^7 ; Tool Tab #7
^F21::^3 ; Tool Tab #3
^F22::
^F23::^8 ; Tool Tab #8
^F24::^4 ; Tool Tab #4
