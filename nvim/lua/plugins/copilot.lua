return {
  {
    -- GitHub Copilot
    'github/copilot.vim',
    event = "VeryLazy",
    init = function()
      vim.g.copilot_filetypes = {
        gitcommit = true,
      }
    end,
    keys = {
      { '<Esc>[9;5u', '<Plug>(copilot-accept-word)', mode = 'i', desc = 'Accept Copilot suggestion (word)' },
    },
  },
}
