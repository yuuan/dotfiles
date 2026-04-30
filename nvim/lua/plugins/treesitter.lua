return {
  {
    -- TODO: アーカイブされてしまったので乗り換え先を探す
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,           -- FileType より前に走らせたいので false 推奨
    build = ":TSUpdate",
    config = function()
      local nts = require("nvim-treesitter")
      nts.setup({})

      -- インストール可能なパーサ一覧をキャッシュ (起動時に一度だけ取得)
      local available = {}
      for _, lang in ipairs(nts.get_available()) do
        available[lang] = true
      end

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local bufnr = args.buf
          local filetype = args.match
          if filetype == "" then return end

          local lang = vim.treesitter.language.get_lang(filetype)
          if not lang then return end

          -- インストール可能なパーサでなければ諦める
          if not available[lang] then return end

          -- パーサがインストールされていたらそれを使う
          local installed = nts.get_installed("parsers")
          if vim.tbl_contains(installed, lang) then
            pcall(vim.treesitter.start, bufnr)
            pcall(function()
              vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end)
            return
          end

          -- パーサがインストールされていなければインストールしてから使う
          nts.install({ lang }):await(function(err)
            if err then return end  -- インストール失敗時は静かに諦める
            if not vim.api.nvim_buf_is_valid(bufnr) then return end
            vim.schedule(function()
              pcall(vim.treesitter.start, bufnr)
              pcall(function()
                vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
              end)
            end)
          end)
        end,
      })
    end,
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
