local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "plugins.lua" },
  command = "PackerCompile",
})

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)

  -- ------------------------------
  -- Core
  -- ------------------------------

  -- プラグイン管理
  use 'wbthomason/packer.nvim'

  -- 曖昧な文字幅の問題を解決
  use 'rbtnn/vim-ambiwidth'

  -- deno を有効化
  use 'vim-denops/denops.vim'

  -- NARD Font のアイコンを扱えるようにする
  use 'nvim-tree/nvim-web-devicons'

  -- コマンドや通知をポップアップ表示
  -- use({
  --   "folke/noice.nvim",
  --   config = function()
  --     vim.notify = require("notify")
  --     vim.notify.setup({
  --       timeout = 15000,  -- default: 5000
  --     })
  -- 
  --     require("noice").setup({
  --       -- add any options here
  --     })
  --   end,
  --   requires = {
  --     "MunifTanjim/nui.nvim",
  --     "rcarriga/nvim-notify",
  --   }
  -- })


  -- ------------------------------
  -- Display
  -- ------------------------------

  -- スペースによるインデントを見やすく表示する
  use({
    'Yggdroot/indentLine',
    setup = function()
      -- 区切り文字の色
      vim.g.indentLine_color_term = 237

      -- 区切り文字
      vim.g.indentLine_char = '|' -- default '¦'

      -- ガイドを表示するインデントの深さ
      vim.g.indentLine_indentLevel = 20 -- default 10
    end,
  })

  -- カーソル下の単語に下線を引く
  use 'itchyny/vim-cursorword'


  -- ------------------------------
  -- Status line
  -- ------------------------------

  -- ステータスライン
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('plugins.lualine')
    end,
  }


  -- ------------------------------
  -- Colorschema
  -- ------------------------------

  use { 'morhetz/gruvbox', opt = true }

  use {
    'altercation/vim-colors-solarized',
    opt = true,
    setup = function()
      vim.g.solarized_termcolors = 16
      --vim.g.solarized_termtrans = 1
    end,
  }

  use {
    'sjl/badwolf',
    opt = true,
    setup = function()
      vim.g.badwolf_html_link_underline = 0
      vim.g.badwolf_css_props_highlight = 1
    end,
  }

  require('plugins.colorscheme')


  -- ------------------------------
  -- Telescope
  -- ------------------------------

  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'BurntSushi/ripgrep' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      { 'nvim-telescope/telescope-file-browser.nvim' },
      { 'LukasPietzschmann/telescope-tabs' },
    },
    config = function()
      require('plugins.telescope')
    end,
  }


  -- ------------------------------
  -- File
  -- ------------------------------

  -- `sudo:<ファイル名>` でファイルを開くと root 権限で開く
  use 'vim-scripts/sudo.vim'

  -- Vimdiff に Git-diff のアルゴリズムを使う
  use {
    'lambdalisue/vim-unified-diff',
    setup = function()
      vim.cmd([[
        set diffexpr=unified_diff#diffexpr()

        " configure with the followings (default values are shown below)
        let unified_diff#executable = 'git'
        let unified_diff#arguments = [
            \   'diff', '--no-index', '--no-color', '--no-ext-diff', '--unified=0',
            \ ]
        let unified_diff#iwhite_arguments = [
            \   '--ignore--all-space',
            \ ]
      ]])
    end,
  }


  -- ------------------------------
  -- Git
  -- ------------------------------

  use 'tpope/vim-fugitive'

  use 'gregsexton/gitv'

  use 'airblade/vim-gitgutter'


  -- ------------------------------
  -- Syntax
  -- ------------------------------

  -- コンテキストによってファイルタイプを切り替える (TODO: 切り替わらない)
  use 'Shougo/context_filetype.vim'

  -- 色んな Syntax 詰め合わせ
  use 'sheerun/vim-polyglot'

  -- Prisma
  use 'prisma/vim-prisma'

  require('plugins.filetype')


  -- ------------------------------
  -- Language Server
  -- ------------------------------

  -- LSP Server の管理
  use {
    'williamboman/mason.nvim',
    requires = {
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('plugins.lsp')
    end,
  }


  -- ------------------------------
  -- Completion
  -- ------------------------------

  use {
    'Shougo/ddc.vim',
    event = 'InsertEnter',
    requires = {
      -- 補完用のポップアップウィンドウを pum.vim で表示
      'Shougo/pum.vim',
      'Shougo/ddc-ui-pum',

      -- 補完候補の詳細情報をポップアップ表示
      'matsui54/denops-popup-preview.vim',

      -- 引数などの情報をポップアップ表示
      'matsui54/denops-signature_help',

      -- コマンドモードの補完にポップアップウィンドウを使用
      'gelguy/wilder.nvim',
    },
    config = function()
      require('plugins.ddc')
    end,
  }

  -- Source --------

  -- LSP を使って補完する Source
  use 'Shougo/ddc-source-nvim-lsp'

  -- スニペット Source
  use {
    'hrsh7th/vim-vsnip-integ',
    event = 'InsertEnter',
    requires = { 'hrsh7th/vim-vsnip' },
    config = function()
      -- スニペットの保存先
      vim.g.vsnip_snippet_dir = vim.fn.stdpath('config')..'/snippets'

      -- jsx/tsx で JavaScript/TypeScript のスニペットを使う
      vim.g.vsnip_filetypes = {}
      vim.g.vsnip_filetypes.javascriptreact = { 'javascript' }
      vim.g.vsnip_filetypes.typescriptreact = { 'typescript' }

      -- pum.vim 使用時に LSP の testEdit に従いソースコードを修正
      -- @see https://zenn.dev/matsui54/articles/2021-09-03-ddc-lsp
      vim.cmd([[autocmd User PumCompleteDone call vsnip_integ#on_complete_done(g:pum#completed_item)]])
    end,
  }

  -- カーソル周辺の既出単語を補完する Source
  use 'Shougo/ddc-around'

  -- ファイル名を補完する Source
  use 'LumaKernel/ddc-source-file'

  -- コマンドの補完 Source
  use 'Shougo/ddc-source-input'

  -- コマンドモードで補完する Source
  use 'Shougo/ddc-source-cmdline'

  -- コマンドモードで履歴から補完する Source
  use 'Shougo/ddc-source-cmdline-history'

  -- ddu で使う補完 Source
  use 'Shougo/ddc-source-line'

  -- バッファからキーワードを補完する Source
  use 'matsui54/ddc-buffer'

  -- Lua 用の補完 Source
  use 'Shougo/ddc-source-nvim-lua'

  -- Zsh 用の補完 Source
  use 'Shougo/ddc-zsh'

  -- Vim Script の補完
  use { 'Shougo/neco-vim', ft = {'vim', 'toml', 'markdown'} }

  -- Vim Script の補完候補を Syntax ファイルから追加
  use 'Shougo/neco-syntax'

  -- Filter --------

  -- 補完候補を入力中の単語で絞り込む Filter
  use 'Shougo/ddc-matcher_head'

  -- 補完候補を適切にソートする Filter
  use 'Shougo/ddc-sorter_rank'


  -- ------------------------------
  -- Edit
  -- ------------------------------

  -- 単語を囲む要素を扱いやすくする
  use 'tpope/vim-surround'

  -- Emmet 記法を使えるようにする
  use {
    'mattn/emmet-vim',
    setup = function()
      -- デフォルトで無効
      vim.g.user_emmet_install_global = 0

	  -- 次の FileType でのみ有効化
      vim.cmd([[
        autocmd FileType html,css,blade,javascriptreact,typescriptreact,jsx,ts,xml,less,sass,scss EmmetInstall
      ]])

      -- 出力する lang の設定
      vim.g.user_emmet_settings = {
        variables = {
          lang = 'ja'
        }
      }
    end,
  }

  -- 対応する閉じ括弧を自動入力
  use 'kana/vim-smartinput'

  -- 対応する end を自動入力
  use 'cohama/vim-smartinput-endwise'

  -- `true` と `false` を切り替える
  use {
    'AndrewRadev/switch.vim',
    setup = function()
      vim.cmd([[
        let g:switch_custom_definitions = [
        \   [ 'private', 'protected', 'public' ],
        \   [ 'self::', 'static::' ],
        \   [ 'endif', 'endunless' ],
        \   [ 'if', 'unless' ],
        \   [ 'while', 'until', 'do' ],
        \   [ "'ASC'", "'DESC'" ],
        \   [ "'asc'", "'desc'" ],
        \   [ 'yes', 'no' ],
        \   [ 'on', 'off' ],
        \   [ 'enable', 'disable' ],
        \   [ 'Enable', 'Disable' ],
        \   [ 'allow', 'deny' ],
        \   [ 'required', 'sometimes', 'optional' ],
        \   [ 'var', 'let', 'const' ],
        \   [ 'my', 'our', 'local' ],
        \   {
        \     '\>->\(\w\{1,}\)\>': '[''\1'']',
        \     '\[''\(\w\{1,}\)''\]': '->\1',
        \   },
        \ ]
      ]])
      vim.keymap.set('n', '-', '<CMD>Switch<CR>', { noremap = true, silent = true })
    end,
  }

  -- コメントイン/アウトの切り替え
  use {
    'tyru/caw.vim',
    config = function()
      vim.keymap.set('n', '##', '<Plug>(caw:zeropos:toggle)', { noremap = true, silent = true })
      vim.keymap.set('v', '##', '<Plug>(caw:zeropos:toggle)', { noremap = true, silent = true })
    end,
  }

  -- ペーストしたときにペーストモードにする
  use 'ConradIrwin/vim-bracketed-paste'

  -- 表の位置を揃える
  use 'godlygeek/tabular'


  -- ------------------------------
  -- Reference
  -- ------------------------------

  -- カーソル下の単語のリファレンスを表示
  use {
    'thinca/vim-ref',
    setup = function()
      if vim.fn.executable('lynx') == 1 then
        vim.g.ref_alc_cmd='lynx -dump -nonumbers %s'
        vim.g.ref_phpmanual_cmd='lynx -dump -nonumbers %s'
      end

      if vim.fn.isdirectory(vim.fn.stdpath('data')..'/docs/php-chunked-xhtml') == 1 then
        vim.g.ref_phpmanual_path = vim.fn.stdpath('data')..'/docs/php-chunked-xhtml'
      end

      vim.g.ref_detect_filetype = {
        blade = 'phpmanual',
      }
    end,
  }

  -- 日本語の Vim ドキュメント
  --use 'vim-jp/vimdoc-ja'


  -- ------------------------------
  -- Services
  -- ------------------------------

  -- WakaTime で記録
  use 'wakatime/vim-wakatime'


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
