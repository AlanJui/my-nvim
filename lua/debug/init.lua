-----------------------------------------------------------
--  DAP init
-----------------------------------------------------------
-- require('telescope').load_extension('dap')
require('debug.python')

require('dap-python').setup('~/.pyenv/versions/venv-3.10.0/bin/python')

-----------------------------------------------------------
--  Key mapping for telescope-dap
-----------------------------------------------------------
local keymap = require('utils').keymap

keymap('n', '<LocalLeader>dc', '<cmd>lua require"dap".continue()<CR>')
keymap('n', '<LocalLeader>dsv', '<cmd>lua require"dap".step_over()<CR>')
keymap('n', '<LocalLeader>dsi', '<cmd>lua require"dap".step_into()<CR>')
keymap('n', '<LocalLeader>dso', '<cmd>lua require"dap".step_out()<CR>')
keymap('n', '<LocalLeader>dtb', '<cmd>lua require"dap".toggle_breakpoint()<CR>')
keymap('n', '<LocalLeader>dsbr', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
keymap('n', '<LocalLeader>dsbm', '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')
keymap('n', '<LocalLeader>dro', '<cmd>lua require"dap".repl.open()<CR>')
keymap('n', '<LocalLeader>drl', '<cmd>lua require"dap".repl.run_last()<CR>')

-- telescope-dap
keymap('n', '<LocalLeader>dcc', '<cmd>lua require"telescope".extensions.dap.commands{}<CR>')
keymap('n', '<LocalLeader>dco', '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>')
keymap('n', '<LocalLeader>dlb', '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>')
keymap('n', '<LocalLeader>dv', '<cmd>lua require"telescope".extensions.dap.variables{}<CR>')
keymap('n', '<LocalLeader>df', '<cmd>lua require"telescope".extensions.dap.frames{}<CR>')

-----------------------------------------------------------
