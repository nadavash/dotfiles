local LIGHT_THEME = "catppuccin-latte"
local DARK_THEME = "tokyonight-storm"

return {
  -- 1. Install your preferred dark and light colorschemes
  { "catppuccin/nvim", name = "catppuccin" },
  { "folke/tokyonight.nvim" },

  -- 2. Configure LazyVim to dynamically change its fallback depending on the system's choice
  {
    "LazyVim/LazyVim",
    opts = function()
      -- Checks if the system background is currently reporting light or dark
      local theme = vim.o.background == "light" and LIGHT_THEME or DARK_THEME
      return {
        colorscheme = theme,
      }
    end,
  },
}
