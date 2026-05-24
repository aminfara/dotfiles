# Keybindings: macOS Migration Guide

A living reference for the Omarchy/Hyprland keybinding setup, optimised for macOS muscle memory.
Config lives in `~/.config/hypr/bindings.conf`.

---

## Phase 1: Text Navigation (DONE)

### What changed

| Keys | New behaviour | Was (Omarchy default) |
|---|---|---|
| `Ctrl` + `←/→/↑/↓` | Focus window | `Super` + `←/→/↑/↓` |
| `Ctrl+Shift` + `←/→/↑/↓` | Swap/move window | `Super+Shift` + `←/→/↑/↓` |
| `Super` + `←` | Home (line start) | Move focus left |
| `Super` + `→` | End (line end) | Move focus right |
| `Super` + `↑` | Ctrl+Home (doc start) | Move focus up |
| `Super` + `↓` | Ctrl+End (doc end) | Move focus down |
| `Super+Shift` + `←` | Select to line start | Swap window left |
| `Super+Shift` + `→` | Select to line end | Swap window right |
| `Super+Shift` + `↑` | Select to doc start | Swap window up |
| `Super+Shift` + `↓` | Select to doc end | Swap window down |
| `Alt` + `←/→` | Jump word left/right | *(unbound)* |
| `Alt+Shift` + `←/→` | Select word left/right | *(unbound)* |

### Notes
- `Ctrl+arrows` is intercepted at the WM level — apps no longer receive it for word-jumping. `Alt+arrows` takes over that role everywhere.
- All bindings use `sendshortcut` which sends the key event to the focused window, so they work in browsers, terminals, editors, etc.

---

## Current Full Binding Reference

### Window Management

| Keys | Action |
|---|---|
| `Super` + `W` | Close window |
| `Ctrl+Alt` + `Del` | Close all windows |
| `Super` + `T` | Toggle float/tile |
| `Super` + `F` | Full screen |
| `Super+Ctrl` + `F` | Tiled full screen |
| `Super+Alt` + `F` | Full width |
| `Super` + `O` | Pop window out (float & pin) |
| `Super` + `J` | Toggle split direction |
| `Super` + `P` | Pseudo tile |
| `Super` + `L` | Toggle workspace layout |

### Window Focus (Phase 1 — new)

| Keys | Action |
|---|---|
| `Ctrl` + `←/→/↑/↓` | Move focus to adjacent window |
| `Alt` + `Tab` | Cycle to next window |
| `Alt+Shift` + `Tab` | Cycle to previous window |

### Window Move / Resize

| Keys | Action |
|---|---|
| `Ctrl+Shift` + `←/→/↑/↓` | Swap window with neighbour |
| `Super` + `-` | Expand window left |
| `Super` + `=` | Shrink window left |
| `Super+Shift` + `-/=` | Shrink/expand window vertically |
| `Super+Shift+Alt` + `←/→/↑/↓` | Move workspace to monitor |
| `Super` + drag LMB | Move floating window |
| `Super` + drag RMB | Resize window |

### Workspaces

| Keys | Action |
|---|---|
| `Super` + `1–0` | Switch to workspace 1–10 |
| `Super+Shift` + `1–0` | Move window to workspace 1–10 |
| `Super+Shift+Alt` + `1–0` | Move window silently to workspace |
| `Super` + `Tab` | Next workspace |
| `Super+Shift` + `Tab` | Previous workspace |
| `Super+Ctrl` + `Tab` | Former workspace |
| `Super` + `S` | Toggle scratchpad |
| `Super+Alt` + `S` | Move window to scratchpad |
| `Super` + scroll | Scroll workspaces |

### Monitors

| Keys | Action |
|---|---|
| `Ctrl+Alt` + `Tab` | Focus next monitor |
| `Ctrl+Alt+Shift` + `Tab` | Focus previous monitor |

### Text Navigation in Apps (Phase 1 — new)

| Keys | Action | macOS equivalent |
|---|---|---|
| `Super` + `←` | Home (line start) | `Cmd` + `←` |
| `Super` + `→` | End (line end) | `Cmd` + `→` |
| `Super` + `↑` | Document start | `Cmd` + `↑` |
| `Super` + `↓` | Document end | `Cmd` + `↓` |
| `Super+Shift` + `←` | Select to line start | `Cmd+Shift` + `←` |
| `Super+Shift` + `→` | Select to line end | `Cmd+Shift` + `→` |
| `Super+Shift` + `↑` | Select to doc start | `Cmd+Shift` + `↑` |
| `Super+Shift` + `↓` | Select to doc end | `Cmd+Shift` + `↓` |
| `Alt` + `←` | Jump word left | `Option` + `←` |
| `Alt` + `→` | Jump word right | `Option` + `→` |
| `Alt+Shift` + `←` | Select word left | `Option+Shift` + `←` |
| `Alt+Shift` + `→` | Select word right | `Option+Shift` + `→` |

