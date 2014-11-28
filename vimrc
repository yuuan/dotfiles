" 基本設定 {{{
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
	set list
	set listchars=tab:›\ ,trail:~
	set textwidth=0
	set timeout

	" コマンドの次の文字の入力待ち時間
	set timeoutlen=1000
	" キーコード待ちの時間
	set ttimeoutlen=75

	" Windows では CP932 を使う
	if (has("win32") || has("win64"))
		set termencoding=cp932
	endif
" }}}


" キャッシュファイル {{{
	set backup
	set backupdir=$HOME/.vim/backup

	set swapfile
	set directory=$HOME/.vim/swp

	if has('persistent_undo')
		set undofile
		set undodir=$HOME/.vim/undo
	endif
" }}}


" 特殊キー登録 {{{
	" Ctrl + カーソルキー
	set <S-Up>=[A
	set <S-Down>=[B
	set <C-Right>=[C
	set <C-Left>=[D

	" Ctrl + スペースキー
	map <Nul> <C-Space>
	map! <Nul> <C-Space>
" }}}


" NeoBundle.vim {{{
	if has('vim_starting')
		set nocompatible " Be iMproved

		" Required:
		set runtimepath+=~/.vim/bundle/neobundle.vim/
	endif

	" Required:
	call neobundle#begin(expand('~/.vim/bundle/'))

	" Let NeoBundle manage NeoBundle
	" Required:
	NeoBundleFetch 'Shougo/neobundle.vim'

	call neobundle#end()

	" Required:
	filetype plugin indent on

	" If there are uninstalled bundles found on startup,
	" this will conveniently prompt you to install them.
	NeoBundleCheck


	"NeoBundle
	NeoBundle 'Shougo/neobundle.vim'

	"Unite
	NeoBundle 'Shougo/unite.vim.git'
	NeoBundle 'ujihisa/unite-colorscheme'
	NeoBundle 'kmnk/vim-unite-giti.git'
	NeoBundle 'Shougo/unite-session'

	"Colorscheme
	NeoBundle 'altercation/vim-colors-solarized'
	NeoBundle 'w0ng/vim-hybrid'
	NeoBundle 'sjl/badwolf'
	NeoBundle 'tomasr/molokai'
	NeoBundle 'vim-scripts/Wombat'
	NeoBundle 'nanotech/jellybeans.vim'

	"Lightline
	NeoBundle 'itchyny/lightline.vim'
	NeoBundle 'cocopon/lightline-hybrid.vim'

	"Syntacs
	NeoBundle 'scrooloose/syntastic'
	NeoBundle 'hail2u/vim-css3-syntax'
	NeoBundle 'pangloss/vim-javascript'
	NeoBundle 'jiangmiao/simple-javascript-indenter'
	NeoBundle 'Glench/Vim-Jinja2-Syntax'
	NeoBundle 'vim-perl/vim-perl'

	"Git
	NeoBundle 'tpope/vim-fugitive'
	NeoBundle 'gregsexton/gitv.git'

	NeoBundle 'vim-scripts/sudo.vim.git'
	NeoBundle 'Shougo/vimfiler.git'
	NeoBundle 'Shougo/neocomplete.git'

	NeoBundle 'kana/vim-smartinput.git'
	NeoBundle 'AndrewRadev/switch.vim'
	NeoBundle 'tyru/caw.vim.git'

	NeoBundle 'vim-jp/vimdoc-ja'

	NeoBundle 'Shougo/vimproc', {
		\ 'build' : {
			\ 'windows' : 'make -f make_mingw32.mak',
			\ 'cygwin'  : 'make -f make_cygwin.mak',
			\ 'mac'     : 'make -f make_mac.mak',
			\ 'unix'    : 'make -f make_unix.mak',
		\ },
	\ }
" }}}


" FileTypes {{{
	"php-template
	autocmd BufNewFile,BufRead *.phtml set filetype=php
	autocmd BufNewFile,BufRead *.ctp set filetype=php

	"jinja
	autocmd BufNewFile,BufRead *.tpl set filetype=jinja
	autocmd BufNewFile,BufRead *.twig set filetype=jinja
	autocmd BufNewFile,BufRead *.volt set filetype=jinja

	"TT2 syntax
	autocmd BufNewFile,BufRead *.tmpl set filetype=tt2html

	"PHPで<>を対応する括弧として認識させない
	autocmd FileType php set matchpairs-=<:>
" }}}


" カラースキーマ {{{
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
	highlight SpecialKey ctermfg=236 ctermbg=16

	"GUIでのカラースキーマ
	if has('gui_running')
		set background=light
		colorscheme solarized
	endif
" }}}


" syntastic {{{
	let g:syntastic_perl_lib_path = 'lib'
" }}}


" neocomplete {{{
	let g:neocomplete#enable_at_startup = 1
	let g:neocomplete#disable_auto_complete = 0
	let g:neocomplete#min_syntax_length = 3
	let g:neocomplete#enable_auto_select = 0
	let g:neocomplete#enable_smart_case = 0
	let g:neocomplete#enable_camel_case_completion = 0
	let g:neocomplete#enable_fuzzy_completion = 0

	"上下キーで開かないように
	inoremap <expr><Up> neocomplete#smart_close_popup() . "\<Up>"
	inoremap <expr><Down> neocomplete#smart_close_popup() . "\<Down>"

	"改行しようとして候補を入力されないように
	inoremap <expr><CR> pumvisible() ? neocomplete#smart_close_popup() : "\<CR>"

	"Ctrl + Space で表示
	inoremap <expr><C-Space> pumvisible() ? "\<C-Y>" : "\<C-Space>"

	"Ctrl + 上下キーで候補を移動
	inoremap <expr><S-Up> pumvisible() ? "\<C-P>" : "\<Up>"
	inoremap <expr><S-Down> pumvisible() ? "\<C-N>" : "\<Down>"

	"Enable omni completion.
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" }}}


" VimFiler {{{
	"vimデフォルトのエクスプローラをvimfilerで置き換える
	"let g:vimfiler_as_default_explorer = 1
	"セーフモードを無効にした状態で起動する
	let g:vimfiler_safe_mode_by_default = 0
	"新しいタブで編集する
	let g:vimfiler_edit_action = 'tabopen'
	"現在開いているバッファのディレクトリを開く
	"nnoremap <silent> <Leader>fe :<C-u>VimFilerBufferDir -quit<CR>
	"現在開いているバッファをIDE風に開く
	"nnoremap <silent> <Leader>fi :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>
	"nnoremap <silent> <C-f> :<C-u>VimFilerBufferDir -split -simple -winwidth=35<CR>

	"↓カーソルキーが効かなくなったのでコメントアウト
	"デフォルトのキーマッピングを変更
	" augroup vimrc
	" 	autocmd FileType vimfiler call s:vimfiler_my_settings()
	" augroup END
	" function! s:vimfiler_my_settings()
	" 	nmap <buffer> q <Plug>(vimfiler_exit)
	" 	nmap <buffer> Q <Plug>(vimfiler_hide)
	" 	nmap <buffer> <Tab> <Plug>(vimfiler_choose_action)
	" 	nmap <buffer> <ESC> <Plug>(vimfiler_switch_to_other_window)
	" endfunction
" }}}


" Unite {{{
	nnoremap <silent> <C-f> :<C-u>UniteWithBufferDir -buffer-name=files file file/new directory/new<CR>
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

	"ファイルを開くとき新しいタブで開く
	call unite#custom#default_action('file', 'tabopen')
" }}}


" Ag for Unite {{{
	" unite grep に ag(The Silver Searcher) を使う
	if executable('ag')
		let g:unite_source_grep_command = 'ag'
		let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
		let g:unite_source_grep_recursive_opt = ''
	endif
" }}}


" Giti {{{
	nnoremap [git] <Nop>
	nmap <C-g> [git]

	nnoremap <silent> [git]<C-g> :<C-u>Unite giti/status<CR>
	nnoremap <silent> [git]b :<C-u>Unite giti/branch_all<CR>
"	nnoremap <silent> [git]c :<C-u>Unite giti/config<CR>
	nnoremap <silent> [git]c :<C-u>Gcommit<CR>
	nnoremap <silent> [git]l :<C-u>Unite giti/log<CR>
	nnoremap <silent> [git]r :<C-u>Unite giti/remote<CR>
	nnoremap <silent> [git]s :<C-u>Unite giti/status<CR>
	nnoremap <silent> [git]<C-w> :<C-u>Gwrite<CR>
" }}}


" switch.vim {{{
	nnoremap - :Switch<cr>
" }}}


" caw.vim {{{
	vmap # <Plug>(caw:i:toggle)
" }}}


" lightline {{{
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
" }}}


" マルチバイト {{{
	" UTF-8の□や○でカーソル位置がずれないようにする
	if exists("&ambiwidth")
		set ambiwidth=double
	endif
"}}}


" カーソル行の強調表示 {{{
	" カーソル行を強調表示しない
	set nocursorline

	" 挿入モードの時のみ、カーソル行をハイライトする
	autocmd InsertEnter,InsertLeave * set cursorline!
" }}}


" 画面操作 {{{
	"Ctrl + 左右キーでタブを切り替え
	nnoremap <C-Right> :<C-u>tabn<CR>
	nnoremap <C-Left> :<C-u>tabp<CR>
	inoremap <C-Right> <ESC>:tabn<CR>
	inoremap <C-Left> <ESC>:tabp<CR>
	cnoremap <C-Right> <C-u>tabn
	cnoremap <C-Left> <C-u>tabp
	inoremap <expr><C-Right> pumvisible() ? neocomplete#smart_close_popup() : "\<ESC>:tabn\<CR>"
	inoremap <expr><C-Left> pumvisible() ? neocomplete#smart_close_popup() : "\<ESC>:tabp\<CR>"

	"Shift + 上下キーでスクロール
	noremap <S-Up> <C-Y>
	noremap <S-Down> <C-E>

	"Alt + 上下キーでスクロール
	map <M-Up> <C-Y>
	map <M-Down> <C-E>

	"PageUp/Downの幅を半分に
	map <PageUp> <C-U>
	map <PageDown> <C-D>
" }}}


" ファンクションキー {{{
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
" }}}


" ファイル {{{
	" ファイルを開いたときカーソル位置を復元
	autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\""

	"gf で相対パスなどでも開けるようにする
	autocmd FileType html setlocal includeexpr=substitute(v:fname,'^\\/','','') | setlocal path+=;/
	autocmd FileType php setlocal includeexpr=substitute(substitute(v:fname,'_','/','g'),'$','.php','')
		\ | setlocal path+=;vender/;src/;lib/ | setlocal suffixesadd=.php,.inc

	" .tファイルをPerlファイルとして認識
	autocmd BufNewFile,BufRead *.t set filetype=perl
" }}}


" emacs 的な文字列操作 {{{
	" HomeとEnd
	map <C-A> <Home>
	map <C-E> <End>
	" Ctrl + k で行末まで削除
	inoremap <expr> <C-k> "\<C-g>u".(col('.') == col('$') ? '<C-o>gJ' : '<C-o>D')
	cnoremap <C-k> <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>
" }}}


" 検索後にESCキーでハイライトを消す
"nmap <ESC> :nohlsearch<CR>

" コマンドラインモードでCtrl + Pで貼り付け
cnoremap <C-P> <C-R>"

" 単語を選択
nnoremap + viw

" インデントした後も範囲選択を残す
vnoremap < <gv
vnoremap > >gv


" 環境依存設定の読み込み
if filereadable(expand('~/.vimrc-local'))
	source ~/.vimrc-local
endif

