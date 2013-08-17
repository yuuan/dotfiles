syntax enable
set number
set ts=4 sts=4 sw=4 noet

set encoding=utf-8
set fileencodings=ucs-bom,euc-jp,sjis,iso-2022-jp

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

set backup
set backupdir=$HOME/.vim/backup
set swapfile
set directory=$HOME/.vim/swp

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

"検索後にESCキー連打でハイライトを消す
nnoremap <ESC><ESC> :nohlsearch<CR>

"コマンドラインモードでCtrl + Pで貼り付け
cnoremap <C-P> <C-R>"

"単語を選択
nnoremap + bve

"PageUp/Downの幅を半分に
map <PageUp> <C-U>
map <PageDown> <C-D>

"インデントした後も範囲選択を残す
vnoremap < <gv
vnoremap > >gv

"gf で相対パスなどでも開けるようにする
autocmd FileType html setlocal includeexpr=substitute(v:fname,'^\\/','','') | setlocal path+=;/

" .tファイルをPerlファイルとして認識
au BufNewFile,BufRead *.t set filetype=perl

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
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplcache.git'
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'taichouchou2/html5.vim'
NeoBundle 'taichouchou2/vim-javascript'
NeoBundle 'Jinja'
NeoBundle 'ocim/htmljinja.vim'
NeoBundle 'vim-perl/vim-perl'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv.git'

"powerline
let g:Powerline_symbols = 'fancy'

"jinja
autocmd BufNewFile,BufRead *.tpl set filetype=htmljinja

"TT2 syntax
autocmd BufNewFile,BufRead *.tmpl set filetype=tt2html

"syntastic
let g:syntastic_perl_lib_path = 'lib'

"neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_disable_auto_complete = 0
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_min_syntax_length = 3
inoremap <expr><Up> neocomplcache#smart_close_popup() . "\<Up>"
inoremap <expr><Down> neocomplcache#smart_close_popup() . "\<Down>"
inoremap <expr><CR> pumvisible() ? neocomplcache#smart_close_popup() : "\<CR>"
inoremap <expr><C-Space> pumvisible() ? "\<C-Y>" : "\<C-Space>"

"Unite
nnoremap <silent> <C-f> :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
inoremap <silent> <C-f> <ESC>:<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> <C-r> :<C-u>Unite buffer file_mru<CR>
inoremap <silent> <C-r> <ESC>:<C-u>Unite buffer file_mru<CR>
nnoremap <silent> <C-b> :<C-u>Unite buffer<CR>
inoremap <silent> <C-b> <ESC>:<C-u>Unite buffer<CR>
nnoremap <silent> <C-Space> :<C-u>Unite tab<CR>
"inoremap <silent> <C-Space> <ESC>:<C-u>Unite tab<CR>

let g:unite_enable_start_insert = 1

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
	imap <buffer> <C-w> <Plug>(unite_delete_backward_path
	imap <buffer> <ESC> <Plug>(unite_exit)
endfunction

"Ctrl + 左右キーでタブを切り替え
map <C-Right> <ESC>:tabn<CR>
map <C-Left> <ESC>:tabp<CR>
cnoremap <C-Right> tabn
cnoremap <C-Left> tabp
inoremap <expr><C-Right> pumvisible() ? neocomplcache#smart_close_popup() : "\<ESC>:tabn\<CR>"
inoremap <expr><C-Left> pumvisible() ? neocomplcache#smart_close_popup() : "\<ESC>:tabp\<CR>"

"Ctrl + 上下キーでスクロール
noremap <C-Up> <C-Y>
noremap <C-Down> <C-E>

"Ctrl + 上下キーで候補を移動
inoremap <expr><C-Up> pumvisible() ? "\<C-P>" : "\<Up>"
inoremap <expr><C-Down> pumvisible() ? "\<C-N>" : "\<Down>"

"ターミナルタイプによるカラー設定
if &term =~ "xterm-256color" || &term =~ "screen-256color"
	set t_Co=256
else
	set t_Co=16
endif

"solarized
set background=dark
let g:solarized_termcolors=16
"let g:solarized_termtrans=1
colorscheme solarized

