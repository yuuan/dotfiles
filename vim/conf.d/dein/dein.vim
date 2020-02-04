" ファイルやディレクトリの場所を定義
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let s:toml = expand('<sfile>:p:h') . '/dein.toml'

" dein.vim のインストール
if !isdirectory(s:dein_repo_dir)
	call system('\git clone --depth 1 https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
execute 'set runtimepath^=' . s:dein_repo_dir

" dein.vim の設定 {{{
	" Git clone で shallow clone を使う
	let g:dein#types#git#clone_depth = 1
" }}}

" プラグイン読み込み
if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)

	call dein#load_toml(s:toml)

	call dein#end()
	call dein#save_state()
endif

" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
	call dein#install()
endif
