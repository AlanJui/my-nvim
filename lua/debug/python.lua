-----------------------------------------------------------
-- nvim-dap-python
-----------------------------------------------------------

local dap = require('dap')

local bin_path = HOME .. '/.pyenv/versions/venv-3.10.0/bin/python'

-- dap.adapters.python = {
--     type = 'executable',
--     command = bin_path,
--     args = { '-m', 'debugpy.adapter' },
-- }

dap.configurations.python = {
    {
        -- The first three options are required by nvim-dap
        type = 'python',  -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = 'launch',
        name = "Launch file",

        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
        program = "${file}"; -- This configuration will launch the current file if used.
        pythonPath = function()
            return bin_path
        end,
    },
}

vim.cmd([[
nnoremap <silent> <LocalLeader>dn :lua require('dap-python').test_method()<CR>
nnoremap <silent> <LocalLeader>df :lua require('dap-python').test_class()<CR>
vnoremap <silent> <LocalLeader>ds <ESC>:lua require('dap-python').debug_selection()<CR>
]])
