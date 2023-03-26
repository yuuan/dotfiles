-- キーバインドの設定
local on_attach = function(client, bufnr)
  vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
  vim.keymap.set('n', 'gf', function() vim.lsp.buf.format { async = true } end)
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
--  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')  -- use Telescope
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
--  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')  -- use Telescope
--  vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')  -- use Telescope
  vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
--  vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')  -- use Telescope
  vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
  vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
end

-- Language Server
local language_servers = {
  'tsserver',
  'eslint',
  'jsonls',
  'phpactor',
  'ruby_ls',
  'cssls',
  'html',
  'terraformls',
  'yamlls',
  'vimls',
}

-- 初期化
require("mason").setup()
require("mason-lspconfig").setup({
  -- ensure_installed = language_servers,
})
require("mason-lspconfig").setup_handlers({
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup({
      on_attach = on_attach,
    })
  end
})
