# Ar-En-layout-corrector

> Select any mistyped text, press `CapsLock`, and watch it instantly swap between Arabic and English.

A zero-bloat, standalone AutoHotkey v2 exe utility (or a raw script if you prefer!) that fixes mismatched keyboard layout text in-place across any Windows application saving you from keylogging and/or background telemetry.

---

## Features

- **Bidirectional Conversion:** Seamlessly maps EN US QWERTY $\leftrightarrow$ Arabic 101/102.
- **In-Place Replacement:** Modifies selected text directly in any text box, editor, browser, or terminal.
- **Safe Fallback:** If no text is selected, `CapsLock` functions as normal.
- **Clipboard Preserved:** Uses and automatically restores previous clipboard content after execution.

---

## How to Use

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
- Double-click `LayoutSwitcher.ahk` to launch.

---

## Configuration

To change the default trigger key, edit the first line of the hotkey definition in `LayoutSwitcher.ahk`:

```autohotkey
; Default: CapsLock
CapsLock::

; Example alternative: Ctrl + Shift + X
^+x::
