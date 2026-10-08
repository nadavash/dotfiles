return {
  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    opts = {
      -- Customize your scrollbar options here
      handlers = {
        cursor = true,
        diagnostic = true,
        gitsigns = true, -- Requires gitsigns.nvim
        search = true,
      },
    },
  },
}
