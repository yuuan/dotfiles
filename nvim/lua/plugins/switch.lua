return {
  -- `true` と `false` を切り替える
  {
    'AndrewRadev/switch.vim',
    event = "VeryLazy",
    init = function()
      vim.g.switch_custom_definitions = {
        { "private", "protected", "public" },
        { "self::", "static::" },
        { "endif", "endunless" },
        { "if", "unless" },
        { "while", "until", "do" },
        { "'ASC'", "'DESC'" },
        { "'asc'", "'desc'" },
        { "yes", "no" },
        { "on", "off" },
        { "enable", "disable" },
        { "Enable", "Disable" },
        { "allow", "deny" },
        { "required", "sometimes", "optional" },
        { "var", "let", "const" },
        { "my", "our", "local" },
        {
          ["\\>->\\(\\w\\{1,}\\)\\>"] = "['\\1']", -- `->property` -> `['property']`
          ["\\['\\(\\w\\{1,}\\)'\\]"] = "->\\1",   -- `['property']` -> `->property`
        },
      }
      vim.keymap.set('n', '-', '<CMD>Switch<CR>', { noremap = true, silent = true })
    end,
  }
}