### Copy / Paste (clipboard.conf)

| Keys | Action | macOS equivalent |
|---|---|---|
| `Super` + `C` | Copy | `Cmd` + `C` |
| `Super` + `V` | Paste | `Cmd` + `V` |
| `Super` + `X` | Cut | `Cmd` + `X` |
| `Super+Ctrl` + `V` | Clipboard manager | — |

### Apps & Launchers

| Keys | Action |
|---|---|
| `Super` + `Space` | App launcher (Walker) |
| `Super` + `Return` | Terminal |
| `Super+Alt` + `Return` | Tmux terminal |
| `Super+Shift` + `Return` | Browser |
| `Super+Shift` + `N` | Editor |
| `Super+Shift` + `F` | File manager |
| `Super+Shift` + `D` | Docker (lazydocker) |
| `Super+Shift` + `M` | Spotify |
| `Super+Shift` + `G` | Signal |
| `Super+Shift` + `O` | Obsidian |
| `Super+Shift` + `A` | ChatGPT |
| `Super+Shift` + `E` | Email (Hey) |
| `Super+Shift` + `C` | Calendar |

### System & Utilities

| Keys | Action |
|---|---|
| `Super` + `Esc` | System menu |
| `Super+Ctrl` + `L` | Lock screen |
| `Super` + `K` | Show all keybindings |
| `Super+Ctrl` + `I` | Toggle idle lock |
| `Super+Ctrl` + `N` | Toggle night light |
| `Super+Ctrl` + `A/B/W` | Audio / Bluetooth / Wifi |
| `Super+Ctrl` + `T` | Activity monitor (btop) |
| `Super` + `Print` | Screenshot |
| `Super+Ctrl` + `X` | Toggle dictation |

---

## Recommended Next Migrations

These are macOS habits that don't have a matching Linux equivalent yet, roughly ordered by impact.

### High impact

| macOS | Suggested Linux binding | Notes |
|---|---|---|
| `Cmd+Z` / `Cmd+Shift+Z` | Already works via `Super+Z/Y` ... but apps vary | Consider binding `Super+Z` → `sendshortcut CTRL Z` globally |
| `Cmd+A` (select all) | `Super+A` → `sendshortcut CTRL A` | Currently `Super+A` opens ChatGPT webapp |
| `Cmd+S` (save) | `Super+S` → `sendshortcut CTRL S` | Currently `Super+S` = scratchpad toggle |
| `Cmd+F` (find) | `Super+F` → `sendshortcut CTRL F` | Currently `Super+F` = fullscreen |
| `Cmd+T` (new tab) | `Super+T` → `sendshortcut CTRL T` | Currently `Super+T` = float/tile toggle |
| `Cmd+N` (new window) | `Super+N` → `sendshortcut CTRL N` | Currently unbound at WM level |

### Medium impact

| macOS | Suggested Linux binding | Notes |
|---|---|---|
| `Cmd+Tab` (app switcher) | Replace `Alt+Tab` cycle with a macOS-style switcher | Walker or rofi can do this |
| `Cmd+`` ` (cycle windows of same app) | `Super+`` ` → cycle same-class windows | Hyprland: `cyclenext, same_class` |
| `Cmd+H` (hide window) | `Super+H` → minimize or move to scratchpad | No true hide in tiling WMs |
| `Cmd+M` (minimise) | `Super+M` → scratchpad or special workspace | |
| `Cmd+Q` (quit) | Already `Super+W` = close — just a habit rename | |
| `Cmd+,` (preferences) | App-specific, hard to globalise | |

### Low impact / consider carefully

| macOS | Notes |
|---|---|
| `Cmd+C/V/X` remapping | Already done via `sendshortcut` in clipboard.conf — works well |
| `Ctrl+Space` (Spotlight) | `Super+Space` already covers this via Walker |
| Mission Control gestures | Handled by workspace switching — `Super+Tab` / `Super+[1-9]` |
| Three-finger swipe | Configure touchpad gestures via `libinput-gestures` or `hyprgrass` |
