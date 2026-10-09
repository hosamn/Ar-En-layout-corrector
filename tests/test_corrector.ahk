#Requires AutoHotkey v2.0

; Attach to caller console for CLI output
DllCall("AttachConsole", "int", -1)

try FileDelete(A_ScriptDir . "\test_results.log")

passed := 0
failed := 0
outputLog := ""

AssertTest(input, expected, testName) {
    global passed, failed, outputLog
    actual := ConvertLayout(input)
    if (actual == expected) {
        passed++
        msg := "[PASS] " . testName . "`n"
    } else {
        failed++
        msg := "[FAIL] " . testName . "`n  Input:    '" . input . "'`n  Expected: '" . expected . "'`n  Actual:   '" . actual . "'`n"
    }
    outputLog .= msg
    try FileAppend(msg, "*")
}

; ==============================================================================
; Test Suite: English -> Arabic (README examples & mappings)
; ==============================================================================
AssertTest("google", "لخخلمث", "EN->AR: google")
AssertTest("facebook", "بشؤثلاخخن", "EN->AR: facebook")
AssertTest("youtube", "غخعفعلاث", "EN->AR: youtube")
AssertTest("hello", "اثممخ", "EN->AR: hello")
AssertTest("hi", "اه", "EN->AR: hi")
AssertTest("ok", "خن", "EN->AR: ok")
AssertTest("thanks", "فاشىنس", "EN->AR: thanks")
AssertTest("yes", "غثس", "EN->AR: yes")
AssertTest("admin", "شيةهى", "EN->AR: admin")
AssertTest("test", "فثسف", "EN->AR: test")

; ==============================================================================
; Test Suite: Arabic -> English (README examples & mappings)
; ==============================================================================
AssertTest("سلام", "sbl", "AR->EN: salam -> sbl (via ligature b)")
AssertTest("sghl", "سلام", "EN->AR: sghl -> salam")
AssertTest("sbl", "سلام", "EN->AR: sbl -> salam")
AssertTest("شكرا", "a;vh", "AR->EN: shukran")
AssertTest("a;vh", "شكرا", "EN->AR: a;vh -> shukran")
AssertTest("تمام", "jlhl", "AR->EN: tamam")
AssertTest("jlhl", "تمام", "EN->AR: jlhl -> tamam")
AssertTest("نعم", "kul", "AR->EN: na'am")
AssertTest("kul", "نعم", "EN->AR: kul -> na'am")
AssertTest("صباح الخير", "wfhp hgodv", "AR->EN: sabah al-khair")
AssertTest("wfhp hgodv", "صباح الخير", "EN->AR: wfhp hgodv -> sabah al-khair")
AssertTest("مساء الخير", "lshx hgodv", "AR->EN: masa' al-khair")
AssertTest("lshx hgodv", "مساء الخير", "EN->AR: lshx hgodv -> masa' al-khair")
AssertTest("ان شاء الله", "hk ahx hggi", "AR->EN: in sha' Allah")
AssertTest("hk ahx hggi", "ان شاء الله", "EN->AR: hk ahx hggi -> in sha' Allah")
AssertTest("حبيبي", "pfdfd", "AR->EN: habibi")
AssertTest("pfdfd", "حبيبي", "EN->AR: pfdfd -> habibi")
AssertTest("اهلا", "hib", "AR->EN: ahlan -> hib (via ligature b)")
AssertTest("high", "اهلا", "EN->AR: high -> ahlan")
AssertTest("hib", "اهلا", "EN->AR: hib -> ahlan")

; ==============================================================================
; Test Suite: Ligatures (b, B, T, G <-> لا, لآ, لإ, لأ)
; ==============================================================================
AssertTest("b", "لا", "Ligature EN->AR: b -> lam-alif")
AssertTest("لا", "b", "Ligature AR->EN: lam-alif -> b")
AssertTest("B", "لآ", "Ligature EN->AR: B -> lam-alif madda")
AssertTest("لآ", "B", "Ligature AR->EN: lam-alif madda -> B")
AssertTest("T", "لإ", "Ligature EN->AR: T -> lam-alif hamza below")
AssertTest("لإ", "T", "Ligature AR->EN: lam-alif hamza below -> T")
AssertTest("G", "لأ", "Ligature EN->AR: G -> lam-alif hamza above")
AssertTest("لأ", "G", "Ligature AR->EN: lam-alif hamza above -> G")

