#Requires AutoHotkey v2.0

; ==== Autojoin Loop for SCP:SL ====

; ===== CONFIG =====
GAME_WINDOW_TITLE := "SCPSL"         ; The name of the SCPSL window
COMMAND := "connect " ; Command to send
RETRY_INTERVAL := 5                  ; Seconds between attempts
; ==================

paused := false

; ==== Hotkeys ====
^!p:: {   ; Ctrl+Alt+P -> Pause/Resume
    global paused  ; ensure we use the global variable
    paused := !paused
    return
}

^!q::ExitApp   ; Ctrl+Alt+Q -> Quit script immediately

; ==== Focus the game window immediately when script runs ====
if WinExist(GAME_WINDOW_TITLE)
{
    WinActivate(GAME_WINDOW_TITLE)
    Sleep 200
}

; ==== Timer Loop ====
SetTimer SendCommand, RETRY_INTERVAL * 1000  ; Retry every RETRY_INTERVAL seconds
return

SendCommand() {
    global paused, GAME_WINDOW_TITLE, COMMAND
    if paused
        return  ; Do nothing if paused

    if WinExist(GAME_WINDOW_TITLE) {
        WinActivate(GAME_WINDOW_TITLE)
        Sleep 200
        Send("{Enter}")  ; open console
        Sleep 120
        Send(COMMAND)
        Sleep 80
        Send("{Enter}")
        ; silent - no ToolTip
    }
}
