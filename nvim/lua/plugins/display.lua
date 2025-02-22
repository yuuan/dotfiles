return {
  -- スペースによるインデントを見やすく表示する
  {
    'Yggdroot/indentLine',
    init = function()
      -- 区切り文字の色
      vim.g.indentLine_color_term = 237

      -- 区切り文字
      vim.g.indentLine_char = '|' -- default '¦'

      -- ガイドを表示するインデントの深さ
      vim.g.indentLine_indentLevel = 20 -- default 10
    end,
  },

  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true
        },
      })
    end
  },

  -- カーソル下の単語に下線を引く
  { 'itchyny/vim-cursorword' },

  -- カラーコードをその色で表示
  {
    'norcalli/nvim-colorizer.lua',
    opts = {
      -- Enable CSS functions: rgb(), rgba(), hsl(), hsla()
      css = { css_fn = true; };
    },
  },
}
