return {
  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    dependencies = { "kevinhwang91/nvim-hlslens" },
    opts = {
      handle = {
        text = " ",
        color = "FFFFFF",
      },
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
