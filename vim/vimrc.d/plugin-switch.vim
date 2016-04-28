" ----------------------------------------
" switch.vim
" ----------------------------------------

nnoremap - :Switch<cr>

let g:switch_custom_definitions = [
	\     [ 'private', 'protected', 'public' ],
	\     [ 'self::', 'static::' ],
	\     [ '@if', '@unless' ],
	\     [ '@endif', '@endunless' ],
	\     [ 'if', 'unless' ],
	\     [ 'while', 'until' ],
	\     [ "'ASC'", "'DESC'" ],
	\     [ "'asc'", "'desc'" ],
	\     [ "yes", "no" ],
	\     [ "on", "off" ],
	\     [ "enable", "disable" ],
	\     [ "enabled", "disabled" ],
	\     [ "required", "sometimes", "optional" ],
	\     [ "var", "let" ],
	\     [ "my", "our", "local" ],
	\ ]
