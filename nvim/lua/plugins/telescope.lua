return {
  {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    event = "VeryLazy",
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'BurntSushi/ripgrep' },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      { 'nvim-telescope/telescope-file-browser.nvim' },
      { 'LukasPietzschmann/telescope-tabs' },
    },
    opts = function()
      local actions = require('telescope.actions')
      local fb_actions = require('telescope').extensions.file_browser.actions

      local default_tab_mappings = {
        i = {
          ['<CR>'] = actions.select_tab,
          ['<C-e>'] = actions.select_default,
        },
      }

      return {
        defaults = {
          prompt_prefix = '  ',
          mappings = {
            i = {
              ['<C-s>'] = actions.select_horizontal,
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-p>'] = function() vim.api.nvim_put({ vim.fn.getreg('"') }, "", false, true) end,
              ["<M-u>"] = { "<C-u>", type = "command" },
            },
            n = {
              ['<C-c>'] = actions.close,
              ['<ESC><ESC>'] = actions.close,
            },
          },
          file_ignore_patterns = {
            '.git/objects/.*',
            '.git/*',
            'node_modules/*',
            'vendor/*',
            '.bundle/*',
          },
        },
        pickers = {
          find_files = {
            hidden = true, -- 隠しファイルを表示するかどうか
            mappings = default_tab_mappings,
          },
          live_grep = {
            mappings = default_tab_mappings,
          },
          git_status = {
            mappings = default_tab_mappings,
          },
          git_bcommits = {
            mappings = default_tab_mappings,
          },
          oldfiles = {
            mappings = default_tab_mappings,
          },
          lsp_references = {
            mappings = default_tab_mappings,
          },
          lsp_implementations = {
            mappings = default_tab_mappings,
          },
          lsp_dynamic_workspace_symbols = {
            mappings = default_tab_mappings,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = false, -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = 'smart_case',        -- or "ignore_case" or "respect_case"
                                             -- the default case_mode is "smart_case"
          },
          file_browser = {
            hidden = true,
            grouped = true,
            path = "%:p:h",
            respect_gitignore = false,
            mappings = {
              i = {
                ['<CR>'] = actions.select_tab,
                ['<C-e>'] = actions.select_default,
                ['<C-w>'] = fb_actions.goto_parent_dir,
                ['<C-h>'] = fb_actions.goto_home_dir,
                ['<C-g>'] = fb_actions.goto_cwd,
                ['<M-.>'] = fb_actions.toggle_hidden,
                ['<C-t>'] = actions.select_tab,
                ['<bs>'] = false, -- Backspace で親ディレクトリに移動させない
              },
              n = {
                --['<C-w>'] = fb_actions.goto_parent_dir,
                ['<bs>'] = fb_actions.goto_parent_dir,
                ['h'] = fb_actions.goto_home_dir,
                ['g'] = fb_actions.goto_cwd,
                ['w'] = false,
                ['e'] = actions.select_default,
                ['<M-.>'] = fb_actions.toggle_hidden,
              },
            },
          },
        },
      }
    end,
    config = function(_, opts)
      local telescope = require('telescope')
      telescope.setup(opts)
      telescope.load_extension('fzf')
      telescope.load_extension('file_browser')
    end,
    keys = function()
      local ivy = require('telescope.themes').get_ivy()
      return {
        {'<C-f><C-f>', function() require('telescope').extensions.file_browser.file_browser() end, desc = 'View files'},
        {'<C-f>f', function() require('telescope.builtin').find_files() end, desc = 'Find file in current directory'},
        {'<C-f>g', function() require('telescope.builtin').live_grep() end, desc = 'Find file by ripgrep'},
        {'<C-f>r', function() require('telescope.builtin').oldfiles() end, desc = 'File history'},
        {'<C-f>d', function() require('telescope.builtin').lsp_document_symbols() end, desc = 'LSP document symbols'},
        {'<C-f><C-d>', function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end, desc = 'LSP document workspace symbols'},
        {'<C-f>s', function() require('telescope.builtin').git_status() end, desc = 'Git status'},
        {'<C-f>l', function() require('telescope.builtin').git_bcommits() end, desc = 'Git log'},

        {'<C-w><C-f><C-f>', function() require('telescope').extensions.file_browser.file_browser(ivy) end, desc = 'View files'},
        {'<C-w><C-f>f', function() require('telescope.builtin').find_files(ivy) end, desc = 'Find file in current directory'},
        {'<C-w><C-f>g', function() require('telescope.builtin').live_grep(ivy) end, desc = 'Find file by ripgrep'},
        {'<C-w><C-f>r', function() require('telescope.builtin').oldfiles(ivy) end, desc = 'File history'},
        {'<C-w><C-f>d', function() require('telescope.builtin').lsp_document_symbols(ivy) end, desc = 'LSP document symbols'},
        {'<C-w><C-f><C-d>', function() require('telescope.builtin').lsp_dynamic_workspace_symbols(ivy) end, desc = 'LSP document workspace symbols'},
        {'<C-w><C-f>s', function() require('telescope.builtin').git_status(ivy) end, desc = 'Git status'},
        {'<C-w><C-f>l', function() require('telescope.builtin').git_bcommits(ivy) end, desc = 'Git log'},

        {'<C-f>b', function() require('telescope.builtin').buffers() end, desc = 'Select buffer'},
        {'<C-f>c', function() require('telescope.builtin').colorscheme() end, desc = 'Select colorscheme'},
        {'<C-f>j', function() require('telescope.builtin').jumplist() end, desc = 'Jump list'},
        {'<C-f>k', function() require('telescope.builtin').keymaps() end, desc = 'Keymaps'},
        {'<C-f>;', function() require('telescope.builtin').commands() end, desc = 'NeoVim commands'},
        {'<C-f>h', function() require('telescope.builtin').help_tags() end, desc = 'Help'},
        {'<C-f>t', function() require('telescope-tabs').list_tabs() end, desc = 'Select tab'},

        {'gr', function() require('telescope.builtin').lsp_references() end, desc = 'LSP References (tab)'},
        {'gd', function() require('telescope.builtin').lsp_definitions({ jump_type = 'tab' }) end, desc = 'LSP Definitions (tab)'},
        {'gf', function() require('telescope.builtin').lsp_type_definitions({ jump_type = 'tab' }) end, desc = 'LSP Type Definitions (tab)'},
        {'gi', function() require('telescope.builtin').lsp_implementations({ jump_type = 'tab' }) end, desc = 'LSP Implementations (tab)'},
        {'<C-w>gr', function() require('telescope.builtin').lsp_references({ jump_type = 'vsplit' }) end, desc = 'LSP References (vsplit)'},
        {'<C-w>gd', function() require('telescope.builtin').lsp_definitions({ jump_type = 'vsplit' }) end, desc = 'LSP Definitions (vsplit)'},
        {'<C-w>gf', function() require('telescope.builtin').lsp_type_definitions({ jump_type = 'vsplit' }) end, desc = 'LSP Type Definitions (vsplit)'},
        {'<C-w>gi', function() require('telescope.builtin').lsp_implementations({ jump_type = 'vsplit' }) end, desc = 'LSP Implementations (vsplit)'},
      }
    end,
  },
}
