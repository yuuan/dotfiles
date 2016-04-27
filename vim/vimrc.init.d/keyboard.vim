" ----------------------------------------
" 特殊キー登録
" ----------------------------------------

if ! exists("g:enable_maps_for_putty_default")
	let g:enable_maps_for_putty_default = 0
endif

let s:maps = []

" デフォルト設定の PuTTY に対応すると副作用が出るので避ける
if g:enable_maps_for_putty_default

	" Ctrl + Cursor keys (PuTTY default)
	let s:maps += [
		\   [ "\e[C", '<C-Right>' ],
		\   [ "\e[D", '<C-Left>' ],
	\ ]

	" Shift + Cursor keys (PuTTY default)
	let s:maps += [
		\   [ "\e[A", '<S-Up>' ],
		\   [ "\e[B", '<S-Down>' ],
	\ ]

endif

" Ctrl + Cursor keys (Xterm)
let s:maps += [
	\   [ "\e[1;5A", '<C-Up>' ],
	\   [ "\e[1;5B", '<C-Down>' ],
	\   [ "\e[1;5C", '<C-Right>' ],
	\   [ "\e[1;5D", '<C-Left>' ],
\ ]

" Shift + Cursor keys (Xterm)
let s:maps += [
	\   [ "\e[1;2A", '<S-Up>' ],
	\   [ "\e[1;2B", '<S-Down>' ],
	\   [ "\e[1;2C", '<S-Right>' ],
	\   [ "\e[1;2D", '<S-Left>' ],
\ ]

" Ctrl + Function keys
let s:maps += [
	\   [ "\e[1;5P",  '<C-F1>' ],
	\   [ "\e[1;5Q",  '<C-F2>' ],
	\   [ "\e[1;5R",  '<C-F3>' ],
	\   [ "\e[1;5S",  '<C-F4>' ],
	\   [ "\e[15;5~", '<C-F5>' ],
	\   [ "\e[17;5~", '<C-F6>' ],
	\   [ "\e[18;5~", '<C-F7>' ],
	\   [ "\e[19;5~", '<C-F8>' ],
	\   [ "\e[20;5~", '<C-F9>' ],
	\   [ "\e[21;5~", '<C-F10>' ],
	\   [ "\e[23;5~", '<C-F11>' ],
	\   [ "\e[24;5~", '<C-F12>' ],
\ ]

" Shift + Function keys
let s:maps += [
	\   [ "\e[1;2P",  '<S-F1>' ],
	\   [ "\e[1;2Q",  '<S-F2>' ],
	\   [ "\e[1;2R",  '<S-F3>' ],
	\   [ "\e[1;2S",  '<S-F4>' ],
	\   [ "\e[15;2~", '<S-F5>' ],
	\   [ "\e[17;2~", '<S-F6>' ],
	\   [ "\e[18;2~", '<S-F7>' ],
	\   [ "\e[19;2~", '<S-F8>' ],
	\   [ "\e[20;2~", '<S-F9>' ],
	\   [ "\e[21;2~", '<S-F10>' ],
	\   [ "\e[23;2~", '<S-F11>' ],
	\   [ "\e[24;2~", '<S-F12>' ],
\ ]

" Number pad
let s:maps += [
	\   [ "\eOw", '<kHome>' ],
	\   [ "\eOq", '<kEnd>' ],
	\   [ "\eOy", '<kPageUp>' ],
	\   [ "\eOs", '<kPageDown>' ],
	\   [ "\eOl", '<kPlus>' ],
	\   [ "\eOS", '<kMinus>' ],
	\   [ "\eOR", '<kMultiply>' ],
	\   [ "\eOQ", '<kDivide>' ],
	\   [ "\eOM", '<kEnter>' ],
	\   [ "\eOn", '<kPoint>' ],
	\   [ "\eOp", '<k0>' ],
	\   [ "\eOq", '<k1>' ],
	\   [ "\eOr", '<k2>' ],
	\   [ "\eOs", '<k3>' ],
	\   [ "\eOt", '<k4>' ],
	\   [ "\eOu", '<k5>' ],
	\   [ "\eOv", '<k6>' ],
	\   [ "\eOw", '<k7>' ],
	\   [ "\eOx", '<k8>' ],
	\   [ "\eOy", '<k9>' ],
\ ]

" Ctrl + スペースキー
let s:maps += [
	\   [ '<Nul>', '<C-Space>' ],
\ ]

for [s:str, s:code] in s:maps
	exe 'map '.s:str.' '.s:code
	exe 'map! '.s:str.' '.s:code
endfor
