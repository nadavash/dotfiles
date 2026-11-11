return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
    opts = {},
    keys = {
      { "<leader>ad", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
      { "<leader>ah", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview File History" },
    },
  },
}
