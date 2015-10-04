" ----------------------------------------
" switch.vim
" ----------------------------------------

nnoremap - :Switch<cr>

let g:switch_custom_definitions = [
	\     [ 'private', 'protected', 'public' ],
	\     [ 'self::', 'static::' ],
	\     [ '@if', '@unless' ],
	\     [ '@endif', '@endunless' ],
	\     [ "'ASC'", "'DESC'" ],
	\     [ "'asc'", "'desc'" ],
	\     [ "yes", "no" ],
	\     [ "on", "off" ],
	\     [ "enable", "disable" ],
	\     [ "enabled", "disabled" ],
	\ ]
