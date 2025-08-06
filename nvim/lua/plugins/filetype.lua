return {
  -- いろんな言語の Syntax 詰め合わせ
  {
    "sheerun/vim-polyglot",
    init = function()
      vim.g.polyglot_disabled = { 'ftdetect' }
    end,
  }
}
