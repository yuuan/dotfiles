return {
  {
    'hrsh7th/vim-vsnip',
    dependencies = {
      'hrsh7th/vim-vsnip-integ',
    },
    init = function()
      -- スニペットの保存先
      vim.g.vsnip_snippet_dir = vim.fn.stdpath('config')..'/snippets'
    end,
-- cmp 経由で使用するためキーマップは設定しない
--    keys = {
--      {
--        "<Tab>",
--        function()
--          return vim.fn["vsnip#jumpable"](1) and "<Plug>(vsnip-jump-next)" or "<Tab>"
--        end,
--        expr = true,
--        mode = { "i", "s" }, -- insert と select モードで有効
--        silent = true,
--      },
--      {
--        "<S-Tab>",
--        function()
--          return vim.fn["vsnip#jumpable"](-1) and "<Plug>(vsnip-jump-prev)" or "<S-Tab>"
--        end,
--        expr = true,
--        mode = { "i", "s" },
--        silent = true,
--      },
--    },
  },
}

