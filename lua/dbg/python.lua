-----------------------------------------------------------
-- nvim-dap-python
-- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
-----------------------------------------------------------
local dap_python = safe_require('dap-python')
if not dap_python then
    return
end

local python_path = HOME .. '/.pyenv/versions/3.10.0/envs/venv-3.10.0/bin/python'
-- vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='🟦', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})

local dap = require('dap')
dap.defaults.fallback.terminal_win_cmd = '80vsplit new'

dap_python.setup(python_path)

table.insert(dap.configurations.python, {
    type = 'python',
    request = 'launch',
    name = 'Nvim-DAP Django runserver',
    program = '${workspaceFolder}/manage.py',
    args = {
        'runserver',
        '--noreload',
    },
    console = 'integratedTerminal',
    justMyCode = true,
    pythonPath = function ()
        return python_path
    end,
})
require('dap.ext.vscode').load_launchjs()

-- dap.adapters.python = {
--     type = 'executable';
--     command = python_path;
--     args = { '-m', 'debugpy.adapter' };
-- }

-- dap.configurations.python = {
--     {
--         type = 'python',
--         request = 'launch',
--         name = 'DAP Django',
--         cwd = '${workspaceFolder}',
--         program = '${workspaceFolder}/manage.py',
--         args = {
--             'runserver',
--         },
--         pythonPath = function ()
--             return python_path
--         end,
--     },
-- }
