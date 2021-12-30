-----------------------------------------------------------
--  DAP init
-----------------------------------------------------------
local dap = safe_require('dap')
if not dap then
    return
end

dap.defaults.fallback.terminal_win_cmd = '80vsplit new'

if OS_SYS == 'macOS' then
    -- vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
    vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
    vim.fn.sign_define('DapBreakpointRejected', {text='🟦', texthl='', linehl='', numhl=''})
    vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})
end

-----------------------------------------------------------
-- Show virtual text for current frame
-----------------------------------------------------------
local dap_virtual_text = safe_require('nvim-dap-virtual-text')
if not dap_virtual_text then
    return
end

vim.g.dap_virtual_text = true
dap_virtual_text.setup {
    enabled = true,                     -- enable this plugin (the default)
    enabled_commands = true,            -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    highlight_changed_variables = false, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = false,   -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = true,            -- show stop reason when stopped for exceptions
    commented = false,                  -- prefix virtual text with comment string
    -- experimental features:
    virt_text_pos = 'eol',              -- position of virtual text, see `:h nvim_buf_set_extmark()`
    all_frames = true,                 -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false,                 -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = nil             -- position the virtual text at a fixed window column (starting from the first text column) ,
                                        -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
}

-----------------------------------------------------------
-- provides user interface for nvim-dap
-----------------------------------------------------------
local dap_ui = safe_require('dapui')
if not dap_ui then
    return
end

dap_ui.setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
  },
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes",
        size = 0.25, -- Can be float or integer > 1
      },
      { id = "breakpoints", size = 0.25 },
      { id = "stacks", size = 0.25 },
      { id = "watches", size = 00.25 },
    },
    size = 40,
    position = "left", -- Can be "left", "right", "top", "bottom"
  },
  tray = {
    elements = { "repl" },
    size = 10,
    position = "bottom", -- Can be "left", "right", "top", "bottom"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
})

-----------------------------------------------------------
-- provides queries of commands supported from nvim-dap
-----------------------------------------------------------
require('telescope').load_extension('dap')
-- require'telescope'.extensions.dap.commands{}
-- require'telescope'.extensions.dap.configurations{}
-- require'telescope'.extensions.dap.list_breakpoints{}
-- require'telescope'.extensions.dap.variables{}
-- require'telescope'.extensions.dap.frames{}

-----------------------------------------------------------
-- vim-ultest: Unit Test Tool
-- :help ultest-debugging
-----------------------------------------------------------

-- To tell test runner tolways output with colour.
vim.cmd([[
let test#python#pytest#options = "--color=yes"
let test#javascript#jest#options = "--color=always"
]])

-- For user of Neovim >= 0.5, you can enable PTY usage which
-- makes the process think it is in an interactive session
vim.cmd([[
let g:ultest_use_pty = 1
]])

-- To run the nearest test every time a file is written:
vim.cmd([[
augroup UltestRunner
    au!
    au BufWritePost * UltestNearest
augroup END
]])

-- To be able to jump between failures in a test files
vim.cmd([[
nmap ]t <Plug>(ultest-next-fail)
nmap [t <Plug>(ultest-prev-fail)
]])

-----------------------------------------------------------
-- configurations for DAP Adapter
-----------------------------------------------------------

-- configure Neovim Lua Adapter
require('dbg.lua')

-- configure dap-python Adapter
local python_path = HOME .. '/.pyenv/versions/3.10.0/envs/venv-3.10.0/bin/python'
require('dbg.python').setup(python_path)

-----------------------------------------------------------
--  Key mapping for nvim-dap
-----------------------------------------------------------
local keymap = require('utils.keymap').set_keymaps

keymap('n', '<LocalLeader>dct', '<cmd>lua require"dap".continue()<CR>')
keymap('n', '<LocalLeader>dso', '<cmd>lua require"dap".step_over()<CR>')
keymap('n', '<LocalLeader>dsi', '<cmd>lua require"dap".step_into()<CR>')
keymap('n', '<LocalLeader>dst', '<cmd>lua require"dap".step_out()<CR>')
keymap('n', '<LocalLeader>dtb', '<cmd>lua require"dap".toggle_breakpoint()<CR>')
keymap('n', '<LocalLeader>dlp',
    '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')

-- nvim-dap-ui
keymap('n', '<LocalLeader>dui', '<cmd>lua require"dapui".toggle()<CR>')

-- By default nvim-dap provides widgets and UIs to display the variables
keymap('n', '<LocalLeader>duh', '<cmd>lua require"dap.ui.widgets".hover()<CR>')
keymap('n', '<LocalLeader>duf',
    "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>")

-- REPL
keymap('n', '<LocalLeader>dro', '<cmd>lua require"dap".repl.open()<CR>')
keymap('n', '<LocalLeader>drl', '<cmd>lua require"dap".repl.run_last()<CR>')

keymap('n', '<LocalLeader>dvs', '<cmd>lua require"dap.ui.variables".scopes()<CR>')
keymap('n', '<LocalLeader>dvh', '<cmd>lua require"dap.ui.variables".hover()<CR>')
keymap('v', '<LocalLeader>dvv',
    '<cmd>lua require"dap.ui.variables".visual_hover()<CR>')

keymap('n', '<LocalLeader>dsbr',
    '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
keymap('n', '<LocalLeader>dsbm',
    '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')

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
    nnoremap <silent> <F5>  :lua require'dap'.continue()<CR>
    nnoremap <silent> <F9>  :lua require'dap'.toggle_breakpoint()<CR>
    nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
    nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
    nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
]])
