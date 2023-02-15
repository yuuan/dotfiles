local telescope = require('telescope')
local builtin = require('telescope.builtin')
local tabs = require('telescope-tabs')

vim.keymap.set('n', '<C-f><C-f>', telescope.extensions.file_browser.file_browser, {})
vim.keymap.set('n', '<C-f>f', builtin.find_files, {})
vim.keymap.set('n', '<C-f>g', builtin.live_grep, {})
vim.keymap.set('n', '<C-f>t', tabs.list_tabs, {})
vim.keymap.set('n', '<C-f>b', builtin.buffers, {})
vim.keymap.set('n', '<C-f>c', builtin.colorscheme, {})
vim.keymap.set('n', '<C-f>r', builtin.oldfiles, {})
vim.keymap.set('n', '<C-f>h', builtin.help_tags, {})
vim.keymap.set('n', '<C-f>d', builtin.lsp_references, {})

local actions = require('telescope.actions')
local fb_actions = telescope.extensions.file_browser.actions

telescope.setup({
  defaults = {
    prompt_prefix = '  ',
    mappings = {
      i = {
        ['<C-s>'] = actions.select_horizontal,
      },
    },
    file_ignore_patterns = {'.git/objects/.*'},
  },
  pickers = {
    find_files = {
      hidden = true, -- 隠しファイルを表示するかどうか
      mappings = {
        i = {
          ['<CR>'] = actions.select_tab,
          ['<C-e>'] = actions.select_default,
        },
      },
    },
    live_grep = {
      mappings = {
        i = {
          ['<CR>'] = actions.select_tab,
          ['<C-e>'] = actions.select_default,
        },
      },
    },
    oldfiles = {
      mappings = {
        i = {
          ['<CR>'] = actions.select_tab,
          ['<C-e>'] = actions.select_default,
        },
      },
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
          ['<C-w>'] = fb_actions.goto_parent_dir,
          ['<C-\\>'] = fb_actions.goto_cwd,  -- Ctrl + -
          ['<C-^>'] = fb_actions.goto_home_dir,
          ['<C-g>'] = false,
          ['<C-e>'] = actions.select_default,
          ['<C-t>'] = actions.select_tab,
          ['<CR>'] = actions.select_tab,
        },
      },
    },
  },
})
telescope.load_extension('fzf')
telescope.load_extension('file_browser')
