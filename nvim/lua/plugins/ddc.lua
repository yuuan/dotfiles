-- 補完候補の表示に pum を使う
vim.fn['ddc#custom#patch_global']('ui', 'pum')
vim.fn['ddc#custom#patch_global']('completionMenu', 'pum.vim')
vim.fn['ddc#custom#patch_global']('autoCompleteEvents', {
    'InsertEnter', 'TextChangedI', 'TextChangedP',
    'CmdlineEnter', 'CmdlineChanged', 'TextChangedT',
})

-- Source を設定
vim.fn['ddc#custom#patch_global']('sources', {
  'vsnip',
  'nvim-lsp',
  'around',
  'file',
})

-- コマンドモードで使う Source を設定
vim.fn['ddc#custom#patch_global']('cmdlineSources', {
  [':'] = { 'cmdline-history', 'cmdline', 'around' },
  ['@'] = { 'cmdline-history', 'input', 'file', 'around' },
  ['>'] = { 'cmdline-history', 'input', 'file', 'around' },
  ['/'] = { 'around', 'line' },
  ['?'] = { 'around', 'line' },
  ['-'] = { 'around', 'line' },
  ['='] = { 'input' },
})

-- VimScript の補完で使う Source を設定
vim.fn['ddc#custom#patch_filetype'](
  { 'lua' }, 'sources', { 'vsnip', 'nvim-lua', 'nvim-lsp', 'around', 'file' }
)

-- VimScript の補完で使う Source を設定
vim.fn['ddc#custom#patch_filetype'](
  { 'vim' }, 'sources', { 'vsnip', 'necovim', 'nvim-lsp', 'around', 'file' }
)

-- Zsh Script の補完で使う Source を設定
vim.fn['ddc#custom#patch_filetype'](
  { 'zsh' }, 'sources', { 'vsnip', 'zsh', 'nvim-lsp', 'around', 'file' }
)

-- ddc の補完で使う Source を設定
vim.fn['ddc#custom#patch_filetype'](
  { 'ddu-ff-filter' }, {
    keywordPattern = [['[0-9a-zA-Z_:#-]*']],
    sources = { 'line', 'buffer' },
    specialBufferCompletion = [[v:true]],
  }
)

-- 各種 Source の設定
vim.fn['ddc#custom#patch_global']('sourceOptions', {
  ['_'] = {
    ignoreCase = [[v:true]],
    matchers = { 'matcher_head' },
    sorters = { 'sorter_rank' },
  },
  ['vsnip'] = {
    mark = 'vsnip',
  },
  ['nvim-lsp'] = {
    mark = 'lsp',
    matchers = { 'matcher_head' },
    forceCompletionPattern = [['\.\w*|:\w*|->\w*']],
    dup = 'keep',
  },
  ['around'] = {
    mark = 'around',
  },
  ['file'] = {
    mark = 'file',
    isVolatile = [[v:true]],
    forceCompletionPattern = [['\S/\S*']],
  },
  ['nvim-lua'] = {
    mark = 'lua',
    forceCompletionPattern = [['\.\w*|:\w*|->\w*']],
  },
  ['zsh'] = {
    mark = 'zsh',
    isVolatile = [[v:true]],
    forceCompletionPattern = [['\S/\S*']],
  },
  ['necovim'] = {
    mark = 'vim',
  },
  ['cmdline'] = {
    mark = 'cmdline',
    forceCompletionPattern = [['\S/\S*|\.\w*']],
    dup = 'force',
  },
  ['cmdline-history'] = {
    mark = 'history',
    sorters = {},
  },
  ['input'] = {
    mark = 'input',
    forceCompletionPattern = [['\S/\S*']],
    isVolatile = [[v:true]],
    dup = 'force',
  },
  ['line'] = {
    mark = 'line',
  },
  ['buffer'] = {
    mark = 'buffer',
  }
})

