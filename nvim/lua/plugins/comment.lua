return {
  -- コメントイン/アウトの切り替え
  {
    'numToStr/Comment.nvim',
    event = "VeryLazy",
    opts = {},
    keys = {
      { '""', "<Plug>(comment_toggle_linewise_current)", mode = "n", desc = "Toggle comment (Normal)" },
      { '""', "<Plug>(comment_toggle_linewise_visual)", mode = "x", desc = "Toggle comment (Visual)" },
    },
  },
}
