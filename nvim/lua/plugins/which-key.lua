return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    triggers = {
      { "<C-f>", mode = { "n" } },
      { "g", mode = { "n", "v" } },
      { "<leader>", mode = { "n", "v" } },
    },
  },
}
