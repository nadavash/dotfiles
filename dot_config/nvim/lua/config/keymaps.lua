-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local BASIC_MODES = { "n", "i", "v" }

-- Ghostty passes Cmd+Left as Ctrl+A (\x01)
vim.keymap.set(BASIC_MODES, "<C-a>", "<Home>", { desc = "Go to beginning of line" })

-- Ghostty passes Cmd+Right as Ctrl+E (\x05)
vim.keymap.set(BASIC_MODES, "<C-e>", "<End>", { desc = "Go to end of line" })
