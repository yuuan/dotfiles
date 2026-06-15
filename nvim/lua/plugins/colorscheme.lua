-- タブ文字の色
--vim.api.nvim_set_hl(0, "SpecialKey", { ctermfg = 236,  ctermbg = 16 })
vim.api.nvim_set_hl(0, "SpecialKey", { ctermfg = 196,  ctermbg = 16 })

-- 検索結果の色
--vim.api.nvim_set_hl(0, "Search", { ctermfg = 16,  ctermbg = 214 })

-- 対応する括弧の色 (濃い赤:124, 黄緑:154, オレンジ:208)
--vim.api.nvim_set_hl(0, "MatchParen", { ctermfg = 15,  ctermbg = 124 })
--vim.api.nvim_set_hl(0, "MatchParen", { ctermfg = 8,  ctermbg = 154 })
vim.api.nvim_set_hl(0, "MatchParen", { ctermfg = 8,  ctermbg = 208 })

return {
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 999,
    config = function()
      vim.g.gruvbox_material_foreground = 'material' -- material, mix, original
      vim.cmd.colorscheme('gruvbox-material')
    end
  },
  {
    'ayu-theme/ayu-vim',
    lazy = false,
    priority = 999,
    init = function()
      vim.g.ayucolor = 'mirage' -- dark, mirage, light
      --vim.cmd.colorscheme('ayu')
    end,
  },
  {
    'ribru17/bamboo.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('bamboo').setup {
        transparent = false, -- Show/hide background (default: false)
        term_colors = true, -- Change terminal color as per the selected theme style (default: true)
      }
      --require('bamboo').load()
    end,
  },
  {
    'aereal/vim-colors-japanesque',
    lazy = false,
    priority = 999,
  },
  {
    'sjl/badwolf',
    lazy = false,
    priority = 999,
    init = function()
      vim.g.badwolf_html_link_underline = 0
      vim.g.badwolf_css_props_highlight = 1
    end,
  },
  {
    "terkelg/north-sea.nvim",
    config = function()
      require("northsea").setup({})
      --vim.cmd.colorscheme("north-sea")
    end,
  }
}
