return {
  -- Emmet 記法を使えるようにする
  {
    'mattn/emmet-vim',
    init = function()
      -- デフォルトで無効
      vim.g.user_emmet_install_global = 0

      -- 出力する lang の設定
      vim.g.user_emmet_settings = {
        variables = {
          lang = 'ja'
        }
      }
    end,
    config = function()
      require('emmet').setup()

      -- 次の FileType でのみ有効化
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "html", "css", "blade", "javascriptreact", "typescriptreact", "jsx", "ts", "xml", "less", "sass", "scss" },
        command = "EmmetInstall",
      })
    end,
  },
}
