local M = {}

local venv = os.getenv("VIRTUAL_ENV")
command = vim.fn.getcwd() .. string.format("%s/bin/python",venv)

function M.setup(_)
  -- require("dap-python").setup("python", {})
  require("nvim-dap-python").setup("python", {})
end

return M
