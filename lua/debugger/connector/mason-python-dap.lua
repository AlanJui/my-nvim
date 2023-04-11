local dap = _G.safe_require("dap")
local mason_nvim_dap = _G.safe_require("mason-nvim-dap")
if not dap or not mason_nvim_dap then
    return
end

local M = {}

local nvim_config = _G.GetConfig()
local debugpy_path = nvim_config["python"]["debugpy_path"]
local venv_python_path = nvim_config["python"]["venv_python_path"]

function M.setup()
    return function(config) --luacheck: ignore 212
        config.adapters = {
            type = "executable",
            command = debugpy_path,
            args = {
                "-m",
                "debugpy.adapter",
            },
        }

        config.configurations = {
            {
                type = "python",
                request = "launch",
                name = "Launch file",
                program = "${file}", -- This configuration will launch the current file if used.
                pythonPath = venv_python_path,
            },
            {
                type = "python",
                request = "launch",
                name = "Launch Django Server",
                cwd = "${workspaceFolder}",
                program = "${workspaceFolder}/manage.py",
                args = {
                    "runserver",
                    "--noreload",
                },
                console = "integratedTerminal",
                justMyCode = true,
                pythonPath = venv_python_path,
            },
            {
                type = "python",
                request = "launch",
                name = "Python: Django Debug Single Test",
                -- pythonPath = venv_python_path,
                pythonPath = "${workspaceFolder}/.venv/bin/python",
                program = "${workspaceFolder}/manage.py",
                args = {
                    "test",
                    "${relativeFileDirname}",
                },
                django = true,
                console = "integratedTerminal",
            },
        }

        require("mason-nvim-dap").default_setup(config)
    end
end

return M
