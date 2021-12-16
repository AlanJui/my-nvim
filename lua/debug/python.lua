-----------------------------------------------------------
-- nvim-dap-python
-----------------------------------------------------------

require('dap-python').setup('~/.pyenv/versions/venv-3.10.0/bin/python')

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

local keymap = require('utils').keymap
local opts = { silent = true, noremap = true }

keymap('n', '<Leader>dn', ":lua require('dap-python').test_method()<CR>         ", opts)
keymap('n', '<Leader>df', ":lua require('dap-python').test_class()<CR>          ", opts)
keymap('n', '<Leader>ds', "<ESC>:lua require('dap-python').debug_selection()<CR>", opts)

-- vim.cmd([[
-- nnoremap <silent> <Leader>dn :lua require('dap-python').test_method()<CR>
-- nnoremap <silent> <Leader>df :lua require('dap-python').test_class()<CR>
-- vnoremap <silent> <Leader>ds <ESC>:lua require('dap-python').debug_selection()<CR>
-- ]])
