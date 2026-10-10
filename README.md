# Ar-En Layout Corrector

حدّد النص المكتوب بالخطأ، وبضغطة واحدة علي CapsLock يتحول فوراً من العربية للإنجليزية والعكس!

> أداة خفيفة ومستقلة لنظام ويندوز مبنية على AutoHotkey v2، تقوم بتصحيح النصوص المكتوبة باللغة الخطأ في مكانها مباشرة وبضغطة زر واحدة تلقائياً دون الحاجة لاعادة كتابة النص وبدون استهلاك موارد النظام.

Select any mistyped text, press `CapsLock`, and watch it instantly swap between Arabic and English.

> A zero-bloat, standalone lean & clean utility (or a raw AHK script if you prefer!) that fixes mismatched AR/EN keyboard inputs in-place across any Windows application saving you lots of re-writes.


| Arabic Error | English | │ | │ | English Error | Arabic |
| :--- | :--- | :---: | :---: | :--- | :--- |
| لخخلمث | google | │ | │ | sghl | سلام |
| بشؤثلاخخن | facebook | │ | │ | a;vh | شكرا |
| غخعفعلاث | youtube | │ | │ | jlhl | تمام |
| اثممخ | hello | │ | │ | kul | نعم |
| اه | hi | │ | │ | b | لا |
| خن | ok | │ | │ | wfhp hgodv | صباح الخير |
| فاشىنس | thanks | │ | │ | lshx hgodv | مساء الخير |
| غثس | yes | │ | │ | hk ahx hggi | ان شاء الله |
| شيةهى | admin | │ | │ | pfdfd | حبيبي |
| فثسف | test | │ | │ | high | اهلا |


---

## Features

- **Bidirectional Conversion:** Seamlessly maps EN US QWERTY $\leftrightarrow$ Arabic 101/102.
- **In-Place Replacement:** Modifies selected text directly in any text box, editor, browser, or terminal.
- **Safe Fallback:** If no text is selected, `CapsLock` functions as normal.
- **Clipboard Preserved:** Uses and automatically restores previous clipboard content after execution.

---

## How to Use It

1. **Highlight** any text mistyped in the wrong layout:
   - Example: `اثممخ` $\rightarrow$ `hello`
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

### Running Tests
- Run `tests/test_corrector.ahk` with AutoHotkey v2 to execute the test suite (74 automated assertions).

---

## How It Works

1. When the trigger key (`CapsLock`) is pressed:
   - Backs up existing clipboard data using `ClipboardAll()`.
   - Clears `A_Clipboard` and sends `Ctrl+C` (`Send("^c")`).
   - Uses `ClipWait(0.3)`. If no text was highlighted, toggles the native Caps Lock LED state and exits.
2. Passes copied text into `ConvertLayout(text)`:
   - Counts Arabic vs. Latin characters to detect the dominant script.
   - If Arabic dominant:
     - Pre-processes 2-character ligatures (`لا` $\rightarrow$ `b`, `لآ` $\rightarrow$ `B`, `لإ` $\rightarrow$ `T`, `لأ` $\rightarrow$ `G` and precomposed variants).
     - Translates each character using a case-sensitive Arabic $\rightarrow$ English map.
   - If English dominant:
     - Translates each character using a case-sensitive English $\rightarrow$ Arabic map (mapping `b` $\rightarrow$ `لا`, `B` $\rightarrow$ `لآ`, `T` $\rightarrow$ `لإ`, `G` $\rightarrow$ `لأ`).
3. Sets `A_Clipboard := convertedText`, sends `Ctrl+V` (`Send("^v")`), waits `Sleep(120)` to ensure target app processes the paste, and restores the original clipboard.

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

## Layout Mapping Table

- **Ligatures**: `b` $\leftrightarrow$ `لا`, `B` $\leftrightarrow$ `لآ`, `T` $\leftrightarrow$ `لإ`, `G` $\leftrightarrow$ `لأ` are handled seamlessly in both directions (including compatibility precomposed ligatures `ﻻ`, `ﻵ`, `ﻹ`, `ﻷ`).
- **Numbers**: Digits (`0-9`) remain untouched.

|q|w|e|r|t|y|u|i|o|p|[|]|a|s|d|f|g|h|j|k|l|;|'|z|x|c|v|b|n|m|,|.|/|`|Q|W|E|R|T|Y|U|I|O|P|{|}|A|S|D|F|G|H|J|K|L|:|`"|Z|X|C|V|B|N|M|<|>|?|~|
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
|ض|ص|ث|ق|ف|غ|ع|ه|خ|ح|ج|د|ش|س|ي|ب|ل|ا|ت|ن|م|ك|ط|ئ|ء|ؤ|ر|لا|ى|ة|و|ز|ظ|ذ|َ|ً|ُ|ٌ|لإ|إ|‘|÷|×|؛|<|>|ِ|ٍ|]|[|لأ|أ|ـ|،|/|:|"|~|ْ|}|{|لآ|آ|’|,|.|؟|ّ|
