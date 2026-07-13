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
