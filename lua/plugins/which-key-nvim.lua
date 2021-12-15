-- ========================================================================
-- WhichKey Configuration
-- ========================================================================
local wk = require('which-key')

local mappings = {
    q = { ":q<CR>", "Quit"},
    w = { ":w<CR>", "Save"},
    x = { ":bdelete<CR>", "Close" },
    f = {
        name = "file", -- optional group name
        f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
        b = { function() print("bar") end, "Foobar" } -- you can also pass functions!
    },
    -- Actions
    a = {
        name = 'actions',
        f    = {':set foldmethod=indent', 'Set code folding by indent'},
        h    = {':let @/ = ""', 'remove search highlight'},
        t    = {':set filetype=htmldjango', 'set file type to django template'},
        T    = {':set filetype=html', 'set file type to HTML'},
        d    = {'gd', 'go to definition'},
        D    = {'gD', 'go to declaration'},
        l    = {':set wrap!', 'on/off line wrap'},
        n    = {':set nonumber!', 'on/off line-numbers'},
        N    = {':set norelativenumber!', 'on/off relative line-numbers'},
        S    = {':StripWhitespace', 'strip whitespace'},
    },
    -- Debug
    d = {
        name = 'debug',
        b = { ":lua require'dap'.toggle_breakpoint()<CR>", "Setting breakpoints"},
        l = { ":lua require'dap'.continue()<CR>", "Launching debug sessions"},
        s = { ":lua require'dap'.step_over()<CR>", "Step over"},
        i = { ":lua require'dap'.step_into()<CR>", "Step into"},
    }
}

local opts = {
    prefix = '<leader>',
}

wk.register(mappings, opts)
