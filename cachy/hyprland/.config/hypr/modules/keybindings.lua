---------------------
---- KEYBINDINGS ----
---------------------

-- Set programs that you use
local terminal = "ghostty"
local fileManager = "thunar"
local menu = "rofi -show run"

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
-- local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(
	mainMod .. " + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
-- hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
-- hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only

-- Move focus with mainMod + arrow keys
-- hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }), { transparent = true })
-- hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }), { transparent = true })
-- hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }), { transparent = true })
-- hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }), { transparent = true })

-- for i = 1, 10 do
-- 	local key = i % 10 -- 10 maps to key 0
-- 	hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
-- 	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
-- 	-- hl.bind(mainMod .. " + " .. key, hl.dsp.send_shortcut({ mods = "CTRL", key = key }))
-- end

-- Example special workspace (scratchpad)
-- hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Added from the wiki

-- for screenshot
hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'))
hl.bind("SUPER + Print", hl.dsp.exec_cmd('grim -g "$(slurp -d)" - | wl-copy'))

-- TODO: keybind for colorpicker
--

-- Movements
-------------------------------------------------------------------------------

-- Switch workspaces with Ctrl + [0-9]
-- Move active window to a workspace with Ctrl + Shift + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind("CTRL + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind("CTRL + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
	hl.bind("SUPER + " .. key, hl.dsp.send_shortcut({ mods = "CTRL", key = key }))
end

-- Home/End moves (Cmd l/r)
hl.bind("SUPER + LEFT", hl.dsp.send_shortcut({ mods = "", key = "HOME" }))
hl.bind("SUPER + RIGHT", hl.dsp.send_shortcut({ mods = "", key = "END" }))
hl.bind("SUPER + SHIFT + LEFT", hl.dsp.send_shortcut({ mods = "SHIFT", key = "HOME" }))
hl.bind("SUPER + SHIFT + RIGHT", hl.dsp.send_shortcut({ mods = "SHIFT", key = "END" }))

-- Beginning/End doc moves (Cmd u/d)
hl.bind("SUPER + UP", hl.dsp.send_shortcut({ mods = "CTRL", key = "HOME" }))
hl.bind("SUPER + DOWN", hl.dsp.send_shortcut({ mods = "CTRL", key = "END" }))
hl.bind("SUPER + SHIFT + UP", hl.dsp.send_shortcut({ mods = "CTRL + SHIFT", key = "HOME" }))
hl.bind("SUPER + SHIFT + DOWN", hl.dsp.send_shortcut({ mods = "CTRL + SHIFT", key = "END" }))

-- Word moves (Opt l/r)
hl.bind("ALT + LEFT", hl.dsp.send_shortcut({ mods = "CTRL", key = "LEFT" }), { repeating = true })
hl.bind("ALT + RIGHT", hl.dsp.send_shortcut({ mods = "CTRL", key = "RIGHT" }), { repeating = true })
hl.bind("ALT + SHIFT + LEFT", hl.dsp.send_shortcut({ mods = "CTRL + SHIFT", key = "LEFT" }), { repeating = true })
hl.bind("ALT + SHIFT + RIGHT", hl.dsp.send_shortcut({ mods = "CTRL + SHIFT", key = "RIGHT" }), { repeating = true })

-- Focus moves (Ctrl l/r/u/d)
hl.bind("CTRL + LEFT", hl.dsp.focus({ direction = "left" }))
hl.bind("CTRL + RIGHT", hl.dsp.focus({ direction = "right" }))
hl.bind("CTRL + UP", hl.dsp.focus({ direction = "up" }))
hl.bind("CTRL + DOWN", hl.dsp.focus({ direction = "down" }))

-- Swap (Ctrl + Shift l/r/u/d)
hl.bind("CTRL + SHIFT + LEFT", hl.dsp.window.swap({ direction = "left" }))
hl.bind("CTRL + SHIFT + RIGHT", hl.dsp.window.swap({ direction = "right" }))
hl.bind("CTRL + SHIFT + UP", hl.dsp.window.swap({ direction = "up" }))
hl.bind("CTRL + SHIFT + DOWN", hl.dsp.window.swap({ direction = "down" }))

-- Editing
-------------------------------------------------------------------------------

---Creates correct bind
--- https://github.com/hyprwm/Hyprland/discussions/14099#discussioncomment-16994570
---@param params any
---@return function
function SendShortcut(params)
	local timer = function()
		local args = params
		args.state = "up"
		hl.dispatch(hl.dsp.send_key_state(args))
	end
	return function()
		local args = params
		args.state = "down"
		hl.dispatch(hl.dsp.send_key_state(args))
		hl.timer(timer, { timeout = 20, type = "oneshot" })
	end
end

-- Cut
hl.bind("SUPER + x", SendShortcut({ mods = "CTRL", key = "x" }))

-- -- Copy
hl.bind("SUPER + c", function()
	local w = hl.get_active_window()

	-- TODO define is_terminal
	if w ~= nil and w.class == "com.mitchellh.ghostty" then
		SendShortcut({ mods = "CTRL + SHIFT", key = "c" })()
		return
	end

	SendShortcut({ mods = "CTRL", key = "c" })()
end)

-- Paste
hl.bind("SUPER + v", function()
	local w = hl.get_active_window()

	-- TODO define is_terminal
	if w ~= nil and w.class == "com.mitchellh.ghostty" then
		SendShortcut({ mods = "CTRL + SHIFT", key = "v" })()
		return
	end

	SendShortcut({ mods = "CTRL", key = "v" })()
end)

-- Actions
-------------------------------------------------------------------------------

-- Save
hl.bind("SUPER + s", SendShortcut({ mods = "CTRL", key = "s" }))
hl.bind("SUPER + SHIFT + S", SendShortcut({ mods = "CTRL + SHIFT", key = "s" }))

-- Print / Command palette
hl.bind("SUPER + p", SendShortcut({ mods = "CTRL", key = "p" }))
hl.bind("SUPER + SHIFT + P", SendShortcut({ mods = "CTRL + SHIFT", key = "p" }))

-- Find
hl.bind("SUPER + f", SendShortcut({ mods = "CTRL", key = "f" }))

-- Undo / Redo
hl.bind("SHIFT + SUPER + z", SendShortcut({ mods = "CTRL", key = "Y" }))

hl.bind("SUPER + z", function()
	local w = hl.get_active_window()

	-- TODO define is_terminal
	if w ~= nil and w.class == "com.mitchellh.ghostty" then
		hl.dispatch(hl.dsp.pass())
		return
	end

	SendShortcut({ mods = "CTRL", key = "z" })()
end)
