-----------------------------------------------------------
--  DAP init
-----------------------------------------------------------
require('telescope').load_extension('dap')
require('debug.python')

-----------------------------------------------------------
--  Key mapping for telescope-dap
-----------------------------------------------------------
local keymap = require('utils').keymap

keymap('n', '<Leader>dc', '<cmd>lua require"dap".continue()<CR>')
keymap('n', '<Leader>dsv', '<cmd>lua require"dap".step_over()<CR>')
keymap('n', '<Leader>dsi', '<cmd>lua require"dap".step_into()<CR>')
keymap('n', '<Leader>dso', '<cmd>lua require"dap".step_out()<CR>')
keymap('n', '<Leader>dtb', '<cmd>lua require"dap".toggle_breakpoint()<CR>')
keymap('n', '<Leader>dsbr', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
keymap('n', '<Leader>dsbm', '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')
keymap('n', '<Leader>dro', '<cmd>lua require"dap".repl.open()<CR>')
keymap('n', '<Leader>drl', '<cmd>lua require"dap".repl.run_last()<CR>')

-- telescope-dap
keymap('n', '<Leader>dcc', '<cmd>lua require"telescope".extensions.dap.commands{}<CR>')
keymap('n', '<Leader>dco', '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>')
keymap('n', '<Leader>dlb', '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>')
keymap('n', '<Leader>dv', '<cmd>lua require"telescope".extensions.dap.variables{}<CR>')
keymap('n', '<Leader>df', '<cmd>lua require"telescope".extensions.dap.frames{}<CR>')

-----------------------------------------------------------
