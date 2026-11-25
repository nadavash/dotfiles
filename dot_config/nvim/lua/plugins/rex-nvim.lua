return {
  {
    "rawnly/rex.nvim",
    main = "rex-nvim",
    cond = function() return require("config.rex").in_rex() end,
    opts = {},
  },
}
