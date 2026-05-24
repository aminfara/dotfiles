# Omarchy Keybindings: macOS Migration Guide

A living reference for adapting Omarchy/Hyprland to macOS muscle memory.
Active config: `~/.config/hypr/bindings.conf`

---

## Design Philosophy

The core idea is to mirror the macOS modifier hierarchy onto Linux modifiers:

| Modifier | macOS role | Linux/Omarchy role |
|---|---|---|
| **Super** (Win/Meta) | **Cmd ⌘** — in-app actions: copy, save, find, undo, new tab | Same — mapped to in-app shortcuts via `sendshortcut` |
| **Ctrl** | System/WM: spaces, window focus, accessibility | **WM actions**: focus window, swap window, workspaces |
| **Alt** | **Option ⌥** — text-level: word jump, special chars | Same — word jump, selection, character-level ops |
| **Shift** | Extends the above (select, reverse, uppercase) | Same |

This works naturally because:
- On macOS, Ctrl already controls Mission Control spaces — here Ctrl controls Hyprland workspaces and window focus
- Super/Cmd is already used by clipboard.conf for copy/paste/cut — we extend it to all in-app actions
- Alt/Option already works for word-level text movement on both platforms

> **Terminal exception:** In terminals, many Ctrl+key combos are reserved by the shell (Ctrl+C = interrupt, Ctrl+Z = suspend). Some Super-key remaps need per-app variants using window-class-specific bindings. See Phase 3 notes.

---

## Migration Status

| Phase | Topic | Status |
|---|---|---|
| 1 | Arrow navigation (Home/End, word jump, window focus) | ✅ Done |
| 2 | Easy-win app shortcuts (no conflicts) | ✅ Done |
| 3 | Conflicting shortcuts (need WM rebinding first) | ✅ Done |
| 4 | App/tab switching (app switcher, workspace nav) | 🔲 Planned |
| 5 | System shortcuts (quit, hide, minimise, lock) | 🔲 Planned |

---

## Phase 1: Arrow Navigation ✅

### What changed

| New binding | New action | Was (Omarchy default) |
|---|---|---|
| `Ctrl` + `←/→/↑/↓` | Focus adjacent window | `Super` + `←/→/↑/↓` (movefocus) |
| `Ctrl+Shift` + `←/→/↑/↓` | Swap window with neighbour | `Super+Shift` + `←/→/↑/↓` (swapwindow) |
| `Super` + `←` | Home (line start) → app | Move focus left (WM) |
| `Super` + `→` | End (line end) → app | Move focus right (WM) |
| `Super` + `↑` | Ctrl+Home (doc start) → app | Move focus up (WM) |
| `Super` + `↓` | Ctrl+End (doc end) → app | Move focus down (WM) |
| `Super+Shift` + `←/→` | Select to line start/end → app | Swap window left/right (WM) |
| `Super+Shift` + `↑/↓` | Select to doc start/end → app | Swap window up/down (WM) |
| `Alt` + `←/→` | Jump word left/right → app | *(was unbound)* |
| `Alt+Shift` + `←/→` | Select word left/right → app | *(was unbound)* |

### macOS parity

| macOS | Linux (now) |
|---|---|
| `Cmd` + `←` | `Super` + `←` ✓ |
| `Cmd` + `→` | `Super` + `→` ✓ |
| `Cmd` + `↑` | `Super` + `↑` ✓ |
| `Cmd` + `↓` | `Super` + `↓` ✓ |
| `Cmd+Shift` + `←/→/↑/↓` | `Super+Shift` + `←/→/↑/↓` ✓ |
| `Option` + `←/→` | `Alt` + `←/→` ✓ |
| `Option+Shift` + `←/→` | `Alt+Shift` + `←/→` ✓ |
| `Ctrl` + `←/→` (spaces) | `Ctrl` + `←/→` (window focus) ✓ |

**Note:** `Ctrl+arrows` is intercepted at WM level globally — apps never receive it. `Alt+arrows` is the word-jump replacement everywhere including terminals.

---

## Phase 2: Easy-Win App Shortcuts ✅

These Super+key bindings were **unbound at the WM level** — pure `sendshortcut` additions with no conflicts.

### Implemented bindings

| Binding | Sends to app | macOS equivalent |
|---|---|---|
| `Super` + `Z` | `Ctrl+Z` | `Cmd+Z` undo |
| `Super+Shift` + `Z` | `Ctrl+Shift+Z` | `Cmd+Shift+Z` redo |
| `Super` + `A` | `Ctrl+A` | `Cmd+A` select all |
| `Super` + `N` | `Ctrl+N` | `Cmd+N` new window/file |
| `Super` + `R` | `Ctrl+R` | `Cmd+R` reload/refresh |
| `Super` + `B` | `Ctrl+B` | `Cmd+B` bold |
| `Super` + `I` | `Ctrl+I` | `Cmd+I` italic |
| `Super` + `U` | `Ctrl+U` | `Cmd+U` underline |
| `Super` + `G` | `Ctrl+G` | `Cmd+G` find next |
| `Super` + `D` | `Ctrl+D` | `Cmd+D` bookmark/select word |
| `Super` + `Q` | `Alt+F4` | `Cmd+Q` quit app |
| `Super` + `M` | move to scratchpad | `Cmd+M` minimise |

