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
    
    ; Restore original clipboard after brief delay to prevent race condition
    Sleep(120)
    A_Clipboard := savedClip
}

ConvertLayout(text) {
    if (text = "")
        return ""

    static initialized := false
    static enToAr := Map()
    static arToEn := Map()

    if (!initialized) {
        enToAr.CaseSense := "On"
        arToEn.CaseSense := "On"

        enKeys := [
            ; Unshifted (34 keys)
            "q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "[", "]",
            "a", "s", "d", "f", "g", "h", "j", "k", "l", ";", "'",
            "z", "x", "c", "v", "b", "n", "m", ",", ".", "/", "``",
            ; Shifted (34 keys)
            "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "{", "}",
            "A", "S", "D", "F", "G", "H", "J", "K", "L", ":", '"',
            "Z", "X", "C", "V", "B", "N", "M", "<", ">", "?", "~"
        ]

        arKeys := [
            ; Unshifted (34 keys)
            "ض", "ص", "ث", "ق", "ف", "غ", "ع", "ه", "خ", "ح", "ج", "د",
            "ش", "س", "ي", "ب", "ل", "ا", "ت", "ن", "م", "ك", "ط",
            "ئ", "ء", "ؤ", "ر", "لا", "ى", "ة", "و", "ز", "ظ", "ذ",
            ; Shifted (34 keys)
            "َ", "ً", "ُ", "ٌ", "لإ", "إ", "‘", "÷", "×", "؛", "<", ">",
            "ِ", "ٍ", "]", "[", "لأ", "أ", "ـ", "،", "/", ":", '"',
            "~", "ْ", "}", "{", "لآ", "آ", "’", ",", ".", "؟", "ّ"
        ]

        Loop enKeys.Length {
            e := enKeys[A_Index]
            a := arKeys[A_Index]
            enToAr[e] := a
            arToEn[a] := e
        }

        ; Additional compatibility ligatures for Arabic -> English
        arToEn["ﻻ"] := "b"
        arToEn["ﻵ"] := "B"
        arToEn["ﻹ"] := "T"
        arToEn["ﻷ"] := "G"

        initialized := true
    }

    ; Detect dominant script to resolve direction and punctuation ambiguity
    arabicCount := 0
    latinCount := 0
    Loop Parse, text {
        code := Ord(A_LoopField)
        if ((code >= 0x0600 && code <= 0x06FF) || (code >= 0xFB50 && code <= 0xFDFF) || (code >= 0xFE70 && code <= 0xFEFF))
            arabicCount++
        else if ((code >= 65 && code <= 90) || (code >= 97 && code <= 122))
            latinCount++
    }

    if (arabicCount >= latinCount && arabicCount > 0)
        return ConvertArabicToEnglish(text, arToEn)
    else
        return ConvertEnglishToArabic(text, enToAr)
}

ConvertArabicToEnglish(text, arToEn) {
    ; Replace multi-character ligatures before parsing individual characters
    text := StrReplace(text, "لآ", "B")
    text := StrReplace(text, "لأ", "G")
    text := StrReplace(text, "لإ", "T")
    text := StrReplace(text, "لا", "b")
    text := StrReplace(text, "ﻵ", "B")
    text := StrReplace(text, "ﻷ", "G")
    text := StrReplace(text, "ﻹ", "T")
    text := StrReplace(text, "ﻻ", "b")

    result := ""
    Loop Parse, text {
        char := A_LoopField
        if arToEn.Has(char)
            result .= arToEn[char]
        else
            result .= char
    }
    return result
}

ConvertEnglishToArabic(text, enToAr) {
    result := ""
    Loop Parse, text {
        char := A_LoopField
        if enToAr.Has(char)
            result .= enToAr[char]
        else
            result .= char
    }
    return result
}