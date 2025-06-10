return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufNewFile", "BufReadPre" },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = false,
      sign_priority = 11, -- default: 8
      keywords = { -- icon にはスペースを含められない
        -- Default keywords
        FIX = { icon = "", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = "", color = "info" },
        HACK = { icon = "", color = "warning" },
        WARN = { icon = "", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = "", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = "", color = "hint", alt = { "INFO" } }, -- icon changed
        TEST = { icon = "", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },

        -- Custom keywords
        ERR = { icon = "", color = "error", alt = { "ERROR" } },
        Deprecated = { icon = "", color = "warning", alt = { "DEPRECATED" } },

        -- FIX: fix
        -- TODO: todo
        -- HACK: hack
        -- WARN: warning
        -- PERF: performance
        -- NOTE: note
        -- TEST: test
        -- ERR: error
        -- DEPRECATED: deprecated
      },
      merge_keywords = true,
      highlight = {
        multiline = false,
        before = "",
        keyword = "bg",
        after = "",
      },
      colors = {
        -- @see: https://github.com/morhetz/gruvbox
        error = { "#cc241d" },
        warning = { "#d79921" },
        info = { "#689d6a" },
        hint = { "#458588" },
        default = { "#a89984" },
        test = { "#b16286" },
      },
    }
  }
}
