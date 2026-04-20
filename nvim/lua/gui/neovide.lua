if vim.g.neovide then
  vim.o.guifont = "HackGen Console NF:h17"
  vim.g.neovide_opacity = 0.9

  vim.g.neovide_theme = 'dark'
  vim.o.background = 'dark'

  -- macOS
  if vim.uv.os_uname().sysname == "Darwin" then
    vim.g.neovide_input_macos_option_key_is_meta = 'only_left'
    vim.g.neovide_input_macos_command_key_is_meta = false

    -- Copy & Paste
    local function save() vim.cmd.write() end
    local function copy() vim.cmd([[normal! "+y]]) end
    local function paste() vim.api.nvim_paste(vim.fn.getreg("+"), true, -1) end

    vim.keymap.set({ "n", "i", "v" }, "<D-s>", save, { desc = "Save" })
    vim.keymap.set("v", "<D-c>", copy, { silent = true, desc = "Copy" })
    vim.keymap.set({ "n", "i", "v", "c", "t" }, "<D-v>", paste, { silent = true, desc = "Paste" })

    for _, key in ipairs({ "Left", "Right", "Up", "Down" }) do
      vim.keymap.set(
        { "n", "v", "o", "i", "c", "t" },
        "<D-" .. key .. ">",
        "<C-" .. key .. ">",
        { remap = true, desc = "Map <D-" .. key .. "> to <C-" .. key .. "> (for Neovide)" }
      )
    end
  end
end
