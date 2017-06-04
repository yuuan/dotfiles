" ----------------------------------------
" カラースキーム
" ----------------------------------------

" 表示色設定
set t_Co=256

" テーマ
set background=dark


" Solarized {{{
	let g:solarized_termcolors=16
"	let g:solarized_termtrans=1
" }}}

" Bad Wolf {{{
	let g:badwolf_html_link_underline = 0
	let g:badwolf_css_props_highlight = 1
" }}}


" カラースキーム選択
colorscheme badwolf

" タブ文字の色
highlight SpecialKey ctermfg=236 ctermbg=16

" 検索結果の色
" highlight Search ctermfg=16 ctermbg=214

" 対応する括弧の色 (濃い赤:124, 黄緑:154, オレンジ:208)
" highlight MatchParen ctermfg=15 ctermbg=124
" highlight MatchParen ctermfg=8 ctermbg=154
highlight MatchParen ctermfg=8 ctermbg=208


" Windows で 256 色表示ができないのでひとまず Wombat にする
if has("win32") || has("win64")
	colorscheme wombat
endif

" GUIでのカラースキーマ
if has('gui_running')
	set background=light
	colorscheme solarized
endif
