-----------------------------------------------------------
-- nvim-dap-python
-- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
-----------------------------------------------------------
M = {}

M.setup = function (python_path)
    local dap_python = safe_require('dap-python')
    if not dap_python then
        return
    end

    local dap = require('dap')

    -- configure DAP Adapter
    dap_python.setup(python_path)

    -- configure configurations of DAP Adapter
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

    -- configure configuration od DAP Adapter from VSCode
    -- require('dap.ext.vscode').load_launchjs()
end

return M

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
