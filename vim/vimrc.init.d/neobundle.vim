" ----------------------------------------
" NeoBundle
" ----------------------------------------

if has('vim_starting')
	if &compatible
		set nocompatible " Be iMproved
	endif

	" Required:
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

"Unite
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'Shougo/neomru.vim.git'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'kmnk/vim-unite-giti.git'
NeoBundle 'Shougo/unite-session'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/neoyank.vim'

"gf
NeoBundle 'kana/vim-gf-user'
NeoBundle 'violetyk/vim-phpclass'

"Colorscheme
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'sjl/badwolf'
NeoBundle 'tomasr/molokai'
NeoBundle 'sickill/vim-monokai'
NeoBundle 'vim-scripts/Wombat'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'morhetz/gruvbox'

"Lightline
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'cocopon/lightline-hybrid.vim'

"Syntax
NeoBundle 'scrooloose/syntastic'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'jiangmiao/simple-javascript-indenter'
NeoBundle 'vim-perl/vim-perl'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'xsbeats/vim-blade'
NeoBundle 'evidens/vim-twig'
NeoBundle 'elzr/vim-json'
NeoBundle 'yoppi/fluentd.vim'

"Debug
"NeoBundle 'joonty/vdebug'

"vim-ref
NeoBundle 'thinca/vim-ref'

"Git
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv.git'

"Display
NeoBundle 'Yggdroot/indentLine'

"Edit
NeoBundle 'tpope/vim-surround'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'kana/vim-smartinput.git'
NeoBundle 'AndrewRadev/switch.vim'
NeoBundle 'tyru/caw.vim.git'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'osyo-manga/vim-textobj-multiblock'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'junegunn/vim-emoji'

"Cursor
NeoBundle 'Lokaltog/vim-easymotion'

NeoBundle 'vim-scripts/sudo.vim.git'
NeoBundle 'Shougo/vimfiler.git'
NeoBundle 'lambdalisue/vim-unified-diff'

"NeoComplete
if has('lua')
	NeoBundle 'Shougo/neocomplete.git'
endif

" NeoComplete Extensions
" NeoBundle 'm2mdas/phpcomplete-extended'
" NeoBundle 'm2mdas/phpcomplete-extended-laravel'

NeoBundle 'vim-jp/vimdoc-ja'

if (! (has("win32") || has("win64")) )
	NeoBundle 'Shougo/vimproc', {
		\ 'build' : {
			\ 'mac'     : 'make -f make_mac.mak',
			\ 'unix'    : 'make -f make_unix.mak',
		\ },
	\ }
endif

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
