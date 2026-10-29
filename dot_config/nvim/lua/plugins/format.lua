-- Add this right at the top of your format.lua or inside config/autocmds.lua
vim.filetype.add({
  extension = {
    fbs = "fbs",
  },
})

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
      -- Forces LazyVim to fall back to conform when no LSP is running on the file
      format_on_save = function()
        return { timeout_ms = 500, lsp_fallback = true }
      end,
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