### Deferred to Phase 3 (conflict with WM bindings)

| Binding | Conflict | Needed action |
|---|---|---|
| `Super+Shift` + `G` | `Super+Shift+G` = Signal launcher | Relocate Signal, then bind to `Ctrl+Shift+G` (find prev) |
| `Super` + `P` | `Super+P` = pseudo tile | Relocate or drop pseudo tile, then bind to `Ctrl+P` (print) |
| `Super` + `O` | `Super+O` = pop window out (float & pin) | Relocate to `Super+Ctrl+O`, then bind to `Ctrl+O` (open file) |

> **Terminal note:** `Super+Z` → `Ctrl+Z` sends suspend in terminals — acceptable edge case. Per-app overrides can be added in Phase 3 if needed.

---

## Phase 3: Conflicting Shortcuts ✅

These Super+key bindings previously did WM actions. WM actions were relocated to free up the keys for in-app use.

### Implemented rebindings

| Key | Old WM action | WM action moved to | New in-app action | macOS equivalent |
|---|---|---|---|---|
| `Super` + `GRAVE` | *(unbound)* | — | Cycle app windows forward | `Cmd+\`` |
| `Super+Shift` + `GRAVE` | *(unbound)* | — | Cycle app windows backward | `Shift+Cmd+\`` |
| `Super` + `S` | Toggle scratchpad | `Ctrl+GRAVE` | `Ctrl+S` save | `Cmd+S` |
| `Super+Shift` + `S` | *(unbound)* | — | `Ctrl+Shift+S` save as | `Shift+Cmd+S` |
| `Super` + `T` | Toggle float/tile | `Ctrl+Shift+Space` | `Ctrl+T` new tab (per-app aware) | `Cmd+T` |
| `Super` + `F` | Full screen | `F11` | `Ctrl+F` find (per-app aware) | `Cmd+F` |
| `Super` + `K` | Show keybindings | `Super+Ctrl+K` | `Ctrl+K` add link | `Cmd+K` |
| `Super` + `,` | Dismiss notification | `Super+Ctrl+Alt+,` | `Ctrl+,` app preferences | `Cmd+,` |
| `Super` + `O` | Pop window out (float & pin) | `Super+Alt+O` | `Ctrl+O` open file | `Cmd+O` |
| `Super` + `P` | Pseudo tile | `Super+Ctrl+P` | `Ctrl+P` print/command palette | `Cmd+P` |
| `Super` + `G` | Toggle window grouping | *(removed — use `Super+Alt+G`)* | `Ctrl+G` find next | `Cmd+G` |
| `Super+Shift` + `G` | Signal launcher | Walker (`Super+Space` → signal) | `Ctrl+Shift+G` find prev | `Cmd+Shift+G` |

`Super+GRAVE` and `Super+Shift+GRAVE` use a small helper script to cycle only windows of the active app on the current workspace. Hyprland's built-in `cyclenext` does not support class filtering.

### Terminal-aware bindings

`Super+T` and `Super+F` use per-app `sendshortcut` to handle the terminal difference:

| Shortcut | In terminals | In GUI apps |
|---|---|---|
| `Super` + `T` | `Ctrl+Shift+T` (new tab) | `Ctrl+T` (new tab) |
| `Super` + `F` | `Ctrl+Shift+F` (find) | `Ctrl+F` (find) |

`Super+C`, `Super+V`, `Super+W`, `Super+N` are already terminal-aware (handled by clipboard.conf and per-class bindings from earlier phases).

> **`Super+W` note:** Omarchy's `killactive` already matches macOS `Cmd+W` — left unchanged.
> **`Super+L` note:** Toggle workspace layout left on `Super+L` for now — deferred to a later phase.

---

## Phase 4: App & Tab Switching 🔲

The goal is to mirror macOS's layered switching model.

