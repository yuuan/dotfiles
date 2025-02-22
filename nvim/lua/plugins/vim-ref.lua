return {
  -- カーソル下の単語のリファレンスを表示
  {
    'thinca/vim-ref',
    event = "VeryLazy",
    init = function()
      if vim.fn.executable('lynx') == 1 then
        vim.g.ref_alc_cmd='lynx -dump -nonumbers %s'
        vim.g.ref_phpmanual_cmd='lynx -dump -nonumbers %s'
      end

      if vim.fn.isdirectory(vim.fn.stdpath('data')..'/docs/php-chunked-xhtml') == 1 then
        vim.g.ref_phpmanual_path = vim.fn.stdpath('data')..'/docs/php-chunked-xhtml'
      end

      vim.g.ref_detect_filetype = {
        blade = 'phpmanual',
      }
    end,
  },
}