-- JavaScript/TypeScript 用の file  Source の設定
vim.cmd([[
  call ddc#custom#alias('source', 'node-modules', 'file')
    call ddc#custom#patch_global({
      \ 'sourceOptions': {
      \   'node-modules': {
      \     'mark': 'NODE',
      \     'isVolatile': v:true,
      \     'minAutoCompleteLength': 10000,
      \     'forceCompletionPattern':
      \       '(?:'
      \         . '\bimport|'
      \         . '\bfrom|'
      \         . '\brequire\s*\(|'
      \         . '\bresolve\s*\(|'
      \         . '\bimport\s*\('
      \       . ')'
      \       . '\s*(?:''|"|`)[^''"`]*',
      \   },
      \ },
      \ 'sourceParams': {
      \   'node-modules': {
      \     'cwdMaxItems': 0,
      \     'bufMaxItems': 0,
      \     'followSymlinks': v:true,
      \     'projMarkers': ['node_modules'],
      \     'projFromCwdMaxItems': [],
      \     'projFromBufMaxItems': [],
      \     'beforeResolve': 'node_modules',
      \     'displayBuf': '',
      \   },
      \ }})
    call ddc#custom#patch_filetype(
      \ [
      \   'javascript',
      \   'typescript',
      \   'javascriptreact',
      \   'typescriptreact',
      \   'tsx',
      \ ], {
      \ 'sourceParams': {
      \   'node-modules': {
      \     'projFromBufMaxItems': [1000, 1000, 1000],
      \   },
      \ }})
]])

-- 挿入モードの補完の設定
vim.cmd([[
  inoremap <expr> <TAB>
        \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
        \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
        \ '<TAB>' : ddc#map#manual_complete()
  inoremap <expr><S-TAB>  pum#visible() ? '<C-p>' : '<C-h>'

  inoremap <C-x><C-f>
        \ <Cmd>call ddc#map#manual_complete(#{ sources: ['file'] })<CR>

  inoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
  inoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
  inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
  inoremap <expr> <C-e>
        \ pum#visible() ? '<Cmd>call pum#map#cancel()<CR>' : '<End>'
  inoremap <PageDown> <Cmd>call pum#map#insert_relative_page(+1)<CR>
  inoremap <PageUp>   <Cmd>call pum#map#insert_relative_page(-1)<CR>
]])

-- コマンドモードの補完の設定
vim.cmd([[
  cnoremap <expr> <Tab>
        \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
        \ exists('b:ddc_cmdline_completion') ?
        \ ddc#map#manual_complete() : nr2char(&wildcharm)
  cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>

  cnoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
  cnoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
  cnoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
  cnoremap <expr> <C-e>
        \ pum#visible() ? "ddc#map#insert_item(0, '<Cmd>call pum#map#cancel()<CR>'") : '<End>'
]])

-- 有効化
vim.fn['ddc#enable']()
vim.fn['ddc#enable_cmdline_completion']()

vim.fn['popup_preview#enable']()
vim.fn['signature_help#enable']()



vim.cmd([[

" Change source options
"call ddc#custom#patch_global('sourceOptions', {
"      \ 'around': {'mark': 'A'},
"      \ })
"call ddc#custom#patch_global('sourceParams', {
"      \ 'around': {'maxSize': 500},
"      \ })

" Customize settings on a filetype
"call ddc#custom#patch_filetype(['c', 'cpp'], 'sources', ['around', 'clangd'])
"call ddc#custom#patch_filetype(['c', 'cpp'], 'sourceOptions', {
"      \ 'clangd': {'mark': 'C'},
"      \ })
"call ddc#custom#patch_filetype('markdown', 'sourceParams', {
"      \ 'around': {'maxSize': 100},
"      \ })


"" コマンドモードで ddc を使う
"call ddc#custom#patch_global('autoCompleteEvents',
"                  \ ['InsertEnter', 'TextChangedI', 'TextChangedP', 'CmdlineChanged'])
"
"nnoremap : <Cmd>call CommandlinePre()<CR>:
"
"function! CommandlinePre() abort
"    cnoremap <Tab>   <Cmd>call pum#map#insert_relative(+1)<CR>
"    cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
"    " Overwrite sources
"    if !exists('b:prev_buffer_config')
"          let b:prev_buffer_config = ddc#custom#get_buffer()
"    endif
"    autocmd User DDCCmdlineLeave ++once call CommandlinePost()
"    autocmd InsertEnter <buffer> ++once call CommandlinePost()
"    " Enable command line completion
"    call ddc#enable_cmdline_completion()
"endfunction
"
"function! CommandlinePost() abort
"    silent! cunmap <Tab>
"    silent! cunmap <S-Tab>
"    silent! cunmap <C-n>
"    silent! cunmap <C-p>
"    silent! cunmap <C-y>
"    silent! cunmap <C-e>
"    " Restore sources
"    if exists('b:prev_buffer_config')
"        call ddc#custom#set_buffer(b:prev_buffer_config)
"        unlet b:prev_buffer_config
"    else
"        call ddc#custom#set_buffer({})
"    endif
"endfunction

]])
