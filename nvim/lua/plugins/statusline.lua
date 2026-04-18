return {
  -- ステータスライン
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'yuuan/lualine-fileencoding',
      'yuuan/lualine-charvaluehex',
    },
    opts = function()
      local tabs = {
        'tabs',
        max_length = vim.o.columns,
        section_separators   = { left = '', right = '' }, -- around the active tab
        component_separators = { left = '', right = '' }, -- between inactive tabs
        mode = 2,
        show_modified_status = false,
        tabs_color = {
          active = { bg = '#458588', fg = '#fbf1c7' },
        },
        fmt = function(name, context)
          -- Show + if buffer is modified in tab
          local buflist = vim.fn.tabpagebuflist(context.tabnr)
          local winnr = vim.fn.tabpagewinnr(context.tabnr)
          local bufnr = buflist[winnr]
          local mod = vim.fn.getbufvar(bufnr, '&mod')

          return name .. (mod == 1 and ' 󰐖' or '')
        end
      }

      local lsp_status = {
        'lsp_status', icon = '', symbols = {
          spinner = { '', '', '', '', '' },
          done = '',
          separator = ' ∷ ',
        },
      }

      local filepath = {
        'filename',
        path = 1,
        symbols = {
          modified = ' ',
          readonly = '',
        },
      }

      return {
        options = {
          icons_enabled = true,
          -- @see https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
          theme = 'gruvbox_dark',
          component_separators = { left = '∷', right = '∷' },
          section_separators = { left = '', right = '' },
        },
        tabline = {
          lualine_a = { tabs },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { filepath },
          lualine_c = { 'filesize', 'diff', 'diagnostics' },
          lualine_x = { lsp_status },
          lualine_y = { 'filetype', { 'fileencoding', symbols = { unix = '' }, show_bomb = true } },
          lualine_z = { 'charvaluehex' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = { filepath },
          lualine_c = { 'diff' },
          lualine_x = { 'filetype' },
          lualine_y = {},
          lualine_z = {},
        },
      }
    end,
  },
}
