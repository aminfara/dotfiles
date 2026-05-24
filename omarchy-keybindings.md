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
| 2 | Easy-win app shortcuts (no conflicts) | 🔲 Next |
| 3 | Conflicting shortcuts (need WM rebinding first) | 🔲 Planned |
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

## Phase 2: Easy-Win App Shortcuts 🔲

These Super+key bindings are **currently unbound at the WM level** — pure `sendshortcut` additions with no conflicts.

### Proposed bindings

| New binding | Sends to app | macOS equivalent | Notes |
|---|---|---|---|
| `Super` + `Z` | `Ctrl+Z` | `Cmd+Z` undo | Unbound in Omarchy |
| `Super+Shift` + `Z` | `Ctrl+Shift+Z` | `Cmd+Shift+Z` redo | Unbound |
| `Super` + `A` | `Ctrl+A` | `Cmd+A` select all | Unbound (`Super+Shift+A` = ChatGPT — unaffected) |
| `Super` + `N` | `Ctrl+N` | `Cmd+N` new window/file | Unbound (`Super+Shift+N` = Editor — unaffected) |
| `Super` + `R` | `Ctrl+R` | `Cmd+R` reload/refresh | Unbound |
| `Super` + `B` | `Ctrl+B` | `Cmd+B` bold | Unbound (`Super+Shift+B` = Browser — unaffected) |
| `Super` + `I` | `Ctrl+I` | `Cmd+I` italic | Unbound |
| `Super` + `U` | `Ctrl+U` | `Cmd+U` underline | Unbound |
| `Super` + `G` | `Ctrl+G` / `F3` | `Cmd+G` find next | Unbound (`Super+Shift+G` = Signal — unaffected) |
| `Super+Shift` + `G` | `Ctrl+Shift+G` | `Cmd+Shift+G` find prev | Conflict: was Signal launcher → **move Signal** to `Super+Shift+Alt+G` or keep via walker |
| `Super` + `D` | `Ctrl+D` | `Cmd+D` bookmark/select word | Unbound (`Super+Shift+D` = Docker — unaffected) |
| `Super` + `P` | `Ctrl+P` | `Cmd+P` print | Currently: `pseudo` (rarely used tiling command) → move or drop |
| `Super` + `O` | `Ctrl+O` | `Cmd+O` open file | Conflict: was "pop window out (float & pin)" → move to `Ctrl+O` or `Super+Ctrl+O` |

> **Terminal note:** `sendshortcut` with no window-class filter sends to all windows. `Super+Z` → `Ctrl+Z` is safe in terminals because `Ctrl+Z` in a terminal suspends the foreground process — which is rarely desired and probably fine to leave as-is. If needed, per-app overrides can be added in a later phase.

---

## Phase 3: Conflicting Shortcuts (Need WM Rebinding) 🔲

These Super+key bindings currently do WM actions in Omarchy. We free them up for in-app use by relocating the WM action to a `Ctrl+key` equivalent (consistent with the Ctrl=WM philosophy).

### Proposed rebindings

