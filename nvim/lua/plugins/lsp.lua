return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      automatic_enable = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'williamboman/mason.nvim',
      "williamboman/mason-lspconfig.nvim",
    },
    -- setup() は必要ない
    config = function()
      -- :LspRename で LSP の rename 機能を使えるようにする
      vim.api.nvim_create_user_command("LspRename", function()
        vim.lsp.buf.rename()
      end, {})

      -- LSP が有効なときに設定するキーマップ
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "Attach key mappings for LSP functionalities",
        callback = function ()
          vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
          vim.keymap.set('n', 'gw', function() vim.lsp.buf.format { async = true } end)
--        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')  -- use Telescope
--        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')  -- use Telescope
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
--        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')  -- use Telescope
--        vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')  -- use Telescope
--        vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')  -- use :LspRename
          vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
--        vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')  -- use Telescope
--        vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
--        vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
        end
      })

      vim.lsp.config('*', {
        capabilities = require("cmp_nvim_lsp").default_capabilities()
      })
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
      -- LSP を使った補完
      'hrsh7th/cmp-nvim-lsp',

      -- 関数の引数を補完
      'hrsh7th/cmp-nvim-lsp-signature-help',

      -- バッファ内の単語を補完
      'hrsh7th/cmp-buffer',

      -- ファイルパスを補完
      'hrsh7th/cmp-path',

      -- NeoVim の Lua API の補完
      'hrsh7th/cmp-nvim-lua',

      -- コマンドラインの補完
      'hrsh7th/cmp-cmdline',

      -- コマンドラインや検索の履歴から補完
      'dmitmel/cmp-cmdline-history',

      -- Git の Commit や GitHub の PR, Issue などを補完
      'petertriho/cmp-git',

      -- Snippet を補完
      'hrsh7th/cmp-vsnip',

      -- 補完候補にアイコンを表示
      'onsails/lspkind.nvim',
    },
    opts = function()
      local cmp = require('cmp')
      local lspkind = require('lspkind')
      return {
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<PageDown>'] = cmp.mapping.scroll_docs(-4),
          ['<PageUp>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'vsnip' },
        }, {
          { name = 'buffer' },
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
          })
        },
      }
    end,
    config = function(_, opts)
      local cmp = require('cmp')
      cmp.setup(opts)

      -- for Git commit
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'cmp_git' },
        }, {
          { name = 'buffer' },
        })
      })

      -- for Lua
      cmp.setup.filetype('lua', {
        sources = cmp.config.sources({
          { name = 'nvim_lua' },
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
        }, {
          { name = 'buffer' },
        })
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'cmdline_history' },
        }, {
          { name = 'buffer' },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
          { name = 'cmdline_history' },
        })
      })
    end,
  },
}
