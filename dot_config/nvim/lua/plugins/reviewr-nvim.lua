return {
  {
    "paul-enz/reviewr.nvim",
    cond = function() return require("config.rex").in_rex() end,
    cmd = { "ReviewrOpen", "ReviewrScope", "ReviewrComment", "ReviewrTurn", "ReviewrExport", "ReviewrClear" },
    opts = {},
  },
}
