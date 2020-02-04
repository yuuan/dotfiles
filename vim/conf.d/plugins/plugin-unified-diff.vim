" ----------------------------------------
" vim-unified-diff
" ----------------------------------------

set diffexpr=unified_diff#diffexpr()

" configure with the followings (default values are shown below)
let unified_diff#executable = 'git'
let unified_diff#arguments = [
	\   'diff', '--no-index', '--no-color', '--no-ext-diff', '--unified=0',
	\ ]
let unified_diff#iwhite_arguments = [
	\   '--ignore--all-space',
	\ ]
