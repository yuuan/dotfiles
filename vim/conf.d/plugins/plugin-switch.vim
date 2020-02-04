" ----------------------------------------
" switch.vim
" ----------------------------------------

" キーバインドを設定
nnoremap - :Switch<cr>

" スイッチする単語
let g:switch_custom_definitions = [
	\     [ 'private', 'protected', 'public' ],
	\     [ 'self::', 'static::' ],
	\     [ 'endif', 'endunless' ],
	\     [ 'if', 'unless' ],
	\     [ 'while', 'until', 'do' ],
	\     [ "'ASC'", "'DESC'" ],
	\     [ "'asc'", "'desc'" ],
	\     [ 'yes', 'no' ],
	\     [ 'on', 'off' ],
	\     [ 'enable', 'disable' ],
	\     [ 'Enable', 'Disable' ],
	\     [ 'allow', 'deny' ],
	\     [ 'required', 'sometimes', 'optional' ],
	\     [ 'var', 'let', 'const' ],
	\     [ 'my', 'our', 'local' ],
	\     {
	\         '\>->\(\w\{1,}\)\>': '[''\1'']',
	\         '\[''\(\w\{1,}\)''\]': '->\1',
	\     },
	\ ]
