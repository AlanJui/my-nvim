-----------------------------------------------------------
-- nvim-dap-python
-- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
-----------------------------------------------------------

local dap_python = safe_require('dap-python')
if not dap_python then
    return
end

M = {}

M.setup = function (dap, python_path)
    -- configure DAP Adapter
    dap_python.setup('~/.virtualenvs/debugpy/bin/python')

    local test_runners = dap_python.test_runners = 'pytest'

    -- test_runners` is a table. The keys are the runner names like `unittest` or `pytest`.
    -- The value is a function that takes three arguments:
    -- The classname, a methodname and the opts
    -- (The `opts` are coming passed through from either `test_method` or `test_class`)
    -- The function must return a module name and the arguments passed to the module as list.
    -- test_runners.your_runner = function(classname, methodname, opts)
    --     local args = {classname, methodname}
    --     return 'modulename', args
    -- end
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

    -- -- adapter definition
    -- dap.adapters.python = ({
    --     type = 'executable',
    --     command = 'python',
    --     args = { '-m', 'debugpy.adapter' }
    -- })

    -- -- configurations definitions
    -- dap.configurations.python = ({
    --     {
    --         -- The first three options are required by nvim-dap
    --         type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
    --         request = 'launch',
    --         name = "Launch file",

    --         -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
    --         program = "${file}", -- This configuration will launch the current file if used.
    --         pythonPath = function()
    --             -- return '/Users/alanjui/.pyenv/versions/3.10.0/envs/venv-3.10.0/bin/python3'
    --             return python_path
    --         end,
    --     },
    -- })


