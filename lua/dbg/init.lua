-----------------------------------------------------------
--  DAP init
-----------------------------------------------------------
require('telescope').load_extension('dap')
require('dbg.lua')
require('dbg.python')

-----------------------------------------------------------
--  Key mapping for telescope-dap
-----------------------------------------------------------
local keymap = require('utils.keymap').set_keymaps

keymap('n', '<LocalLeader>dct', '<cmd>lua require"dap".continue()<CR>')
keymap('n', '<LocalLeader>dsv', '<cmd>lua require"dap".step_over()<CR>')
keymap('n', '<LocalLeader>dsi', '<cmd>lua require"dap".step_into()<CR>')
keymap('n', '<LocalLeader>dso', '<cmd>lua require"dap".step_out()<CR>')
keymap('n', '<LocalLeader>dtb', '<cmd>lua require"dap".toggle_breakpoint()<CR>')

keymap('n', '<LocalLeader>dsc', '<cmd>lua require"dap.ui.variables".scopes()<CR>')
keymap('n', '<LocalLeader>dhh', '<cmd>lua require"dap.ui.variables".hover()<CR>')
keymap('v', '<LocalLeader>dhv',
    '<cmd>lua require"dap.ui.variables".visual_hover()<CR>')

keymap('n', '<LocalLeader>duh', '<cmd>lua require"dap.ui.widgets".hover()<CR>')
keymap('n', '<LocalLeader>duf',
    "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>")

keymap('n', '<LocalLeader>dsbr',
    '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
keymap('n', '<LocalLeader>dsbm',
    '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')
keymap('n', '<LocalLeader>dro', '<cmd>lua require"dap".repl.open()<CR>')
keymap('n', '<LocalLeader>drl', '<cmd>lua require"dap".repl.run_last()<CR>')


-- telescope-dap
keymap('n', '<LocalLeader>dcc',
    '<cmd>lua require"telescope".extensions.dap.commands{}<CR>')
keymap('n', '<LocalLeader>dco',
    '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>')
keymap('n', '<LocalLeader>dlb',
    '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>')
keymap('n', '<LocalLeader>dv',
    '<cmd>lua require"telescope".extensions.dap.variables{}<CR>')
keymap('n', '<LocalLeader>df',
    '<cmd>lua require"telescope".extensions.dap.frames{}<CR>')

-----------------------------------------------------------
vim.cmd([[
    nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
    nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
    nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
    nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
    nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
    nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
    nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
    nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
    nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>
]])
