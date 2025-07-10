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
      { '<C-Tab>', '<Plug>(copilot-accept-word)', mode = 'i', desc = 'Accept Copilot suggestion (word)' },
    },
  },
}
