vim.scriptencoding = "utf-8"

-- 先に読ませたいローカル設定の読み込み
if vim.fn.filereadable(vim.fn.stdpath('config')..'/lua/local/before.lua') == 1 then
	require('local.before')
end

local require_all = function(directory)
	for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath('config')..'/lua/'..directory, [[v:val =~ '\.lua$']])) do
		require(directory..'.'..file:gsub('%.lua$', ''))
	end
end

require_all('core')
require_all('keymaps')
require('plugins')

-- 後から読ませたいローカル設定の読み込み
if vim.fn.filereadable(vim.fn.stdpath('config')..'/lua/local/after.lua') == 1 then
	require('local.after')
end
