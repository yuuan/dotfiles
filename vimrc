syntax enable
set number
set ts=4 sts=4 sw=4 noet

set encoding=utf-8
set fileencodings=utf-8,ucs-bom,euc-jp,sjis,iso-2022-jp

set hid
set showmatch
set hlsearch
set history=100
set ruler
set showcmd
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l\,%c%V%8P
set bs=indent,eol,start
set wildmenu
set mouse=a
set ttymouse=xterm2
set tabpagemax=30
set showtabline=2
set ttyfast
set timeoutlen=50
set list
set listchars=tab:▸\ ,trail:~
set textwidth=0

" カーソル行を強調表示しない
set nocursorline
" 挿入モードの時のみ、カーソル行をハイライトする
autocmd InsertEnter,InsertLeave * set cursorline!

set backupdir=$HOME/.vim/backup
set backup

set directory=$HOME/.vim/swp
set swapfile

if has('persistent_undo')
	set undodir=$HOME/.vim/undo
	set undofile
endif

" ファイルを開いたときカーソル位置を復元
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\""

"Ctrl + Arrow Key
map [A <C-Up>
map [B <C-Down>
map [C <C-Right>
map [D <C-Left>
map! [A <C-Up>
map! [B <C-Down>
map! [C <C-Right>
map! [D <C-Left>

map <Nul> <C-Space>
map! <Nul> <C-Space>

"F2 F3でバッファ切り替え F4でバッファを閉じる
map <F2> <ESC>:bp<CR>
map <F3> <ESC>:bn<CR>
map <F4> <ESC>:bw<CR>

"F5 F6で位置を記録 F7 F8で記録した位置に戻る
map <F5> <ESC>ma
map <F6> <ESC>mb
map <F7> <ESC>`a
map <F8> <ESC>`b

"F9 F10でタブを切り替え
map <F9> <ESC>:tabp<CR>
map <F10> <ESC>:tabn<CR>

"Alt + 上下キーでスクロール
map OA <C-Y>
map OB <C-E>
map [A <C-Y>
map [B <C-E>

"HomeとEnd
map <C-A> <Home>
map <C-E> <End>

"検索後にESCキー連打でハイライトを消す
nnoremap <ESC><ESC> :nohlsearch<CR>

"コマンドラインモードでCtrl + Pで貼り付け
cnoremap <C-P> <C-R>"

"単語を選択
nnoremap + bve

"PageUp/Downの幅を半分に
map <PageUp> <C-U>
map <PageDown> <C-D>

vmap # <Plug>(caw:i:toggle)

"インデントした後も範囲選択を残す
vnoremap < <gv
vnoremap > >gv

"gf で相対パスなどでも開けるようにする
autocmd FileType html setlocal includeexpr=substitute(v:fname,'^\\/','','') | setlocal path+=;/
autocmd FileType php setlocal includeexpr=substitute(substitute(v:fname,'_','/','g'),'$','.php','')
	\ | setlocal path+=;vender/;src/;lib/ | setlocal suffixesadd=.php,.inc

" .tファイルをPerlファイルとして認識
autocmd BufNewFile,BufRead *.t set filetype=perl

"PHPで<>を対応する括弧として認識させない
autocmd FileType php set matchpairs-=<:>

"UTF-8の□や○でカーソル位置がずれないようにする
if exists("&ambiwidth")
	set ambiwidth=double
endif

"NeoBundle.vim
if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim
	call neobundle#rc(expand('~/.vim/bundle/'))
	filetype off
	filetype plugin on
	filetype indent on
endif

NeoBundle 'vim-scripts/sudo.vim.git'
NeoBundle 'Shougo/vimfiler.git'
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplete.git'
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'AndrewRadev/switch.vim'
NeoBundle 'tyru/caw.vim.git'

"Colorscheme
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'sjl/badwolf'
NeoBundle 'tomasr/molokai'
NeoBundle 'vim-scripts/Wombat'
NeoBundle 'nanotech/jellybeans.vim'

"Syntacs
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'othree/html5.vim'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'Glench/Vim-Jinja2-Syntax'
NeoBundle 'vim-perl/vim-perl'

NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv.git'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'cocopon/lightline-hybrid.vim'

NeoBundle 'Shougo/vimproc', {
	\ 'build' : {
		\ 'windows' : 'make -f make_mingw32.mak',
		\ 'cygwin'  : 'make -f make_cygwin.mak',
		\ 'mac'     : 'make -f make_mac.mak',
		\ 'unix'    : 'make -f make_unix.mak',
	\ },
\ }

"php-template
autocmd BufNewFile,BufRead *.phtml set filetype=php

"jinja
autocmd BufNewFile,BufRead *.tpl set filetype=jinja
autocmd BufNewFile,BufRead *.twig set filetype=jinja
autocmd BufNewFile,BufRead *.volt set filetype=jinja

"TT2 syntax
autocmd BufNewFile,BufRead *.tmpl set filetype=tt2html

"syntastic
let g:syntastic_perl_lib_path = 'lib'


"neocomplete {{{

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#disable_auto_complete = 0
let g:neocomplete#min_syntax_length = 3
let g:neocomplete#enable_auto_select = 0
let g:neocomplete#enable_smart_case = 0
let g:neocomplete#enable_camel_case_completion = 0
inoremap <expr><Up> neocomplete#smart_close_popup() . "\<Up>"
inoremap <expr><Down> neocomplete#smart_close_popup() . "\<Down>"
inoremap <expr><CR> pumvisible() ? neocomplete#smart_close_popup() : "\<CR>"
inoremap <expr><C-Space> pumvisible() ? "\<C-Y>" : "\<C-Space>"

"HTMLでの曖昧検索を無効（たぶん）
autocmd FileType html,jinja,tt2html let g:neocomplete#enable_fuzzy_completion=0

"Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

"}}}


"VimFiler {{{

"vimデフォルトのエクスプローラをvimfilerで置き換える
let g:vimfiler_as_default_explorer = 1
"セーフモードを無効にした状態で起動する
let g:vimfiler_safe_mode_by_default = 0
"新しいタブで編集する
let g:vimfiler_edit_action = 'tabopen'
"現在開いているバッファのディレクトリを開く
"nnoremap <silent> <Leader>fe :<C-u>VimFilerBufferDir -quit<CR>
"現在開いているバッファをIDE風に開く
"nnoremap <silent> <Leader>fi :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>
nnoremap <silent> <C-f> :<C-u>VimFilerBufferDir -split -simple -winwidth=35<CR>

"デフォルトのキーマッピングを変更
augroup vimrc
	autocmd FileType vimfiler call s:vimfiler_my_settings()
augroup END
function! s:vimfiler_my_settings()
	nmap <buffer> q <Plug>(vimfiler_exit)
	nmap <buffer> Q <Plug>(vimfiler_hide)
	nmap <buffer> <Tab> <Plug>(vimfiler_choose_action)
	nmap <buffer> <ESC> <Plug>(vimfiler_switch_to_other_window)
endfunction

"}}}


"Unite {{{

nnoremap <silent> <C-f> :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> <C-h> :<C-u>Unite buffer file_mru<CR>
nnoremap <silent> <C-b> :<C-u>Unite buffer<CR>
nnoremap <silent> <C-Space> :<C-u>Unite tab<CR>
"inoremap <silent> <C-Space> <ESC>:<C-u>Unite tab<CR>

let g:unite_enable_start_insert = 1

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
	imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
	imap <buffer> <C-h> <ESC><Plug>(unite_quick_help)
	nmap <buffer> <F4> <Plug>(unite_exit)
	nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction

call unite#custom#default_action('file', 'tabopen')

"}}}


"Ctrl + 左右キーでタブを切り替え
nnoremap <C-Right> :tabn<CR>
nnoremap <C-Left> :tabp<CR>
inoremap <C-Right> <ESC>:tabn<CR>
inoremap <C-Left> <ESC>:tabp<CR>
cnoremap <C-Right> tabn
cnoremap <C-Left> tabp
inoremap <expr><C-Right> pumvisible() ? neocomplete#smart_close_popup() : "\<ESC>:tabn\<CR>"
inoremap <expr><C-Left> pumvisible() ? neocomplete#smart_close_popup() : "\<ESC>:tabp\<CR>"

"Ctrl + 上下キーでスクロール
noremap <C-Up> <C-Y>
noremap <C-Down> <C-E>

"Ctrl + 上下キーで候補を移動
inoremap <expr><C-Up> pumvisible() ? "\<C-P>" : "\<Up>"
inoremap <expr><C-Down> pumvisible() ? "\<C-N>" : "\<Down>"

"switch.vim
nnoremap - :Switch<cr>


"カラースキーマ {{{

"表示色設定
set t_Co=256

"solarized
set background=dark
let g:solarized_termcolors=16
"let g:solarized_termtrans=1

"Bad Wolf
let g:badwolf_html_link_underline = 0
let g:badwolf_css_props_highlight = 1

"カラースキーム選択
colorscheme badwolf

"タブの色
highlight SpecialKey ctermfg=8 ctermbg=0

"GUIでのカラースキーマ
if has('gui_running')
	set background=light
	colorscheme solarized
endif

"}}}


"lightline {{{

let g:lightline = {
	\ 'colorscheme': 'powerline',
	\ 'mode_map': { 'c': 'NORMAL' },
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
	\   'right': [
	\     [ 'lineinfo' ],
	\     [ 'percent' ],
	\     [ 'charvaluehex', 'fileformat', 'fileencoding', 'filetype']
	\   ]
	\ },
	\ 'component_function': {
	\   'modified': 'MyModified',
	\   'readonly': 'MyReadonly',
	\   'fugitive': 'MyFugitive',
	\   'filename': 'MyFilename',
	\   'fileformat': 'MyFileformat',
	\   'filetype': 'MyFiletype',
	\   'fileencoding': 'MyFileencoding',
	\   'mode': 'MyMode',
	\ },
	\ 'separator': { 'left': "\ue0b0", 'right': "" },
	\ 'subseparator': { 'left': "\u00bb", 'right': "\u22ee" },
	\ 'tabline_separator': { 'left': '', 'right': '' },
	\ 'tabline_subseparator': { 'left': '', 'right': '' }
	\ }

function! MyModified()
	return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
	return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
endfunction

function! MyFilename()
	return ('' != MyReadonly() ? MyReadonly() . "\ue0a2" : '') .
		\ (&ft == 'vimfiler' ? vimfiler#get_status_string() : 
		\  &ft == 'unite' ? unite#get_status_string() : 
		\  &ft == 'vimshell' ? vimshell#get_status_string() :
		\ '' != expand('%:f') ? expand('%:f') : '[No Name]') .
		\ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
	if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
		let _ = fugitive#head()
		return strlen(_) ? "\ue0a0 "._ : ''
	endif
	return ''
endfunction

function! MyFileformat()
	return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
	return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
	return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
	return &ft == 'unite' ? 'Unite' : 
				\ &ft == 'vimfiler' ? 'VimFiler' : 
				\ &ft == 'vimshell' ? 'VimShell' : 
				\ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

"}}}


if filereadable(expand('~/.vimrc-local'))
	source ~/.vimrc-local
endif