| macOS | Meaning | Proposed Linux | Notes |
|---|---|---|---|
| `Cmd+Tab` | Switch between apps (app switcher) | `Super+Tab` → launcher/switcher | Currently: next workspace. Needs `hyprswitch` or Walker app-mode |
| `Cmd+`` ` `` | Cycle windows of same app | `Super+`` ` `` / `Super+Shift+`` ` `` → helper script | Implemented in Phase 3 |
| `Ctrl+←/→` | Switch spaces (desktops) | `Ctrl+Tab` / `Ctrl+Shift+Tab` | Currently: `Super+Tab` (next workspace). Frees up `Ctrl+Tab` which is unused at WM level |
| `Cmd+Shift+[` / `]` | Previous / next tab in app | `Super+Shift+[` / `]` → `Ctrl+Shift+Tab` / `Ctrl+Tab` | Currently partially via clipboard.conf approach |
| `Cmd+Opt+←/→` | Previous / next tab (browsers) | `Super+Alt+←/→` → `Ctrl+PgUp` / `Ctrl+PgDn` | Toshy's approach for browsers |

**Workspace → Ctrl mapping:**

| New binding | Action | Was |
|---|---|---|
| `Ctrl+Tab` | Next workspace | `Super+Tab` |
| `Ctrl+Shift+Tab` | Previous workspace | `Super+Shift+Tab` |
| `Ctrl+1–9` | Jump to workspace N | `Super+1–9` — **careful**: `Super+1–9` stays; add `Ctrl+1–9` as alias or replace |

> `Ctrl+1–9` is reserved for in-app use by many apps (browser tabs, editor tabs). Phase 4 workspace-switching via `Ctrl+Tab`/`Ctrl+Shift+Tab` is the safer choice without going to numbered shortcuts.

---

## Phase 5: System Shortcuts 🔲

| macOS | Proposed Linux | Notes |
|---|---|---|
| `Cmd+Q` (quit app) | `Super+Q` → `sendshortcut ALT F4` | Currently unbound; `Super+W` = close window is enough for most cases |
| `Cmd+H` (hide app) | `Super+H` → move to scratchpad | No true "hide to dock" in tiling WMs |
| `Cmd+M` (minimise) | `Super+M` → move to scratchpad | `Super+Alt+S` already moves to scratchpad |
| `Cmd+Shift+Q` (log out) | `Super+Shift+Q` → exec `omarchy-menu system` | Currently Escape opens system menu |
| `Ctrl+Cmd+Q` (lock screen) | `Super+Ctrl+Q` → lock | Currently `Super+Ctrl+L`; add alias |
| `Ctrl+Cmd+Space` (emoji picker) | Already: `Super+Ctrl+E` via Walker ✓ | — |
| `Cmd+Space` (Spotlight) | Already: `Super+Space` via Walker ✓ | — |

---

## Current Full Binding Reference

### Window management

| Keys | Action | macOS feel |
|---|---|---|
| `Super` + `W` | Close window | `Cmd+W` ✓ |
| `Ctrl+Alt` + `Del` | Close all windows | — |
| `Ctrl` + `` ` `` | Toggle scratchpad | *(was Super+S, moved in Phase 3)* |
| `Super` + `T` | New tab → app | `Cmd+T` ✓ |
| `Ctrl+Shift` + `Space` | Toggle float/tile | *(was Super+T)* |
| `Super` + `F` | Find → app | `Cmd+F` ✓ |
| `F11` | Full screen | *(was Super+F)* |
| `Super+Ctrl` + `F` | Tiled full screen | `Ctrl+Cmd+F` ✓ |
| `Super+Alt` + `F` | Full width | — |
| `Super+Alt` + `O` | Pop window out (float & pin) | *(was Super+O, moved in Phase 3)* |
| `Super` + `J` | Toggle split direction | — |
| `Super+Ctrl` + `P` | Pseudo tile | *(was Super+P, moved in Phase 3)* |
| `Super` + `L` | Toggle workspace layout | *(Phase 3: move to free Super+L)* |

### Window focus (Phase 1)

| Keys | Action | macOS feel |
|---|---|---|
| `Ctrl` + `←/→/↑/↓` | Focus adjacent window | `Ctrl+←/→` spaces ✓ |
| `Super` + `` ` `` | Cycle next window in current app on current workspace | `Cmd+`` ` `` ✓ |
| `Super+Shift` + `` ` `` | Cycle previous window in current app on current workspace | `Shift+Cmd+`` ` `` ✓ |
| `Alt` + `Tab` | Cycle next window | — |
| `Alt+Shift` + `Tab` | Cycle previous window | — |

### Window move / resize

| Keys | Action |
|---|---|
| `Ctrl+Shift` + `←/→/↑/↓` | Swap window with neighbour |
| `Super` + `-` / `=` | Expand/shrink window horizontally |
| `Super+Shift` + `-` / `=` | Shrink/expand window vertically |
| `Super+Shift+Alt` + `←/→/↑/↓` | Move workspace to monitor |
| `Super` + drag LMB | Move floating window |
| `Super` + drag RMB | Resize window |

### Workspaces

| Keys | Action | macOS feel |
|---|---|---|
| `Super` + `1–0` | Switch to workspace 1–10 | `Ctrl+1–9` spaces |
| `Super+Shift` + `1–0` | Move window to workspace | — |
| `Super+Shift+Alt` + `1–0` | Move window silently | — |
| `Super` + `Tab` | Next workspace | *(Phase 4: add Ctrl+Tab alias)* |
| `Super+Shift` + `Tab` | Previous workspace | *(Phase 4: add Ctrl+Shift+Tab alias)* |
| `Super+Ctrl` + `Tab` | Former workspace | — |
| `Ctrl` + `` ` `` | Toggle scratchpad | *(was Super+S, moved in Phase 3)* |
| `Super+Alt` + `S` | Move window to scratchpad | `Cmd+H` hide ≈ |
| `Super` + scroll | Scroll workspaces | — |

