" ----------------------------------------
" カラースキーマ
" ----------------------------------------

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

" Windows で 256 色表示ができないのでひとまず Wombat にする
if (has("win32") || has("win64"))
	colorscheme wombat
endif

"タブの色
highlight SpecialKey ctermfg=236 ctermbg=16

"GUIでのカラースキーマ
if has('gui_running')
	set background=light
	colorscheme solarized
endif