; Precomposed compatibility ligatures
AssertTest("ﻻ", "b", "Ligature Compat: ﻻ (U+FEFB) -> b")
AssertTest("ﻵ", "B", "Ligature Compat: ﻵ (U+FEF5) -> B")
AssertTest("ﻹ", "T", "Ligature Compat: ﻹ (U+FEF9) -> T")
AssertTest("ﻷ", "G", "Ligature Compat: ﻷ (U+FEF7) -> G")

; ==============================================================================
; Test Suite: Shifted Symbols, Tashkeel & Punctuation
; ==============================================================================
AssertTest("?", "؟", "Punctuation EN->AR: ? -> ؟")
AssertTest("؟", "?", "Punctuation AR->EN: ؟ -> ?")
AssertTest("P", "؛", "Shifted EN->AR: P -> Arabic semicolon")
AssertTest("؛", "P", "Shifted AR->EN: Arabic semicolon -> P")
AssertTest("K", "،", "Shifted EN->AR: K -> Arabic comma")
AssertTest("،", "K", "Shifted AR->EN: Arabic comma -> K")
AssertTest("~", "ّ", "Tashkeel EN->AR: ~ -> Shadda")
AssertTest("ّ", "~", "Tashkeel AR->EN: Shadda -> ~")
AssertTest("Q", "َ", "Tashkeel EN->AR: Q -> Fatha")
AssertTest("َ", "Q", "Tashkeel AR->EN: Fatha -> Q")
AssertTest("W", "ً", "Tashkeel EN->AR: W -> Tanwin Fatha")
AssertTest("ً", "W", "Tashkeel AR->EN: Tanwin Fatha -> W")
AssertTest("E", "ُ", "Tashkeel EN->AR: E -> Damma")
AssertTest("ُ", "E", "Tashkeel AR->EN: Damma -> E")
AssertTest("R", "ٌ", "Tashkeel EN->AR: R -> Tanwin Damma")
AssertTest("ٌ", "R", "Tashkeel AR->EN: Tanwin Damma -> R")
AssertTest("A", "ِ", "Tashkeel EN->AR: A -> Kasra")
AssertTest("ِ", "A", "Tashkeel AR->EN: Kasra -> A")
AssertTest("S", "ٍ", "Tashkeel EN->AR: S -> Tanwin Kasr")
AssertTest("ٍ", "S", "Tashkeel AR->EN: Tanwin Kasr -> S")
AssertTest("X", "ْ", "Tashkeel EN->AR: X -> Sukun")
AssertTest("ْ", "X", "Tashkeel AR->EN: Sukun -> X")
AssertTest("{", "<", "Symbol EN->AR: { -> <")
AssertTest("ض<", "q{", "Symbol in AR context: ض< -> q{")
AssertTest("q{", "ض<", "Symbol in EN context: q{ -> ض<")
AssertTest("}", ">", "Symbol EN->AR: } -> >")
AssertTest("ض>", "q}", "Symbol in AR context: ض> -> q}")
AssertTest("q}", "ض>", "Symbol in EN context: q} -> ض>")

; ==============================================================================
; Test Suite: Untouched Characters (Digits, Spaces, Parentheses, Empty)
; ==============================================================================
AssertTest("1234567890", "1234567890", "Pass-through: digits only")
AssertTest("hello 2026!", "اثممخ 2026!", "Pass-through: mixed text with digits")
AssertTest("(test)", "(فثسف)", "Pass-through: parentheses")
AssertTest("", "", "Pass-through: empty string")

; ==============================================================================
; Output Summary
; ==============================================================================
total := passed + failed
summary := "`n========================================`n"
        . "Test Results: " . (failed = 0 ? "SUCCESS" : "FAILURE") . "`n"
        . "Total Tests: " . total . "`n"
        . "Passed:      " . passed . "`n"
        . "Failed:      " . failed . "`n"
        . "========================================`n"

outputLog .= summary
try FileAppend(summary, "*")
try FileAppend(outputLog, A_ScriptDir . "\test_results.log", "UTF-8")

ExitApp(failed > 0 ? 1 : 0)

#Include ..\AR_EN_Corrector.ahk
