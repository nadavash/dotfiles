-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.lazyvim_rust_diagnostics = "rust-analyzer"

if vim.env.SSH_TTY or vim.env.SSH_CONNECTION or vim.env.TERM:match("screen") or vim.env.TERM:match("tmux") then
  vim.opt.clipboard = "unnamedplus"
end
