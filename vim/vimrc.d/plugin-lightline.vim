" ----------------------------------------
" lightline
" ----------------------------------------

let g:lightline = {
	\ 'colorscheme': 'powerline',
	\ 'mode_map': { 'c': 'NORMAL' },
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ], [ 'filename' ] ],
	\   'right': [
	\     [ 'lineinfo' ],
	\     [ 'percent' ],
	\     [ 'charvaluehex', 'fileformat', 'fileencoding', 'filetype', 'fugitiveicon']
	\   ]
	\ },
	\ 'component_function': {
	\   'modified': 'MyModified',
	\   'readonly': 'MyReadonly',
	\   'fugitive': 'MyFugitive',
	\   'fugitiveicon': 'MyFugitiveicon',
	\   'filename': 'MyFilename',
	\   'fileformat': 'MyFileformat',
	\   'filetype': 'MyFiletype',
	\   'fileencoding': 'MyFileencoding',
	\   'mode': 'MyMode',
	\ },
	\ 'separator': { 'left': "\ue0b0", 'right': "" },
	\ 'subseparator': { 'left': "\u00bb", 'right': "\u22ee" },
	\ 'tabline_separator': { 'left': '', 'right': '' },
	\ 'tabline_subseparator': { 'left': '', 'right': '' }
	\ }

function! MyModified()
	return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
	return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
endfunction

function! MyFilename()
	return ('' != MyReadonly() ? MyReadonly() . "\ue0a2" : '') .
		\ (&ft == 'vimfiler' ? vimfiler#get_status_string() : 
		\  &ft == 'unite' ? unite#get_status_string() : 
		\  &ft == 'vimshell' ? vimshell#get_status_string() :
		\ '' != expand('%:f') ? expand('%:f') : '[No Name]') .
		\ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitiveicon()
	let head = exists("*fugitive#head") ? fugitive#head() : ''
	return (strlen(head) > 0) ? "\ue0a0 " : ''
endfunction

function! MyFugitive()
	return exists("*fugitive#head") ? "\ue0a0 " . fugitive#head() : ''
endfunction

function! MyFileformat()
	return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
	return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
	return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
	return &ft == 'unite' ? 'Unite' : 
				\ &ft == 'vimfiler' ? 'VimFiler' : 
				\ &ft == 'vimshell' ? 'VimShell' : 
				\ winwidth(0) > 60 ? lightline#mode() : ''
endfunction
