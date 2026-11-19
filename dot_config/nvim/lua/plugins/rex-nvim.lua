return {
  {
    "rawnly/rex.nvim",
    main = "rex-nvim",
    cond = vim.env.REX_SESSION ~= nil and vim.env.REX_SESSION ~= "",
    opts = {},
  },
}
