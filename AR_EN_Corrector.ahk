#Requires AutoHotkey v2.0
#SingleInstance Force

; Shortcut: CapsLock to flip selected text (or change to ^!x for Ctrl+Alt+X)
CapsLock::
{
    ; Backup current clipboard content
    savedClip := ClipboardAll()
    A_Clipboard := ""
    
    ; Copy selected text
    Send("^c")
    if !ClipWait(0.3)
    {
        ; If nothing selected, just toggle standard CapsLock behavior
        SetCapsLockState(!GetKeyState("CapsLock", "T"))
        return
    }

    originalText := A_Clipboard
    convertedText := ConvertLayout(originalText)
    
    A_Clipboard := convertedText
    Send("^v")
    
    ; Restore original clipboard after brief delay
    Sleep(50)
    A_Clipboard := savedClip
}

ConvertLayout(text) {
    ; US QWERTY Characters
    en := "qwertyuiop[]asdfghjkl;'zxcvbnm,./`QWERTYUIOP{}ASDFGHJKL:`"ZXCVBNM<>?~"
    ; Arabic 101 Equivalent Key Characters
    ar := "ضصثقفغعهخحجدشسيبلاتنمكطئءؤرلاىةوزظذًٌَُلإإ‘÷×؛<>\ٍِ]أـ،/:" . '""' . "’~,.؟ّ"

    result := ""
    Loop Parse, text
    {
        char := A_LoopField
        posEn := InStr(en, char, true)
        posAr := InStr(ar, char, true)

        if (posEn > 0)
            result .= SubStr(ar, posEn, 1)
        else if (posAr > 0)
            result .= SubStr(en, posAr, 1)
        else
            result .= char
    }
    return result
}