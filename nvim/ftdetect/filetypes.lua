vim.filetype.add({
  pattern = {
    -- `.env` は SH
    ["%.env%.[%l]+$"] = "sh",

    -- 環境ごとの YAML
    ["%.yml%.[%l]+"] = "yaml",

    -- `/etc/td-agent/` 以下にあるのは fluentd
    ["/etc/td-agent/.*%.conf"]          = "fluentd",
    ["/etc/td-agent/.*%.conf%.example"] = "fluentd",
  },
  filename = {
    -- `composer.lock` は JSON
    ["composer.lock"] = "json",

    -- `.php_cs` は PHP
    [".php_cs"]      = "php",
    [".php_cs.dist"] = "php",

    -- `nyagos` は Lua
    ["nyagos"] = "lua",
  },
  extension = {
    -- `.neon` は YAML
    neon  = "yaml",
    neon_dist = "yaml",

    -- `*.t` は Perl
    t = "perl",

    -- Markdown
    md    = "mkd",
    mdwn  = "mkd",
    mkd   = "mkd",
    mkdn  = "mkd",
  }
})
