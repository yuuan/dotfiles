-- `.env` は SH
vim.filetype.add({
  pattern = {
    [".env.[%l]+"] = "sh",
  }
})

-- 環境ごとの YAML
vim.filetype.add({
  pattern = {
    ["%.yml%.[%l]+"] = "yaml",
  }
})

-- `composer.lock` は JSON
vim.filetype.add({
  filename = {
    ["composer.lock"] = "json",
  }
})

-- `.php_cs` は PHP
vim.filetype.add({
  filename = {
    [".php_cs"]      = "php",
    [".php_cs.dist"] = "php",
  }
})

-- `.neon` は YAML
vim.filetype.add({
  extension = {
    neon  = "yaml",
    neon_dist = "yaml",
  }
})

-- `*.t` は Perl
vim.filetype.add({
  extension = {
    t = "perl",
  }
})

-- Markdown
vim.filetype.add({
  extension = {
    md    = "mkd",
    mdwn  = "mkd",
    mkd   = "mkd",
    mkdn  = "mkd",
  }
})

-- `nyagos` は Lua
vim.filetype.add({
  filename = {
    ["nyagos"] = "lua",
  }
})

-- `/etc/td-agent/` 以下にあるのは fluentd
vim.filetype.add({
  pattern = {
    ["/etc/td-agent/.*%.conf"]          = "fluentd",
    ["/etc/td-agent/.*%.conf%.example"] = "fluentd",
  }
})
