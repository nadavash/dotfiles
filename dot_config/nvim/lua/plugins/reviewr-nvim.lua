return {
  {
    "paul-enz/reviewr.nvim",
    cond = vim.env.REX_SESSION ~= nil and vim.env.REX_SESSION ~= "",
    cmd = { "ReviewrOpen", "ReviewrScope", "ReviewrComment", "ReviewrTurn", "ReviewrExport", "ReviewrClear" },
    opts = {},
  },
}
