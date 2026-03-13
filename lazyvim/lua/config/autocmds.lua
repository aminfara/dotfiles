-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here

-- Trim trailing whitespace on save, except for specified filetypes
local skip_ft = {
  markdown = true,
  -- add more filetypes to skip here
}

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local ft = vim.bo.filetype
    if not skip_ft[ft] then
      vim.cmd([[%s/\s\+$//e]])
    end
  end,
})
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
