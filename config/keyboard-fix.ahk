#Requires AutoHotkey v2.0
#SingleInstance Force
InstallKeybdHook()

; *Capslock:: {
;     if (KeyWait("Capslock", "T0.1")) {
;         Send("{Blind}{Esc}")
;     } else {
;         Send("{Blind}{LCtrl down}")
;         KeyWait("Capslock")
;         Send("{Blind}{LCtrl up}")
;     }
; }

~LShift & RShift::SetCapsLockState(!GetKeyState("CapsLock", "T"))
~RShift & LShift::SetCapsLockState(!GetKeyState("CapsLock", "T"))

; ; --- Home Row Mods Setup ---
; TapHoldTime := 180 ; Timeout threshold in milliseconds
;
; ; Define home row keys: key -> modifier name
; global HRKeys := Map(
;     "a", "LWin",
;     "s", "LAlt",
;     "d", "LControl",
;     "f", "LShift",
;     "j", "RShift",
;     "k", "RControl",
;     "l", "RAlt",
;     ";", "RWin"
; )
;
; for key, modifier in HRKeys {
;     Hotkey("$" key, HandleHRM.Bind(key, modifier))
; }
;
; HandleHRM(key, modifier, *) {
;     startTime := A_TickCount
;     buffer := ""
;
;     ; Create an InputHook to capture any keys pressed DURING the decision window
;     ih := InputHook("V L0")
;     ih.KeyOpt("{All}", "N")
;
;     ih.OnKeyDown := (thisIH, vk, sc) => (
;         buffer := key
;     )
;
;     ih.Start()
;
;     while GetKeyState(key, "P") {
;         if (A_TickCount - startTime >= TapHoldTime) || (buffer != "") {
;             break
;         }
;         Sleep(5)
;     }
;
;     ih.Stop()
;
;     if (buffer != "") || (A_TickCount - startTime >= TapHoldTime) {
;         Send("{Blind}{" modifier " Down}")
;         KeyWait(key)
;         Send("{Blind}{" modifier " Up}")
;     } else {
;         Send("{Blind}{" key "}")
;     }
; }
