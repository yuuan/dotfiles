return {
  -- 単語を囲む要素を扱いやすくする
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = {},
  },

  -- :%S でスマートな置換
  {
    'tpope/vim-abolish',
    event = "VeryLazy",
  },
}
