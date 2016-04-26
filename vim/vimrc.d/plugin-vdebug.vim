" ----------------------------------------
" vdebug.vim
" ----------------------------------------

let g:vdebug_keymap = {
\    'run' : '<F5>',
\    'run_to_cursor' : '<F1>',
\    'step_over' : '<F2>',
\    'step_into' : '<F3>',
\    'step_out' : '<F4>',
\    'close' : '<C-F6>',
\    'detach' : '<C-F7>',
\    'set_breakpoint' : '<C-F10>',
\    'get_context' : '<F11>',
\    'eval_under_cursor' : '<C-F12>',
\    'eval_visual': '<A-F12>',
\ }

command! VdebugToggleBreakPoint python debugger.set_breakpoint()
command! VdebugStop python debugger.set_breakpoint()
