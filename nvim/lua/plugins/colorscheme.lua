-- カラースキーマの選択
vim.opt.background = 'dark'
vim.cmd([[colorscheme gruvbox]])

-- タブ文字の色
--vim.api.nvim_set_hl(0, "SpecialKey", { ctermfg = 236,  ctermbg = 16 })
vim.api.nvim_set_hl(0, "SpecialKey", { ctermfg = 196,  ctermbg = 16 })

-- 検索結果の色
--vim.api.nvim_set_hl(0, "Search", { ctermfg = 16,  ctermbg = 214 })

-- 対応する括弧の色 (濃い赤:124, 黄緑:154, オレンジ:208)
--vim.api.nvim_set_hl(0, "MatchParen", { ctermfg = 15,  ctermbg = 124 })
--vim.api.nvim_set_hl(0, "MatchParen", { ctermfg = 8,  ctermbg = 154 })
vim.api.nvim_set_hl(0, "MatchParen", { ctermfg = 8,  ctermbg = 208 })
