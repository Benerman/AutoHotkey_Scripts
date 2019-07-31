

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
