-- Home と End
for _, mode in ipairs({'n','v','i','t'}) do
  vim.keymap.set(mode, '<C-a>', '<Home>', { noremap = true, silent = true })
  vim.keymap.set(mode, '<C-e>', '<End>', { noremap = true, silent = true })
end

-- Ctrl + h, j, k, l でカーソル移動
--vim.keymap.set('i', '<C-h>', '<Left>', { noremap = true, silent = true })
--vim.keymap.set('i', '<C-j>', '<Down>', { noremap = true, silent = true })
--vim.keymap.set('i', '<C-k>', '<Up>', { noremap = true, silent = true })
--vim.keymap.set('i', '<C-l>', '<Right>', { noremap = true, silent = true })

-- Ctrl + k で行末まで削除
vim.keymap.set('i', '<C-k>', '<C-o>D', { noremap = true, silent = true })

-- 検索後に ESC キーでハイライトを消す
-- vim.keymap.set("n", "<Esc><Esc>", ":<C-u>set nohlsearch<CR>", { noremap = true, silent = true })

-- コマンドラインモードで Ctrl + p で貼り付け
vim.keymap.set('c', '<C-p>', '<C-r>"', { noremap = true, silent = true })

-- インサートモードで Ctrl + p で貼り付け
vim.keymap.set('i', '<C-p>', '<C-r>"', { noremap = true, silent = true })

-- "0 レジスタを使って明示的にヤンクしたものだけを貼り付ける
vim.keymap.set("n", "gp", '"0p', { noremap = true, silent = true })

-- "0 レジスタを使って明示的にヤンクしたものだけを貼り付ける
vim.keymap.set("n", "gP", '"0P', { noremap = true, silent = true })

-- x で削除した文字をヤンクしない
vim.keymap.set('n', 'x', '"_x', { noremap = true, silent = true })

-- s で置換した文字をヤンクしない
vim.keymap.set('n', 's', '"_s', { noremap = true, silent = true })

-- ビジュアルモードで貼り付けたときに削除された文字をヤンクしない
vim.keymap.set('v', 'p', '"_dp', { noremap = true, silent = true })
vim.keymap.set('v', 'P', '"_dP', { noremap = true, silent = true })

-- 単語を選択
vim.keymap.set('n', '+', 'viw', { noremap = true, silent = true })

-- インデントした後も範囲選択を残す
vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true })
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true })

-- 数値の増減で Ctrl の代わりに Alt を使う
vim.keymap.set('n', '<M-a>', '<C-a>', { noremap = true, silent = true })
vim.keymap.set('n', '<M-x>', '<C-x>', { noremap = true, silent = true })

-- テンキーの +/- で数値の増減
--vim.keymap.set('n', '<kPlus>', '<C-a>', { noremap = true, silent = true })
--vim.keymap.set('n', '<kMinus>', '<C-x>', { noremap = true, silent = true })

-- M で隠れた Virtual Text をフローティング表示する
vim.keymap.set('n', 'M', vim.diagnostic.open_float, { noremap = true, silent = true })
