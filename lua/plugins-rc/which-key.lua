---------------------------------------------------------------------------
-- WhichKey Configuration
---------------------------------------------------------------------------
local which_key = safe_require('which-key')
if not which_key then
    return
end

local mappings = {
    -- Configure Neovim
    n = {
        name = 'Neovim',
        i = { ':e ~/.config/my-nvim/init.lua<CR>', 'nvim/init.lua' },
        I = { ':source ~/.config/my-nvim/init.lua<CR>', 'reload' },
        k = { ':e ~/.config/my-nvim/lua/keymaps.lua<CR>', 'keymaps' },
        K = { ':e ~/.config/my-nvim/lua/plugins/which-key.lua<CR>', 'which-key' },
        C = { ':PackerCompile<CR>', 'PackerCompile' },
        S = { ':PackerSync<CR>', 'PackerSync' },
        l = {
            name = 'lsp',
            l = { ':Telescope git_files({cwd="~/.config/my-nvim/lua/lsp"})<CR>', 'list lsp configuration' },
            i = { ':e ~/.config/my-nvim/lua/lsp/init.lua<CR>', 'configure init' },
            o = { ':e ~/.config/my-nvim/lua/lsp/on-attach.lua<CR>', 'configure on-attach' },
            f = { ':e ~/.config/my-nvim/lua/lsp/format.lua<CR>', 'configure format' },
        },
        c = {
            name = 'configuration',
            g = { ':e ~/.config/my-nvim/lua/globals.lua<CR>', 'globals' },
            i = { ':e ~/.config/my-nvim/lua/init-env.lua<CR>', 'init-env' },
            s = { ':e ~/.config/my-nvim/lua/setup-rtp.lua<CR>', 'setup-rtp' },
            n = { ':e ~/.config/my-nvim/lua/nvim_utils.lua<CR>', 'nvim_utils' },
            o = { ':e ~/.config/my-nvim/lua/options.lua<CR>', 'options' },
            S = { ':e ~/.config/my-nvim/lua/settings.lua<CR>', 'options' },
            u = { ':e ~/.config/my-nvim/lua/utils.lua<CR>', 'utils' },
            c = { ':e ~/.config/my-nvim/lua/color-themes.lua<CR>', 'colorscheme' },
        },
        P = { ':e ~/.config/my-nvim/lua/plugins/init.lua<CR>', 'specifying plugins' },
        p = {
            name = 'plugins',
            p = { ':e ~/.config/my-nvim/lua/plugins/init.lua<CR>', 'specifying plugins' },
            c = { ':Telescope git_files({cwd="~/.config/my-nvim/lua/plugins"})<CR>', 'list all configuration' },
            f = { ':Telescope find_files shorten_path=true<CR>', 'find configuration of plugin' },
            C = { ':PackerCompile<CR>', 'PackerCompile' },
            S = { ':PackerSync<CR>', 'PackerSync' },
        },
    },
    -- Top Menu
    [' '] = { ':Telescope find_files<CR>', 'Find files' },
    [','] = { ':Telescope buffers<CR>', 'Show buffers' },
    [';'] = { ':FloatermNew --wintype=normal --height=10<CR>', 'Open Terminal' },
    ['v'] = { ':FloatermNew --height=0.7 --width=0.9 --wintype=float  vifm<CR>', 'ViFm' },
    ['/'] = { 'gcc', 'Comment out (Toggle)' },
    ['\\'] = { ':NvimTreeToggle<CR>', 'File explorer' },
    ['r'] = { ':Telescope yabs tasks<CR>', 'List tasks of YABS' },
    ['z'] = { 'UndotreeToggle<CR>', 'Undo tree' },
    -- Actions
    a = {
        name = 'actions',
        h = { ':let @/ = ""<CR>', 'remove search highlight' },
        t = { ':set filetype=htmldjango<CR>', 'set file type to django template' },
        T = { ':set filetype=html<CR>', 'set file type to HTML' },
        l = { ':set wrap!<CR>', 'on/off line wrap' },
        n = { ':set nonumber!<CR>', 'on/off line-numbers' },
        N = { ':set norelativenumber!<CR>', 'on/off relative line-numbers' },
    },
    -- Buffer
    b = {
        name = 'buffer',
        c = { ':bdelete<CR>', 'Close buffer' },
        C = { '%bdelete|edit #|normal `"<CR>', 'Close all but current' },
        I = { 'gg=G', 'Formate indent of line' },
        l = { ':Telescope buffers<CR>', 'List all buffers' },
        s = { ':setlocal spell!<CR>', 'Toggle spell' },
        w = { ':StripWhitespace<CR>', 'Strip white space' },
        W = { ':ToggleWhitespace<CR>', 'Toggle white space' },
        ['['] = { 'gT', 'Prev. buffer' },
        [']'] = { 'gt', 'Next buffer' },
    },
    -- Code Runner
    c = {
        name = 'Code Runner',
        l = { ':TermExec cmd="lua %"<CR>', 'Run lua file' },
        p = { ':TermExec cmd="python %"<CR>', 'Run python file'},
        d = { ':TermExec cmd="python -m pdb %"<CR>', 'Debug python file'},
        m = { ':TermExec cmd="nodemon -e py %"<CR>', 'Monitor python file'},
        D = {
            name = 'Django',
            r = { ':TermExec cmd="python manage.py runserver"<CR>', 'Django runserver' },
            R = { ':TermExec cmd="python manage.py runserver --noreload"<CR>', 'Django runserver --noreload' },
            s = { ':TermExec cmd="python manage.py collectstatic"<CR>', 'Collect all static files' },
            S = { ':TermExec cmd="python manage.py createsuperuser"<CR>', 'Create super user' },
            m = { ':TermExec cmd="python manage.py makemigrations"<CR>', 'Update DB' },
            M = { ':TermExec cmd="python manage.py migrate"<CR>', 'Migrate DB' },
        },
        L = {
            name = 'Lua',
            r = { ':TermExec cmd="lua %"<CR>', 'Run lua file' }
        },
        P = {
            name = 'Python',
            r = { ':update<CR>:exec "!python3" shellescape(@%,1)<CR>', 'Run Python file' },
            d = { ':update<CR>:sp term://python3 -m pdb %<CR>', 'Debug Python file' },
            n = { ':update<CR>:sp term://nodemon -e py %<CR>', 'Monitor the file' },
        },
    },
    -- Debug
    d = {
        name = 'debug',
        b = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", 'Toggle breakpoint' },
        B = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition<cmd> '))<CR>", 'Condition breakpoint' },
        c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
        s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
        R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
        i = { "<cmd>lua require'dap'.step_into()<CR>", 'Step into' },
        o = { "<cmd>lua require'dap'.step_over()<CR>", 'Step over' },
        O = { "<cmd>lua require'dap'.step_out()<CR>", 'Step out' },
        p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
        g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
        d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
        x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
        q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
        Q = {
            "<cmd>lua require'dap'.close()<CR><cmd>lua require'dap.repl'.close()<CR><cmd>lua require'dapui'.close()<CR><cmd>DapVirtualTextForceRefresh<CR>",
            "Quit Nvim DAP"
        },
        -- Show contents in Variable when mouse pointer hover
        h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
        e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
        S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
        u = { "<cmd>lua require'dapui'.toggle()<CR>", 'Show/Hide Debug Sidebar' },
        V = {
            "<cmd>lua local widgets=require'dap.ui.widgets'; widgets.centered_float(widgets.scopes)<CR>",
            'Use widgets to display the variables',
        },
        -- REPEL
        r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
    },
    -- Programming
    p = {
        name = 'programming',
        a = { '<cmd>lua vim.lsp.buf.code_action()<CR>', 'Do CodeAction' },
        A = { '<cmd>lua vim.lsp.buf.range_code_action()<CR>', 'Do Range CodeAction' },
        f = { '<cmd>lua vim.lsp.buf.formatting()<CR>', 'LSP formatting code' },
        k = { '<cmd>lua vim.lsp.buf.hover()<CR>', 'Show HoverDocument' },
        r = { '<cmd>lua vim.lsp.buf.rename()<CR>', 'Rename code' },
        s = { '<cmd>lua vim.lsp.buf.signature_help()<CR>', 'Show signature help' },
        d = {
            name = 'diagnostics',
            e = { '<cmd>lua vim.diagnostic.open_float()<CR>', 'Open diagnostics floating' },
            p = { '<cmd>lua vim.diagnostic.goto_prev()<CR>', 'Goto prev diagnostics' },
            n = { '<cmd>lua vim.diagnostic.goto_next()<CR>', 'Goto next diagnostics' },
            s = { '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', 'Set loclist' },
            l = { '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', 'Show line diagnostics' },
            D = { ':Telescope diagnostics<CR>', 'List diagnostics in worksapce' },
            d = { ':Telescope diagnostics bufnr=0<CR>', 'List diagnostics current file' },
        },
        g = {
            name = 'goto',
            D = { '<cmd>lua vim.lsp.buf.declaration()<CR>', 'Go to declaration' },
            d = { '<cmd>lua vim.lsp.buf.definition()<CR>', 'Go to definition' },
            t = { '<cmd>lua vim.lsp.buf.type_definition()<CR>', 'Go to type definition' },
            i = { '<cmd>lua vim.lsp.buf.implementation()<CR>', 'Go to Implementation' },
            r = { '<cmd>lua vim.lsp.buf.references()<CR>', 'References' },
        },
        m = {
            name = 'misc',
            t = { ':set filetype=htmldjango<CR>', 'set file type to django template' },
            T = { ':set filetype=html<CR>', 'set file type to HTML' },
        },
        w = {
            name = 'workspace',
            l = {
                '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
                'List workspace folders',
            },
            a = { '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', 'Add folder to workspace' },
            r = { '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', 'Remove folder from workspace' },
        },
    },
    -- Search files
    s = {
        name = 'search',
        a = { ':Telescope live_grep<CR>', 'Live grep' },
        b = { ':Telescope buffers theme=get_dropdown<CR>', 'buffers' },
        f = { ':Telescope find_files<CR>', 'Find files' },
        g = { ':Telescope git_files<CR>', 'Git files' },
        m = { ':Telescope marks<CR>', 'Bookmarks' },
        r = { ':Telescope oldfiles<CR>', 'Recently open files' },
        h = { ':Telescope help_tags<CR>', 'Help Tags' },
        p = { ':FloatermNew ranger<CR>', 'Picture Viewer' },
        w = { ':Telescope live_grep<CR>', 'Find word' },
        v = { ':FloatermNew vifm<CR>', 'ViFm' },
    },
    -- Files
    F = {
        name = 'files',
        w = { ':w<CR>', 'Save' },
        c = { ':bdelete<CR>', 'Close' },
        C = { ':q!<CR>', 'Quit withou save' },
        e = { ':qa<CR>', 'Exit Neovim' },
        E = { ':qa!<CR>', 'Exit Neovim without save' },
        q = { ':q<CR>', 'Quit' },
    },
    -- Git
    g = {
        name = 'git',
        g = { ':Neogit<CR>', 'Neogit' },
        a = { ':Git add .<CR>', 'add all' },
        b = { ':Git blame<CR>', 'blame' },
        B = { ':GBrowse<CR>', 'Browse GitHub repo' },
        c = { ':Git commit<CR>', 'commit' },
        d = {
            name = '+Diff',
            h = { ':Gdiffsplit<CR>', 'diff split' },
            v = { ':Gvdiffsplit<CR>', 'diff vsplit' },
            n = { ':Git diff<CR>', 'Normal diff' },
        },
        l = { ':Git log<CR>', 'List log with details' },
        L = { ':Git log --oneline<CR>', 'List log within one line' },
        p = { ':Git push<CR>', 'push' },
        P = { ':Git pull<CR>', 'pull' },
        r = { ':GRemove<CR>', 'remove' },
        s = { ':Git<CR>', 'status' },
        S = { ':GitGutterSignsToggle<CR>', 'toggle signs' },
        T = { ':Git log --no-walk --tags --pretty="%h %d %s" --decorate=full<CR>', 'List all tags in log' },
        z = { ':FloatermNew lazygit<CR>', 'Lazygit' },
        -- Gist
        G = {
            name = 'gist',
            -- a    = {':Gist -a', 'post a gist anonymously' },
            -- b    = {':Gist -b', 'post gist browser' },
            d = { ':Gist -d<CR>', 'delete gist' },
            e = { ':Gist -e<CR>', 'edit gist' },
            l = { ':Gist -l<CR>', 'list public gists' },
            s = { ':Gist -ls<CR>', 'list starred gists' },
            m = { ':Gist -m<CR>', 'post a gist with all open buffers' },
            p = { ':Gist -p<CR>', 'post public gist' },
            P = { ':Gist -P<CR>', 'post private gist' },
	    },
    },
    -- utilities
    u = {
        name = 'utilities',
        t = {
            name = 'terminal',
            d = { ':FloatermNew python manage.py shell<CR>', 'Django-admin Shell' },
            p = { ':FloatermNew python<CR>', 'Python shell' },
            n = { ':FloatermNew node<CR>', 'Node.js shell' },
            v = { ":FloatermNew --wintype='vsplit' --position='right'<CR>", 'Debug Term...' },
        },
        l = {
            name = 'LiveServer',
            l = { ':Bracey<CR>', 'start live server' },
            L = { ':BraceyStop<CR>', 'stop live server' },
            r = { ':BraceyReload<CR>', 'web page to be reloaded' },
        },
        m = {
            name = 'Markdown',
            m = { ':MarkdownPreview<CR>', 'start markdown preview' },
            M = { ':MarkdownPreviewStop<CR>', 'stop markdown preview' },
        },
        u = {
            name = 'UML',
            v = { ':PlantumlOpen<CR>', 'start PlantUML preview' },
            o = { ':PlantumlSave docs/diagrams/out.png<CR>', 'export PlantUML diagram' },
        },
        f = { ':FloatermNew --height=0.7 --width=0.9 --wintype=float vifm<CR>', 'ViFm' },
        r = { ':FloatermNew --height=0.7 --width=0.9 --wintype=float ranger<CR>', 'Ranger' },
    },
    -- Window
    w = {
        name = 'window',
        ['-'] = { ':split<CR>', 'Horiz. window' },
        ['|'] = { ':vsplit<CR>', 'Vert. window' },
        z = { '<C-W>_', 'Zoom-in' },
        Z = { '<C-W>|', 'Zoom-in (Vertical)' },
        o = { '<C-W>=', 'Zoom-out' },
        c = { ':close<CR>', 'Close window' },
        k = { '<C-w>k', 'Up window' },
        j = { '<C-w>j', 'Down window' },
        h = { '<C-w>h', 'Left window' },
        l = { '<C-w>l', 'Right window' },
        ['<Up>'] = { '<cmd>wincmd -<CR>', 'Shrink down' },
        ['<Down>'] = { '<cmd>wincmd +<CR>', 'Grow up' },
        ['<Left>'] = { '<cmd>wincmd <<CR>', 'Shrink narrowed' },
        ['<Right>'] = { '<cmd>wincmd ><CR>', 'Grow widder' },
        w = { ':exe "resize" . (winwidth(0) * 3/2)<CR>', 'Increase weight' },
        W = { ':exe "resize" . (winwidth(0) * 2/3)<CR>', 'Increase weight' },
        v = { ':exe "vertical resize" . (winheight(0) * 3/2)<CR>', 'Increase height' },
        V = { ':exe "vertical resize" . (winheight(0) * 2/3)<CR>', 'Increase height' },
    },
}

local opts = {
    prefix = '<leader>',
}

which_key.register(mappings, opts)


local keymap_v = {
    name = "Debug",
    e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
}
which_key.register(keymap_v, {
    mode = "v",
    prefix = "<Leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
})
