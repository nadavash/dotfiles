return {
  {
    "le-michael/flatbuffer.vim",
    ft = { "flatbuffers", "fbs" },
  },
  {
    "jamespeilunli/nvim-flatbuffers",
    event = "LspAttach",
    config = function()
      require("flatbuffers").setup()
    end,
  },
}
