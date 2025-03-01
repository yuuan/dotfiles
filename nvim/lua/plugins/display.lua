return {
  -- スペースによるインデントを見やすく表示する
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      indent = { enable = true },
      chunk = { enable = true },
    },
    keys = {
      { "!!", function()
        local is_decorated = vim.opt_local.number:get()

        vim.opt_local.number = not is_decorated
        vim.opt_local.list = not is_decorated
        vim.opt_local.signcolumn = is_decorated and 'no' or 'auto'

        if is_decorated then
          require('hlchunk.mods.indent')():disable()
          require('hlchunk.mods.chunk')():disable()
          vim.api.nvim_command('GitGutterDisable')
        else
          require('hlchunk.mods.indent')():enable()
          require('hlchunk.mods.chunk')():enable()
          vim.api.nvim_command('GitGutterEnable')
        end
      end, noremap = true, silent = true, desc = "Toggle line number display" },
    },
  },

  -- カーソル下の単語に下線を引く
  { 'itchyny/vim-cursorword' },

  -- カラーコードをその色で表示
  {
    'norcalli/nvim-colorizer.lua',
    opts = {
      -- Enable CSS functions: rgb(), rgba(), hsl(), hsla()
      css = { css_fn = true; };
    },
  },
}
