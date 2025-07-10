for _, mode in ipairs({'n','v','i','t'}) do
  vim.keymap.set(mode, '\x1b[9;5u', '<C-Tab>', { silent = true })
end
