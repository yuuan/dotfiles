" ----------------------------------------
" Vim 基本設定
" ----------------------------------------

" シンタックスハイライトを有効にする
syntax enable

" 行番号を表示
set number

" タブ文字が対応するスペースの数
set tabstop=4
set softtabstop=4

" インデントの幅
set shiftwidth=4

" インデントにタブ文字を使う
set noexpandtab

" 開く時の文字コード
set fileencodings=utf-8,ucs-bom,euc-jp,sjis,iso-2022-jp

" タブを使えるようにする
set tabpagemax=30
set showtabline=2

" BSキーで消せる特殊文字
set backspace=indent,eol,start

" タブ文字や末尾のスペースを文字で表示
set listchars=tab:›\ ,trail:~

" マウスを使えるようにする
set mouse=a
set ttymouse=xterm2

" コマンドの次の文字の入力待ち時間
set timeoutlen=1000

" キーコード待ちの時間
set ttimeoutlen=75

set hidden
set showmatch
set hlsearch
set history=100
set ruler
set showcmd
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l\,%c%V%8P
set wildmenu
set ttyfast
set list
set textwidth=0
set timeout

" Windows では CP932 を使う
if (has("win32") || has("win64"))
	set termencoding=cp932
endif
