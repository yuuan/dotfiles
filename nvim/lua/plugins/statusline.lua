return {
  -- ステータスライン
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = function()
      local function charvalue()
        return require('plenary.strings').strcharpart(
          vim.fn.getline('.'):sub(vim.fn.col('.')), 0, 1
        )
      end

      local function charvaluehex()
        local text = charvalue()
        local length = text:len()

        if length == 0 then
          return '----'
        end

        local hex = '0x'

        for i = 1, length do
          hex = hex .. string.format('%x', text:byte(i))
        end

        return hex
      end

      local function filepath()
        return vim.fn.expand('%')
      end

      return {
        options = {
          icons_enabled = true,
          -- @see https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
          theme = 'gruvbox_dark',
          component_separators = { left = '∷', right = '∷' },
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { filepath },
          lualine_c = { 'diff', 'diagnostics' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { charvaluehex },
          lualine_z = { 'progress', 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {},
        },
      }
    end,
  },
}
