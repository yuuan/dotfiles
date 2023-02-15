-- Ctrl + 左右キーでタブを切り替え
vim.keymap.set('n', '<C-Right>', ':<C-u>tabn<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Left>', ':<C-u>tabp<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-Right>', '<ESC>:tabn<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-Left>', '<ESC>:tabp<CR>', { noremap = true, silent = true })
vim.keymap.set('c', '<C-Right>', '<C-u>tabn', { noremap = true, silent = true })
vim.keymap.set('c', '<C-Left>', '<C-u>tabp', { noremap = true, silent = true })

-- Ctrl + 上下キーでスクロール
vim.keymap.set('', '<C-Up>', '<C-y>', { noremap = true, silent = true })
vim.keymap.set('', '<C-Down>', '<C-e>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-Up>', '<C-o><C-y>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-Down>', '<C-o><C-e>', { noremap = true, silent = true })

-- Alt + 上下キーでスクロール
vim.keymap.set('', '<M-Up>', '<C-y>', { noremap = true, silent = true })
vim.keymap.set('', '<M-Down>', '<C-e>', { noremap = true, silent = true })

-- PageUp/Down の幅を半分に
vim.keymap.set('', '<PageUp>', '<C-u>', { noremap = true, silent = true })
vim.keymap.set('', '<PageDown>', '<C-d>', { noremap = true, silent = true })

-- Ctrl-b/Ctrl-f によるページ移動を無効化
vim.keymap.set('n', '<C-b>', '', { noremap = true, silent = true })
vim.keymap.set('n', '<C-f>', '', { noremap = true, silent = true })
