-- ========================================================================
-- WhichKey Configuration
-- ========================================================================
local wk = require('which-key')

local mappings = {
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
    ['b'] = {
        ['name'] = '+buffer',
        ['c']    = {'bdelete', 'Close buffer'},
        ['C']    = {'%bdelete|edit #|normal `"', 'Close all but current'},
        ['I']    = {'gg=G', 'Formate indent of line'},
        ['l']    = {':Telescope buffers', 'List all buffers'},
        ['s']    = {':setlocal spell!', 'Toggle spell'},
        ['w']    = {':StripWhitespace', 'Strip white space'},
        ['W']    = {':ToggleWhitespace', 'Toggle white space'},
        ['[']    = {'gT', 'Prev. buffer'},
        [']']    = {'gt', 'Next buffer'}
    },
    -- Code Actions
    ['c']    = {
        ['name'] = '+Commands',
        ['a']    = {":call v:lua.vim.lsp.buf.code_action()", 'Do CodeAction'},
        ['A']    = {":call v:lua.vim.lsp.buf.range_code_action()", 'Do Range CodeAction'},
        ['D']    = {":call v:lua.vim.lsp.buf.declaration()", 'Go to declaration'},
        ['d']    = {":call v:lua.vim.lsp.buf.definition()", 'Go to definition'},
        ['t']    = {":call v:lua.vim.lsp.buf.type_definition()", 'Go to type definition'},
        ['r']    = {":call v:lua.vim.lsp.buf.references()", 'References'},
        ['i']    = {":call v:lua.vim.lsp.buf.implementation()", 'Go to Implementation'},
        ['f']    = {":call v:lua.vim.lsp.buf.formatting()", 'Formatting code'},
        ['R']    = {":call v:lua.vim.lsp.buf.rename()", 'Rename code'},
        ['k']    = {":call v:lua.vim.lsp.buf.hover()", 'Show HoverDocument'},
    },
    -- File
    f = {
        name = 'file',
        q = { ":q<CR>", "Quit"},
        w = { ":w<CR>", "Save"},
        c = { ":bdelete<CR>", "Close" },
        C = { ":q!<CR>", "Quit withou save" },
        e = { ":qa<CR>", "Exit Neovim"},
        E = { ":qa!<CR>", "Exit Neovim without save"},
    },
    -- Search files
    ['s'] = {
        ['name'] = '+search',
        ['1']    = '',
        ['a']    = {':Telescope live_grep<CR>', 'Find file by keyword'},
        ['b']    = {':Telescope marks<CR>', 'Bookmarks'},
        ['d']    = {':Telescope diagnostics<CR>', 'Find diagnostics from worksapce'},
        ['D']    = {':Telescope diagnostics bufnr=0<CR>', 'Find diagnostics current file'},
        ['f']    = {':Telescope find_files<CR>', 'Find files'},
        ['h']    = {':Telescope oldfiles<CR>', 'History'},
        ['H']    = {':Telescope help_tags<CR>', 'Help Tags'},
        ['r']    = {':FloatermNew ranger<CR>', 'Picture Viewer'},
        ['v']    = {':FloatermNew vifm<CR>', 'ViFm'},
    },
    -- Git
    ['g'] = {
        ['name'] = '+git',
        ['a']    = {':Git add .<CR>', 'add all' },
        ['b']    = {':Git blame<CR>', 'blame' },
        ['B']    = {':GBrowse<CR>', 'Browse GitHub repo' },
        ['c']    = {':Git commit<CR>', 'commit' },
        ['d']    = {
            ['name'] = '+Diff',
            ['h']    = {':Gdiffsplit<CR>',  'diff split' },
            ['v']    = {':Gvdiffsplit<CR>', 'diff vsplit' },
            ['n']    = {':Git diff<CR>', 'Normal diff' },
        },
        ['g']    = {':GGrep<CR>', 'git grep' },
        ['l']    = {':Git log<CR>', 'List log with details' },
        ['L']    = {':Git log --oneline<CR>', 'List log within one line' },
        ['p']    = {':Git push<CR>', 'push' },
        ['P']    = {':Git pull<CR>', 'pull' },
        ['r']    = {':GRemove<CR>', 'remove' },
        ['s']    = {':Git<CR>', 'status'},
        ['S']    = {':GitGutterSignsToggle<CR>', 'toggle signs' },
        ['T']    = {':Git log --no-walk --tags --pretty="%h %d %s" --decorate=full<CR>', 'List all tags in log' },
    },
    -- Gist
    ['G'] = {
        ['name'] = '+gist',
        -- ['a']    = {':Gist -a', 'post a gist anonymously' },
        -- ['b']    = {':Gist -b', 'post gist browser' },
        ['d']    = {':Gist -d<CR>', 'delete gist' },
        ['e']    = {':Gist -e<CR>', 'edit gist' },
        ['l']    = {':Gist -l<CR>', 'list public gists' },
        ['s']    = {':Gist -ls<CR>', 'list starred gists' },
        ['m']    = {':Gist -m<CR>', 'post a gist with all open buffers' },
        ['p']    = {':Gist -p<CR>', 'post public gist' },
        ['P']    = {':Gist -P<CR>', 'post private gist' },
    },
    -- LSP / Language
    ['l'] = {
        ['name'] = '+lsp',
        ['a']    = {
            ['name'] = '+ALE',
            ['p']    = {":ALEPrevious<CR>", 'ALEPrevious'},
            ['n']    = {":ALENext<CR>", 'ALENext'},
            ['f']    = {":call v:lua.vim.lsp.buf.formatting()<CR>", 'Formatting'},
            ['d']    = {":call v:lua.vim.lsp.buf.declaration()<CR>", 'Go to declaration'},
            ['D']    = {":call v:lua.vim.lsp.buf.definition()<CR>", 'Go to definition'},
        },
        ['c']    = {
            ['name'] = '+Commands',
            ['a']    = {":call v:lua.vim.lsp.buf.code_action()<CR>", 'Do CodeAction'},
            ['A']    = {":call v:lua.vim.lsp.buf.range_code_action()<CR>", 'Do Range CodeAction'},
            ['D']    = {":call v:lua.vim.lsp.buf.declaration()<CR>", 'Go to declaration'},
            ['d']    = {":call v:lua.vim.lsp.buf.definition()<CR>", 'Go to definition'},
            ['t']    = {":call v:lua.vim.lsp.buf.type_definition()<CR>", 'Go to type definition'},
            ['r']    = {":call v:lua.vim.lsp.buf.references()<CR>", 'References'},
            ['i']    = {":call v:lua.vim.lsp.buf.implementation()<CR>", 'Go to Implementation'},
            ['f']    = {":call v:lua.vim.lsp.buf.formatting()<CR>", 'Formatting code'},
            ['R']    = {":call v:lua.vim.lsp.buf.rename()<CR>", 'Rename code'},
            ['k']    = {":call v:lua.vim.lsp.buf.hover()<CR>", 'Show HoverDocument'},
        },
        ['d']    = {
            ['name'] = '+DiagList',
            ['d']    = {':Telescope diagnostics<CR>', 'List diagnostics in worksapce'},
            ['D']    = {':Telescope diagnostics bufnr=0<CR>', 'List diagnostics current file'},
            ['e']    = {":call v:lua.vim.diagnostic.open_float()<CR>", 'Open diagnostics floating'},
            ['p']    = {":call v:lua.vim.diagnostic.goto_prev()<CR>", 'Goto prev diagnostics'},
            ['n']    = {":call v:lua.vim.diagnostic.goto_next()<CR>", 'Goto next diagnostics'},
        },
    },
    -- Configure Neovim
    n = {
        name = '+Neovim',
        i = {':e ~/.config/my-nvim/init.lua<CR>', 'Open [nvim]/init.lua'},
        I = {':source ~/.config/my-nvim/init.lua<CR>', 'Reload [nvim]/init.lua'},
        k = {':e ~/.config/my-nvim/lua/keymaps.lua<CR>', 'Open keybinding: keymaps.lua'},
        K = {':e ~/.config/my-nvim/lua/plugins/which-key-nvim.lua<CR>', 'Open which-key configuration'},
        p = {':e ~/.config/my-nvim/lua/plugins/init.lua<CR>', 'Open [plugings]/init.lua'},
        f = {':Telescope find_files shorten_path=true<CR>', 'Find configuration of plugin'},
        P = {
            name = 'Packer.nvim',
            c = {':PackerCompile<CR>', 'PackerCompile'},
            s = {':PackerSync<CR>', 'PackerSync'},
        },
        s = {':e ~/.config/my-nvim/lua/settings.lua<CR>', 'Open setting: settings.lua'},
    },
    -- utilities
    ['u'] = {
        ['name'] = '+utility',
        ['t']    = {
            ['name'] = '+Terminal',
            [';']    = {':FloatermNew --wintype=normal --height=6', 'Terminal pane'},
            ['d']    = {':FloatermNew python manage.py shell', 'Django-admin Shell'},
            ['p']    = {':FloatermNew python', 'Python shell'},
            ['n']    = {':FloatermNew node', 'Node.js shell'},
        },
        ['l']    = {
            ['name'] = '+LiveServer',
            ['l']    = {':Bracey', 'start live server'},
            ['L']    = {':BraceyStop', 'stop live server'},
            ['r']    = {':BraceyReload', 'web page to be reloaded'},
        },
        ['m']    = {
            ['name'] = '+Markdown',
            ['m']    = {':MarkdownPreview', 'start markdown preview'},
            ['M']    = {':MarkdownPreviewStop', 'stop markdown preview'},
        },
        ['u']    = {
            ['name'] = '+UML',
            ['v']    = {':PlantumlOpen', 'start PlantUML preview'},
            ['o']    = {':PlantumlSave docs/diagrams/out.png', 'export PlantUML diagram'},
        },
        ['f']    = {':FloatermNew vifm', 'ViFm'},
        ['g']    = {':FloatermNew lazygit', 'Lazygit'},
        ['p']    = {':FloatermNew ranger', 'Picture Viewer'},
    },
    -- Window
    ['w'] = {
        ['name'] = '+window',
        ['-']    = {'split',   'Horiz. window'},
        ['|']    = {'vsplit',  'Vert. window'},
        ['z']    = {'<C-W>_',  'Zoom-in'},
        ['Z']    = {'<C-W>|',  'Zoom-in (Vertical)'},
        ['o']    = {'<C-W>=',  'Zoom-out'},
        ['c']    = {'close',   'Close window'},
        ['k']    = {'<C-w>k',  'Up window'},
        ['j']    = {'<C-w>j',  'Down window'},
        ['h']    = {'<C-w>h',  'Left window'},
        ['l']    = {'<C-w>l',  'Right window'},
        ['w']    = {':exe "resize" . (winwidth(0) * 3/2)',           'Increase weight'},
        ['W']    = {':exe "resize" . (winwidth(0) * 2/3)',           'Increase weight'},
        ['v']    = {':exe "vertical resize" . (winheight(0) * 3/2)', 'Increase height'},
        ['V']    = {':exe "vertical resize" . (winheight(0) * 2/3)', 'Increase height'},
    }
}

local opts = {
    prefix = '<leader>',
}

wk.register(mappings, opts)