### Monitors

| Keys | Action |
|---|---|
| `Ctrl+Alt` + `Tab` | Focus next monitor |
| `Ctrl+Alt+Shift` + `Tab` | Focus previous monitor |

### Text navigation in apps (Phase 1)

| Keys | Sends to app | macOS equivalent |
|---|---|---|
| `Super` + `←` | `Home` | `Cmd+←` ✓ |
| `Super` + `→` | `End` | `Cmd+→` ✓ |
| `Super` + `↑` | `Ctrl+Home` | `Cmd+↑` ✓ |
| `Super` + `↓` | `Ctrl+End` | `Cmd+↓` ✓ |
| `Super+Shift` + `←` | `Shift+Home` | `Cmd+Shift+←` ✓ |
| `Super+Shift` + `→` | `Shift+End` | `Cmd+Shift+→` ✓ |
| `Super+Shift` + `↑` | `Ctrl+Shift+Home` | `Cmd+Shift+↑` ✓ |
| `Super+Shift` + `↓` | `Ctrl+Shift+End` | `Cmd+Shift+↓` ✓ |
| `Alt` + `←` | `Ctrl+Left` | `Option+←` ✓ |
| `Alt` + `→` | `Ctrl+Right` | `Option+→` ✓ |
| `Alt+Shift` + `←` | `Ctrl+Shift+Left` | `Option+Shift+←` ✓ |
| `Alt+Shift` + `→` | `Ctrl+Shift+Right` | `Option+Shift+→` ✓ |

### Copy / paste (clipboard.conf — already macOS-like)

| Keys | Sends to app | macOS equivalent |
|---|---|---|
| `Super` + `C` | `Ctrl+Insert` (copy) | `Cmd+C` ✓ |
| `Super` + `V` | `Shift+Insert` (paste) | `Cmd+V` ✓ |
| `Super` + `X` | `Ctrl+X` (cut) | `Cmd+X` ✓ |
| `Super+Ctrl` + `V` | Clipboard manager | — |

### Apps & launchers (bindings.conf)

| Keys | Action | macOS feel |
|---|---|---|
| `Super` + `Space` | App launcher (Walker) | `Cmd+Space` Spotlight ✓ |
| `Super` + `Return` | Terminal | — |
| `Super+Shift` + `Return` | Browser | — |
| `Super+Shift` + `N` | Editor (VS Code) | — |
| `Super+Shift` + `F` | File manager (Nautilus) | — |
| `Super+Shift` + `D` | Docker (lazydocker) | — |
| `Super+Shift` + `M` | Spotify | — |
| `Super+Shift` + `O` | Obsidian | — |
| `Super+Shift` + `A` | ChatGPT | — |
| `Super+Shift` + `E` | Email (Hey) | — |
| `Super+Shift` + `C` | Calendar | — |
| `Super+Shift` + `SLASH` | 1Password | — |

### System & utilities (utilities.conf)

| Keys | Action | macOS feel |
|---|---|---|
| `Super` + `Esc` | System menu | — |
| `Super+Ctrl` + `L` | Lock screen | `Ctrl+Cmd+Q` ✓ |
| `Super+Ctrl` + `K` | Show keybindings | *(was Super+K, moved in Phase 3)* |
| `Super+Ctrl` + `E` | Emoji picker | `Ctrl+Cmd+Space` ✓ |
| `Super+Ctrl` + `I` | Toggle idle lock | — |
| `Super+Ctrl` + `N` | Toggle night light | — |
| `Super+Ctrl` + `A/B/W` | Audio / Bluetooth / Wifi | — |
| `Super+Ctrl` + `T` | Activity monitor (btop) | — |
| `Print` | Screenshot | `Cmd+Shift+3/4/5` ✓ |
| `Super+Ctrl` + `X` | Toggle dictation | `Fn+D` ✓ |
| `Super+Ctrl+Alt` + `,` | Dismiss notification | *(was Super+, moved in Phase 3)* |
