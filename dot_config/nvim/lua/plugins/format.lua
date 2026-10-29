return {
  -- Configure conform.nvim within LazyVim
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        fbs = { "flatbuffers_format" },
      },
      formatters = {
        flatbuffers_format = {
          command = "flatbuffers-format",
          args = { "-" },
          stdin = true,
        },
      },
    },
  },

  -- Ensure Neovim detects .fbs files so conform knows to run
  {
    "neovim/nvim-lspconfig",
    init = function()
      vim.filetype.add({
        extension = {
          fbs = "fbs",
        },
      })
    end,
  },
}
