# Ar-En Layout Corrector

> حدّد النص المكتوب بالخطأ، وبضغطة واحدة علي CapsLock يتحول فوراً بين اللغتين العربية والإنجليزية.

أداة خفيفة ومستقلة لنظام ويندوز مبنية على AutoHotkey v2، تقوم بتصحيح النصوص المكتوبة باللغة الخطأ في مكانها مباشرة وبضغطة زر واحدة تلقائياً دون الحاجة لاعادة كتابة النص وبدون استهلاك موارد النظام.

> Select any mistyped text, press `CapsLock`, and watch it instantly swap between Arabic and English.

A zero-bloat, standalone lean & clean utility (or a raw AHK script if you prefer!) that fixes mismatched AR/EN keyboard inputs in-place across any Windows application saving you lots of re-writes.


| English | Arabic Error |   |   | Arabic | English Error |
| --- | --- | --- | --- | ---| --- |
| google | لخخلمث |   |   | سلام | sghl |
| facebook | بشؤثبخخن |   |   | شكرا | a;vh |
| youtube | غخعفعلاث |   |   | تمام | jthl |
| hello | اثممخ |   |   | نعم | kul |
| hi | اه |   |   | لا | b |
| ok | خن |   |   | صباح الخير | wfhp hgwnv |
| thanks | فاشدنس |   |   | مساء الخير | lshx hgwnv |
| yes | غثس |   |   | ان شاء الله | hk ahx hggi |
| admin | شسةهد |   |   | حبيبي | pfdfd |
| test | فثسف |   |   | اهلا | higsh |


---

## Features

- **Bidirectional Conversion:** Seamlessly maps EN US QWERTY $\leftrightarrow$ Arabic 101/102.
- **In-Place Replacement:** Modifies selected text directly in any text box, editor, browser, or terminal.
- **Safe Fallback:** If no text is selected, `CapsLock` functions as normal.
- **Clipboard Preserved:** Uses and automatically restores previous clipboard content after execution.

---

## How to Use It

1. **Highlight** any text mistyped in the wrong layout:
   - Example: `أثممخ` $\rightarrow$ `hello`
   - Example: `sghl` $\rightarrow$ `سلام`
2. Press **`CapsLock`**.
3. The selected text is instantly replaced with the correct layout characters.

---

## Requirements & Setup

### Running Compiled (.exe)
- No dependencies or AutoHotkey installation required.
- Download `AR_EN_Corrector.exe` from the releases to the right.
- Place the downloaded file in your Windows Startup folder (`Win + R` $\rightarrow$ `shell:startup`) to have it run automatically on boot.

### Running from Source
- Requires **AutoHotkey v2.0+**.
- Double-click `AR_EN_Corrector.ahk` to launch.

---

## How It Works

1. When the trigger key (`CapsLock`) is pressed:
   - Backs up existing clipboard data using `ClipboardAll()`.
   - Clears `A_Clipboard` and sends `Ctrl+C` (`Send("^c")`).
   - Uses `ClipWait(0.3)`. If no text was highlighted, toggles the native Caps Lock LED state and exits.
2. Passes copied text into `ConvertLayout(text)`:
   - Defines two strings: `en` (US QWERTY characters) and `ar` (Arabic equivalents).
   - Loops character by character (`Loop Parse, text`).
   - Checks `InStr(en, char, true)` first. If found, takes `SubStr(ar, posEn, 1)`.
   - Otherwise checks `InStr(ar, char, true)`. If found, takes `SubStr(en, posAr, 1)`.
3. Sets `A_Clipboard := convertedText`, sends `Ctrl+V` (`Send("^v")`), waits `Sleep(50)`, and restores the original clipboard.


---

## Configuration

To change the default trigger key, edit the first line of the hotkey definition in `AR_EN_Corrector.ahk`:

```autohotkey
; Default: CapsLock
CapsLock::
```
```autohotkey
; Example alternative: Ctrl + Shift + X
^+x::
```

---

## Known issues:

### Current mapping:

<!-- qwertyuiop[]asdfghjkl;'zxcvbnm,./`QWERTYUIOP{}ASDFGHJKL:`"ZXCVBNM<>?~
ضصثقفغعهخحجدشسيبلاتنمكطئءؤرلاىةوزظذًٌَُلإإ‘÷×؛<>\ٍِ]أـ،/:" . '""' . "’~,.؟ّ -->

|q|w|e|r|t|y|u|i|o|p|[|]|a|s|d|f|g|h|j|k|l|;|'|z|x|c|v|b|n|m|,|.|/|`|Q|W|E|R|T|Y|U|I|O|P|{|}|A|S|D|F|G|H|J|K|L|:|`"|Z|X|C|V|B|N|M|<|>|?|~|
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
|ض|ص|ث|ق|ف|غ|ع|ه|خ|ح|ج|د|ش|س|ي|ب|ل|ا|ت|ن|م|ك|ط|ئ|ء|ؤ|ر|لا|ى|ة|و|ز|ظ|ذ|َ|ً|ُ|ٌ|لإ|إ|‘|÷|×|؛|<|>|\ | ِ|]|[|أ|ـ|،|/|:|"| \.| |'|""|\| |.| |"|’|~|,\.|؟|ّ|

---

### To be adjusted to:

<!-- q w e r t y u i o p [ ] a s d f g h j k l ; ' z x c v b n m , . / ` Q W E R T Y U I O P { } A S D F G H J K L : `" Z X C V B N M < > ? ~
ض ص ث ق ف غ ع ه خ ح ج د ش س ي ب ل ا ت ن م ك ط ئ ء ؤ ر لا ى ة و ز ظ ذ َ ً ُ ٌ لإ إ ‘ ÷ × ؛ < > ِ ٍ ] [ لأ أ ـ ، / : " ~ ْ } { لآ آ ’ , . ؟ ّ
 -->


|q|w|e|r|t|y|u|i|o|p|[|]|a|s|d|f|g|h|j|k|l|;|'|z|x|c|v|b|n|m|,|.|/|`|Q|W|E|R|T|Y|U|I|O|P|{|}|A|S|D|F|G|H|J|K|L|:|`"|Z|X|C|V|B|N|M|<|>|?|~|
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
|ض|ص|ث|ق|ف|غ|ع|ه|خ|ح|ج|د|ش|س|ي|ب|ل|ا|ت|ن|م|ك|ط|ئ|ء|ؤ|ر|لا|ى|ة|و|ز|ظ|ذ|َ|ً|ُ|ٌ|لإ|إ|‘|÷|×|؛|<|>|ِ|ٍ|]|[|لأ|أ|ـ|،|/|:|"|~|ْ|}|{|لآ|آ|’|,|.|؟|ّ|