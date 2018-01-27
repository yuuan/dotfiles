" ----------------------------------------
" Vim 基本設定
" ----------------------------------------

" 行番号を表示
set number

" タブ文字が対応するスペースの数
set tabstop=4
set softtabstop=4

" インデントの幅
set shiftwidth=4

" 一行あたりの最大文字数
set textwidth=0

" インデントにタブ文字を使う
set noexpandtab

" 開く時の文字コード
set fileencodings=utf-8,ucs-bom,euc-jp,sjis,iso-2022-jp

" タブを使えるようにする
set tabpagemax=30
set showtabline=2

" BSキーで消せる特殊文字
set backspace=indent,eol,start

" タブ文字等を文字で表す
set list

" タブ文字や末尾のスペースを文字で表示
set listchars=tab:›\ ,trail:~

" マウスを使えるようにする
set mouse=a
if ! has('nvim')
	set ttymouse=xterm2
endif

" 高速ターミナル接続
set ttyfast

" 次のコマンドが入力されたかった時にタイムアウトする
set timeout

" コマンドの次の文字の入力待ち時間
set timeoutlen=1000

" 端末のキーコードについてタイムアウトする
set ttimeout

" キーコード待ちの時間
set ttimeoutlen=75

" 放棄されたバッファを隠れ状態にする
"set hidden

" 括弧を入力した時に一瞬だけカーソルを対応する括弧に移動
set showmatch

" 検索結果を強調表示
set hlsearch

" コマンド履歴を保存する件数
set history=500

" カーソルの位置を表示
set ruler

" 入力したコマンドを最下行に表示
set showcmd

" ステータスラインを常に表示
set laststatus=2

" ステータスラインに表示する内容
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l\,%c%V%8P

" コマンドラインで補完を使う
set wildmenu

" コマンドラインで補完時に共通する部分まで自動入力
set wildmode=longest,full

" Windows では CP932 を使う
if (has("win32") || has("win64"))
	set termencoding=cp932
endif
