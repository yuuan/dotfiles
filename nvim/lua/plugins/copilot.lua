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
  },
}
