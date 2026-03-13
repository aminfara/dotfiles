return {
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup({
        enabled = true,
        debounce_delay = 5000, -- autosave every 5 seconds
        -- you could further adjust triggers/conditions if needed
      })
    end,
    event = "VeryLazy",
  },
}