| Key | Current WM action | Move WM action to | New in-app action | macOS equivalent |
|---|---|---|---|---|
| `Super` + `S` | Toggle scratchpad | `Ctrl` + `` ` `` (backtick) | `Ctrl+S` save | `Cmd+S` |
| `Super` + `T` | Toggle float/tile | `Ctrl+Shift` + `Space` | `Ctrl+T` new tab | `Cmd+T` |
| `Super` + `F` | Full screen | `F11` (universal) or `Ctrl+Enter` | `Ctrl+F` find | `Cmd+F` |
| `Super` + `W` | `killactive` (close window) | *(keep — matches macOS Cmd+W)* | Keep as close window/tab | `Cmd+W` ✓ |
| `Super` + `,` | Dismiss notification | `Super+Ctrl` + `,` | `Ctrl+,` app preferences | `Cmd+,` |
| `Super` + `K` | Show keybindings | `Super+Ctrl` + `K` | `Ctrl+K` add link | `Cmd+K` |
| `Super` + `L` | Toggle workspace layout | `Ctrl+Shift` + `L` | *(leave for later)* | — |

> **`Super+F` fullscreen note:** macOS uses `Ctrl+Cmd+F` to toggle full screen in apps. In Linux/Hyprland the closest universal key is `F11`. The existing `Super+Ctrl+F` (tiled full screen) remains unchanged.

> **`Super+W` keep note:** macOS Cmd+W closes the front window (or tab in apps like browsers). Omarchy's `killactive` does exactly that. This is one of the cleanest cross-platform overlaps — **do not change**.

### Terminal-specific variants needed in this phase

For apps where the Linux shortcut differs from the general case, add window-class-specific `sendshortcut` bindings **before** the global fallback:

| Shortcut | In terminals | In GUI apps |
|---|---|---|
| `Super` + `C` | `Ctrl+Shift+C` (already handled by clipboard.conf) | `Ctrl+Insert` (clipboard.conf) |
| `Super` + `V` | `Ctrl+Shift+V` (already handled) | `Shift+Insert` (clipboard.conf) |
| `Super` + `T` | `Ctrl+Shift+T` (new tab in terminal) | `Ctrl+T` (new tab in browser/editor) |
| `Super` + `N` | `Ctrl+Shift+N` (new window in terminal) | `Ctrl+N` |
| `Super` + `F` | `Ctrl+Shift+F` (find in some terminals) | `Ctrl+F` |
| `Super` + `W` | `Ctrl+Shift+W` (close tab in terminal) | `killactive` (close window) |

Use Hyprland's window-class filter in `sendshortcut`:
```
# Terminal class regex covers ghostty, alacritty, foot, kitty, etc.
bindd = SUPER, T, New tab (terminal), sendshortcut, CTRL SHIFT, T, ^(ghostty|alacritty|foot|kitty|.*[Tt]erminal.*)$
bindd = SUPER, T, New tab (apps),     sendshortcut, CTRL,       T,
```

---

## Phase 4: App & Tab Switching 🔲

The goal is to mirror macOS's layered switching model.

| macOS | Meaning | Proposed Linux | Notes |
|---|---|---|---|
| `Cmd+Tab` | Switch between apps (app switcher) | `Super+Tab` → launcher/switcher | Currently: next workspace. Needs `hyprswitch` or Walker app-mode |
| `Cmd+`` ` `` | Cycle windows of same app | `Super+`` ` `` → `cyclenext, same_class` | Currently unbound |
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
| `Super` + `T` | Toggle float/tile | *(Phase 3: move to free Super+T)* |
| `Super` + `F` | Full screen | *(Phase 3: move to free Super+F)* |
| `Super+Ctrl` + `F` | Tiled full screen | `Ctrl+Cmd+F` ✓ |
| `Super+Alt` + `F` | Full width | — |
| `Super` + `O` | Pop window out (float & pin) | *(Phase 2: move to free Super+O)* |
| `Super` + `J` | Toggle split direction | — |
| `Super` + `P` | Pseudo tile | *(Phase 2: move to free Super+P)* |
| `Super` + `L` | Toggle workspace layout | *(Phase 3: move to free Super+L)* |

### Window focus (Phase 1)

| Keys | Action | macOS feel |
|---|---|---|
| `Ctrl` + `←/→/↑/↓` | Focus adjacent window | `Ctrl+←/→` spaces ✓ |
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
| `Super` + `S` | Toggle scratchpad | *(Phase 3: move to Ctrl+`` ` ``)* |
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
| `Super` + `K` | Show keybindings | *(Phase 3: move to free Super+K)* |
| `Super+Ctrl` + `E` | Emoji picker | `Ctrl+Cmd+Space` ✓ |
| `Super+Ctrl` + `I` | Toggle idle lock | — |
| `Super+Ctrl` + `N` | Toggle night light | — |
| `Super+Ctrl` + `A/B/W` | Audio / Bluetooth / Wifi | — |
| `Super+Ctrl` + `T` | Activity monitor (btop) | — |
| `Print` | Screenshot | `Cmd+Shift+3/4/5` ✓ |
| `Super+Ctrl` + `X` | Toggle dictation | `Fn+D` ✓ |
| `Super` + `,` | Dismiss notification | *(Phase 3: move to free Super+,)* |
