-- ========================================================================
-- WhichKey Configuration
-- ========================================================================
local which_key = safe_require('which-key')
if not which_key then
    return
end

local mappings = {
    -- Top Menu
    [' ']       = {':Telescope find_files<CR>', 'Find files'},
    [',']       = {':Telescope buffers<CR>', 'Show buffers'},
    [';']       = {':FloatermNew --wintype=normal --height=10<CR>', 'Open Terminal'},
    ['/']       = {'gcc', 'Comment out (Toggle)'},
    ['<Up>']    = 'Up window',
    ['<Down>']  = 'Down window',
    ['<Left>']  = 'Left window',
    ['<Right>'] = 'Right window',
    ['e']       = {':NvimTreeToggle<CR>', 'File explorer'},
    ['v']       = {':FloatermNew vifm<CR>', 'ViFm'},
    ['z']       = {'UndotreeToggle<CR>', 'Undo tree'},
    -- Actions
    a = {
        name = 'actions',
        f    = {':set foldmethod=indent<CR>', 'Set code folding by indent'},
        h    = {':let @/ = ""<CR>', 'remove search highlight'},
        t    = {':set filetype=htmldjango<CR>', 'set file type to django template'},
        T    = {':set filetype=html<CR>', 'set file type to HTML'},
        l    = {':set wrap!<CR>', 'on/off line wrap'},
        n    = {':set nonumber!<CR>', 'on/off line-numbers'},
        N    = {':set norelativenumber!<CR>', 'on/off relative line-numbers'},
        S    = {':StripWhitespace<CR>', 'strip whitespace'},
    },
    -- Debug
    d = {
        name = 'debug',
        b = { ":lua require'dap'.toggle_breakpoint()<CR>", "Setting breakpoints"},
        l = { ":lua require'dap'.continue()<CR>", "Launching debug sessions"},
        s = { ":lua require'dap'.step_over()<CR>", "Step over"},
        i = { ":lua require'dap'.step_into()<CR>", "Step into"},
    },
    -- Buffer
    b = {
        name = 'buffer',
        c    = {':bdelete<CR>', 'Close buffer'},
        C    = {'%bdelete|edit #|normal `"<CR>', 'Close all but current'},
        I    = {'gg=G', 'Formate indent of line'},
        l    = {':Telescope buffers<CR>', 'List all buffers'},
        s    = {':setlocal spell!<CR>', 'Toggle spell'},
        w    = {':StripWhitespace<CR>', 'Strip white space'},
        W    = {':ToggleWhitespace<CR>', 'Toggle white space'},
        ['[']    = {'gT', 'Prev. buffer'},
        [']']    = {'gt', 'Next buffer'}
    },
    -- Code Actions
    c    = {
        name = 'code',
        a    = {":call v:lua.vim.lsp.buf.code_action()<CR>", 'Do CodeAction'},
        A    = {":call v:lua.vim.lsp.buf.range_code_action()<CR>", 'Do Range CodeAction'},
        g    = {
            name = 'goto',
            D    = {":call v:lua.vim.lsp.buf.declaration()<CR>", 'Go to declaration'},
            d    = {":call v:lua.vim.lsp.buf.definition()<CR>", 'Go to definition'},
            t    = {":call v:lua.vim.lsp.buf.type_definition()<CR>", 'Go to type definition'},
            i    = {":call v:lua.vim.lsp.buf.implementation()<CR>", 'Go to Implementation'},
            r    = {":call v:lua.vim.lsp.buf.references()<CR>", 'References'},
        },
        f    = {":call v:lua.vim.lsp.buf.formatting()<CR>", 'Formatting code'},
        r    = {":call v:lua.vim.lsp.buf.rename()<CR>", 'Rename code'},
        k    = {":call v:lua.vim.lsp.buf.hover()<CR>", 'Show HoverDocument'},
        s    = {":call v:lua.vim.lsp.buf.signature_help()<CR>", 'Show signature help'},
        d    = {
            name = 'diagnostics',
            d    = {':Telescope diagnostics<CR>', 'List diagnostics in worksapce'},
            D    = {':Telescope diagnostics bufnr=0<CR>', 'List diagnostics current file'},
            e    = {":call v:lua.vim.diagnostic.open_float()<CR>", 'Open diagnostics floating'},
            p    = {":call v:lua.vim.diagnostic.goto_prev()<CR>", 'Goto prev diagnostics'},
            n    = {":call v:lua.vim.diagnostic.goto_next()<CR>", 'Goto next diagnostics'},
        },
    },
    -- System
    s = {
        name = 'system',
        q = { ":q<CR>", "Quit"},
        w = { ":w<CR>", "Save"},
        c = { ":bdelete<CR>", "Close" },
        C = { ":q!<CR>", "Quit withou save" },
        e = { ":qa<CR>", "Exit Neovim"},
        E = { ":qa!<CR>", "Exit Neovim without save"},
    },
    -- Find files
    f = {
        name = 'find',
        ['1']    = '',
        a    = {':Telescope live_grep<CR>', 'Live grep'},
        b    = {':Telescope buffers theme=get_dropdown<CR>', 'buffers'},
        D    = {':Telescope diagnostics<CR>', 'Find diagnostics from worksapce'},
        f    = {':Telescope find_files<CR>', 'Find files'},
        g    = {':Telescope git_files<CR>', 'Git files'},
        m    = {':Telescope marks<CR>', 'Bookmarks'},
        r    = {':Telescope oldfiles<CR>', 'Recently open files'},
        h    = {':Telescope help_tags<CR>', 'Help Tags'},
        p    = {':FloatermNew ranger<CR>', 'Picture Viewer'},
        w    = {':Telescope live_grep<CR>', 'Find word'},
        v    = {':FloatermNew vifm<CR>', 'ViFm'},
    },
    -- Git
    g = {
        name = 'git',
        a    = {':Git add .<CR>', 'add all' },
        b    = {':Git blame<CR>', 'blame' },
        B    = {':GBrowse<CR>', 'Browse GitHub repo' },
        c    = {':Git commit<CR>', 'commit' },
        d    = {
            name = '+Diff',
            h    = {':Gdiffsplit<CR>',  'diff split' },
            v    = {':Gvdiffsplit<CR>', 'diff vsplit' },
            n    = {':Git diff<CR>', 'Normal diff' },
        },
        g    = {':Neogit<CR>', 'Neogit' },
        --g    = {':GGrep<CR>', 'git grep' },
        l    = {':Git log<CR>', 'List log with details' },
        L    = {':Git log --oneline<CR>', 'List log within one line' },
        p    = {':Git push<CR>', 'push' },
        P    = {':Git pull<CR>', 'pull' },
        r    = {':GRemove<CR>', 'remove' },
        s    = {':Git<CR>', 'status'},
        S    = {':GitGutterSignsToggle<CR>', 'toggle signs' },
        T    = {':Git log --no-walk --tags --pretty="%h %d %s" --decorate=full<CR>', 'List all tags in log' },
        z    = {':FloatermNew lazygit<CR>', 'Lazygit'},
    },
    -- Gist
    G = {
        name = 'gist',
        -- a    = {':Gist -a', 'post a gist anonymously' },
        -- b    = {':Gist -b', 'post gist browser' },
        d    = {':Gist -d<CR>', 'delete gist' },
        e    = {':Gist -e<CR>', 'edit gist' },
        l    = {':Gist -l<CR>', 'list public gists' },
        s    = {':Gist -ls<CR>', 'list starred gists' },
        m    = {':Gist -m<CR>', 'post a gist with all open buffers' },
        p    = {':Gist -p<CR>', 'post public gist' },
        P    = {':Gist -P<CR>', 'post private gist' },
    },
    -- LSP / Language
    l = {
        name = 'LSP/Language',
        a    = {
            name = '+ALE',
            p    = {":ALEPrevious<CR>", 'ALEPrevious'},
            n    = {":ALENext<CR>", 'ALENext'},
            f    = {":call v:lua.vim.lsp.buf.formatting()<CR>", 'Formatting'},
            d    = {":call v:lua.vim.lsp.buf.declaration()<CR>", 'Go to declaration'},
            D    = {":call v:lua.vim.lsp.buf.definition()<CR>", 'Go to definition'},
        },
        c    = {
            name = 'commands',
            a    = {":call v:lua.vim.lsp.buf.code_action()<CR>", 'Do CodeAction'},
            A    = {":call v:lua.vim.lsp.buf.range_code_action()<CR>", 'Do Range CodeAction'},
            D    = {":call v:lua.vim.lsp.buf.declaration()<CR>", 'Go to declaration'},
            d    = {":call v:lua.vim.lsp.buf.definition()<CR>", 'Go to definition'},
            t    = {":call v:lua.vim.lsp.buf.type_definition()<CR>", 'Go to type definition'},
            r    = {":call v:lua.vim.lsp.buf.references()<CR>", 'References'},
            i    = {":call v:lua.vim.lsp.buf.implementation()<CR>", 'Go to Implementation'},
            f    = {":call v:lua.vim.lsp.buf.formatting()<CR>", 'Formatting code'},
            R    = {":call v:lua.vim.lsp.buf.rename()<CR>", 'Rename code'},
            k    = {":call v:lua.vim.lsp.buf.hover()<CR>", 'Show HoverDocument'},
        },
        d    = {
            name = 'diagnostics',
            d    = {':Telescope diagnostics<CR>', 'List diagnostics in worksapce'},
            D    = {':Telescope diagnostics bufnr=0<CR>', 'List diagnostics current file'},
            e    = {":call v:lua.vim.diagnostic.open_float()<CR>", 'Open diagnostics floating'},
            p    = {":call v:lua.vim.diagnostic.goto_prev()<CR>", 'Goto prev diagnostics'},
            n    = {":call v:lua.vim.diagnostic.goto_next()<CR>", 'Goto next diagnostics'},
        },
    },
    -- Configure Neovim
    n = {
        name = 'Neovim',
        i = {':e ~/.config/my-nvim/init.lua<CR>', 'nvim/init.lua'},
        I = {':source ~/.config/my-nvim/init.lua<CR>', 'reload'},
        k = {':e ~/.config/my-nvim/lua/keymaps.lua<CR>', 'keymaps'},
        K = {':e ~/.config/my-nvim/lua/plugins/which-key.lua<CR>', 'which-key'},
        C = {':PackerCompile<CR>', 'PackerCompile'},
        S = {':PackerSync<CR>', 'PackerSync'},
        l = {
            name = 'lsp',
            l = {':Telescope git_files({cwd="~/.config/my-nvim/lua/lsp"})<CR>', 'list lsp configuration'},
            i = {':e ~/.config/my-nvim/lua/lsp/init.lua<CR>', 'configure init'},
            o = {':e ~/.config/my-nvim/lua/lsp/on-attach.lua<CR>', 'configure on-attach'},
            f = {':e ~/.config/my-nvim/lua/lsp/format.lua<CR>', 'configure format'},
        },
        c = {
            name = 'configuration',
            g = {':e ~/.config/my-nvim/lua/globals.lua<CR>', 'globals'},
            i = {':e ~/.config/my-nvim/lua/init-env.lua<CR>', 'init-env'},
            s = {':e ~/.config/my-nvim/lua/setup-rtp.lua<CR>', 'setup-rtp'},
            n = {':e ~/.config/my-nvim/lua/nvim_utils.lua<CR>', 'nvim_utils'},
            o = {':e ~/.config/my-nvim/lua/options.lua<CR>', 'options'},
            u = {':e ~/.config/my-nvim/lua/utils.lua<CR>', 'utils'},
            c = {':e ~/.config/my-nvim/lua/color-themes.lua<CR>', 'colorscheme'},
        },
        p = {
            name = 'plugins',
            p = {':e ~/.config/my-nvim/lua/plugins/init.lua<CR>', 'specifying plugins'},
            c = {':Telescope git_files({cwd="~/.config/my-nvim/lua/plugins"})<CR>', 'list all configuration'},
            f = {':Telescope find_files shorten_path=true<CR>', 'find configuration of plugin'},
            C = {':PackerCompile<CR>', 'PackerCompile'},
            S = {':PackerSync<CR>', 'PackerSync'},
        },
    },
    -- utilities
    u = {
        name = 'utility',
        t    = {
            name = 'terminal',
            d    = {':FloatermNew python manage.py shell<CR>', 'Django-admin Shell'},
            p    = {':FloatermNew python<CR>', 'Python shell'},
            n    = {':FloatermNew node<CR>', 'Node.js shell'},
        },
        l    = {
            name = 'LiveServer',
            l    = {':Bracey<CR>', 'start live server'},
            L    = {':BraceyStop<CR>', 'stop live server'},
            r    = {':BraceyReload<CR>', 'web page to be reloaded'},
        },
        m    = {
            name = 'Markdown',
            m    = {':MarkdownPreview<CR>', 'start markdown preview'},
            M    = {':MarkdownPreviewStop<CR>', 'stop markdown preview'},
        },
        u    = {
            name = 'UML',
            v    = {':PlantumlOpen<CR>', 'start PlantUML preview'},
            o    = {':PlantumlSave docs/diagrams/out.png<CR>', 'export PlantUML diagram'},
        },
        f    = {':FloatermNew vifm<CR>', 'ViFm'},
        g    = {':FloatermNew lazygit<CR>', 'Lazygit'},
        p    = {':FloatermNew ranger<CR>', 'Picture Viewer'},
    },
    -- Window
    w = {
        name = 'window',
        ['-']    = {':split<CR>',   'Horiz. window'},
        ['|']    = {':vsplit<CR>',  'Vert. window'},
        z    = {'<C-W>_',  'Zoom-in'},
        Z    = {'<C-W>|',  'Zoom-in (Vertical)'},
        o    = {'<C-W>=',  'Zoom-out'},
        c    = {':close<CR>',   'Close window'},
        k    = {'<C-w>k',  'Up window'},
        j    = {'<C-w>j',  'Down window'},
        h    = {'<C-w>h',  'Left window'},
        l    = {'<C-w>l',  'Right window'},
        ['<Up>']    = {'<cmd>wincmd -<CR>', 'Shrink down' },
        ['<Down>']  = {'<cmd>wincmd +<CR>', 'Grow up' },
        ['<Left>']  = {'<cmd>wincmd <<CR>', 'Shrink narrowed' },
        ['<Right>'] = {'<cmd>wincmd ><CR>', 'Grow widder' },
        -- w    = {':exe "resize" . (winwidth(0) * 3/2)<CR>',           'Increase weight'},
        -- W    = {':exe "resize" . (winwidth(0) * 2/3)<CR>',           'Increase weight'},
        -- v    = {':exe "vertical resize" . (winheight(0) * 3/2)<CR>', 'Increase height'},
        -- V    = {':exe "vertical resize" . (winheight(0) * 2/3)<CR>', 'Increase height'},
    },
}

local opts = {
    prefix = '<leader>',
}

which_key.register(mappings, opts)
