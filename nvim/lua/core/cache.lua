vim.opt.backup = true
vim.opt.backupdir = vim.fn.stdpath('config')..'/backup'

vim.opt.swapfile = true
vim.opt.directory = vim.fn.stdpath('data')..'/swp'

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath('data')..'/undo'

-- ファイルを開いた時に、カーソルの場所を復元する
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	pattern = { "*" },
	callback = function()
		vim.api.nvim_exec('silent! normal! g`"zv', false)
	end,
})
