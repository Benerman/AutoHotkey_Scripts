#IfWinActive
^F13::Send, !{Tab}
; ^F14::
; ^F16::
; ^F17::
;F19::switchToExplorer()
^F19::switchToExplorer()
!F19::closeAllExplorers()
^F20::switchToChrome(1)
; ^F21::
^F22::switchToProgram("sublime")
^F23::switchToProgram("resolve")
^F24::switchToProgram("notepad")
F21::Send, ^c
F24::Send, ^v

F15::XButton2 ;G11 Go Forward
F18::XButton1 ;G14 Go Back

^+!-::Pause, toggle
^+!=::Reload
^+!0::runWindowSpy()
^+!Esc::ExitApp
~`::RapidHotkey("exit", 4, 0.2, 1) ;Press Esc 4 times rapidly to exit this script


runWindowSpy(){
Run, "C:\Program Files\AutoHotkey\WindowSpy.ahk"
return
}


switchToExplorer(){
IfWinNotExist, ahk_class CabinetWClass
	Run, explorer.exe
	GroupAdd, taranexplorers, ahk_class CabinetWClass
if WinActive("ahk_exe explorer.exe")
	GroupActivate, taranexplorers, r
else
	WinActivate ahk_class CabinetWClass ;you have to use WinActivatebottom if you didn't create a window group.
}

switchToChrome(tabNumber) {
If !WinExist("ahk_class Chrome_WidgetWin_1")
	{
	Run, chrome.exe, C:\Program Files (x86)\Google\Chrome\Application\, Max
	GroupAdd, ChromeGroup, ahk_class Chrome_WidgetWin_1
	return
	}
else
	{	
	If WinActive("ahk_class Chrome_WidgetWin_1")
		{
		SendInput ^{tab %tabNumber%}
		return
		}
	else
		{
		;WinActivate
		GroupActivate, ChromeGroup, r
		return
		}
	}
}


closeAllExplorers()
{
WinClose, ahk_group taranexplorers
}


switchToProgram(program){
;MsgBox, program that should run is: %program%
; name = should be ahk_class, ahk_group, ahk_exe... etc
; ahk_class Qt5QWindowIcon
; path = full file path with exe on end of path
; "C:\Program Files\Blackmagic Design\DaVinci Resolve\Resolve.exe"
if ("sublime" == program)
	{
	name 	:= "ahk_exe sublime_text.exe"
	path 	:= "C:\Program Files\Sublime Text 3\sublime_text.exe"
	}
else if ("resolve" == program)
	{ 
	name	:= "ahk_class Qt5QWindowIcon"
	path	:= "C:\Program Files\Blackmagic Design\DaVinci Resolve\Resolve.exe"
	}
else if ("notepad" == program)
	{
	name 	:= "ahk_exe notepad++.exe"
	path 	:= "C:\Program Files (x86)\Notepad++\notepad++.exe"
	}
else
	{
	return
	}
If !WinExist("%name%")
	Run, %path%
else
	WinActivate %name%
return
}
