" ----------------------------------------
" lightline
" ----------------------------------------

let g:lightline = {
	\     'colorscheme': 'powerline',
	\     'mode_map': {
	\         'c': 'NORMAL'
	\     },
	\     'active': {
	\         'left': [ [ 'mode', 'paste' ], [ 'filename', 'unitesource' ], [ 'unitecontext' ] ],
	\         'right': [
	\             [ 'lineinfo', 'percent'],
	\             [ 'fugitive', 'user' ],
	\             [ 'charvaluehex', 'fileformat', 'fileencoding', 'filetype'],
	\         ]
	\     },
	\     'component': {
	\         'charvaluehex': '0x%B'
	\     },
	\     'component_function': {
	\         'modified': 'LightLineModified',
	\         'readonly': 'LightLineReadOnly',
	\         'fugitive': 'LightLineFugitive',
	\         'fugitiveicon': 'LightLineFugitiveIcon',
	\         'filename': 'LightLineFileName',
	\         'fileformat': 'LightLineFileFormat',
	\         'filetype': 'LightLineFileType',
	\         'fileencoding': 'LightLineFileEncoding',
	\         'mode': 'LightLineMode',
	\         'unitecontext': 'LightLineUniteContext',
	\         'unitesource': 'LightLineUniteSource',
	\         'user': 'LightLineUser',
	\     },
	\     'separator': { 'left': "", 'right': "" },
	\     'subseparator': { 'left': "\u22ee", 'right': "\u22ee" },
	\     'tabline_separator': { 'left': '', 'right': '' },
	\     'tabline_subseparator': { 'left': '', 'right': '' }
	\ }

" Powerline のセパレータ
let s:powerline = {
	\     'separator': {
	\         'left': "\ue0b0", 'right': "\ue0b2"
	\     },
	\     'subseparator': {
	\         'left': "\u00bb", 'right': "\u00ab"
	\     }
	\ }

"let g:lightline.separator = s:powerline.separator
"let g:lightline.subseparator = s:powerline.subseparator

" Readonly を表す文字
let s:lockicon = {
	\     'powerline': "\ue0a2",
	\     'unicode': "\U1f512",
	\     'ascii': "RO"
	\ }

function! LightLineModified()
	return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadOnly()
	return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? s:lockicon.powerline : ''
endfunction

function! LightLineFileName()
	return &ft == 'vimfiler' ? vimfiler#get_status_string() :
		\  &ft =~ 'unite' ? '' :
		\  &ft == 'vimshell' ? vimshell#get_status_string() :
		\ ('' != LightLineReadOnly() ? LightLineReadOnly() . ' ' : '') .
		\ ('' != expand('%:t') ? expand('%:f') : '[No Name]') .
		\ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitiveIcon()
	let l:head = exists("*fugitive#head") ? fugitive#head() : ''
	return (strlen(l:head) > 0) ? "\ue0a0 " : ''
endfunction

function! LightLineFugitive()
	if winwidth(0) > 70 && exists("*fugitive#head")
		let l:head = fugitive#head()
		return strlen(l:head) ? "\ue0a0 " . l:head : ''
	else
		return ''
	endif
endfunction

function! LightLineFileFormat()
	return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFileType()
	return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileEncoding()
	return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
	return &ft == 'unite' ? 'Unite' :
		\  &ft == 'vimfiler' ? 'VimFiler' :
		\  &ft == 'vimshell' ? 'VimShell' :
		\  &ft == 'help' ? 'HELP' :
		\  winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightLineUniteContext()
	if &ft == 'unite'
		let l:list = split(unite#get_status_string(), '|')
		return l:list[1][1] == '[' && l:list[1][-1:] == ']' ? l:list[1][2:-2] : l:list[1]
	endif
	return ''
endfunction

function! LightLineUniteSource()
	if &ft == 'unite'
		let l:list = split(unite#get_status_string(), '|')
		return l:list[0]
	endif
	return ''
endfunction

function! LightLineUser()
	if expand('%') =~ 'sudo:'
		return 'root'
	else
		return $USER
	endif
endfunction
