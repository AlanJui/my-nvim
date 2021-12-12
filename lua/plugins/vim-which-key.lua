-- ========================================================================
-- WhichKey Configuration
-- ========================================================================
vim.g.mapleader = ' '
local keymap = require('utils.set_keymap')

-- Leader configuration
-- ------------------------------------------------------------------------
keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})

-- Prefix: <leader>
-- -----------------------------------------------------------------------------
keymap('n', '<Leader>', [[:<C-u>WhichKey "<space>"<CR>]], {silent = true})
keymap('v', '<Leader>', [[:<C-u>WhichKeyVisual "<space>"<CR>]], {silent = true})
vim.call('which_key#register', '<Space>', 'g:which_key_leader')

keymap('n', '<Leader><Up>', '<C-w>k', {silent = true})
keymap('n', '<Leader><Down>', '<C-w>j', {silent = true})
keymap('n', '<Leader><Left>', '<C-w>h', {silent = true})
keymap('n', '<Leader><Right>', '<C-w>l', {silent = true})

-- Normal mode (mappings without prefix)
-- ------------------------------------------------------------------------

-- Clear highlighting on escale in normal mode.
keymap('n', '<Esc>', ':noh<CR><Esc>', {silent = true, noremap = true})

-- Terminal mode
-- ------------------------------------------------------------------------
keymap('t', '<Esc>', '<C-\\><C-n>', {noremap = true, silent = true})

-- WhichKey
-- ------------------------------------------------------------------------

vim.g.which_key_leader = {
    ['name']    = '',
    [' ']       = {':Telescope find_files', 'Find files'},
    [',']       = {':Telescope buffers', 'Show buffers'},
    [';']       = {':FloatermNew --wintype=normal --height=10', 'Terminal panel'},
    ['/']       = {'gcc', 'Comment out and Toggle'},
    ['<Up>']    = 'Up window',
    ['<Down>']  = 'Down window',
    ['<Left>']  = 'Left window',
    ['<Right>'] = 'Right window',
    ['e']       = {':NvimTreeToggle', 'File explorer'},
    ['v']       = {':FloatermNew vifm', 'ViFm'},
    ['z']       = {'UndotreeToggle', 'Undo tree'},

    -- Submenus
    -- ----------------------------------------------------------------------

    -- Actions
    ['a'] = {
        ['name'] = '+actions',
        ['h']    = {':let @/ = ""', 'remove search highlight'},
        ['t']    = {':set filetype=htmldjango', 'set file type to django template'},
        ['T']    = {':set filetype=html', 'set file type to HTML'},
        ['d']    = {'gd', 'go to definition'},
        ['D']    = {'gD', 'go to declaration'},
        ['l']    = {':set wrap!', 'on/off line wrap'},
        ['n']    = {':set nonumber!', 'on/off line-numbers'},
        ['N']    = {':set norelativenumber!', 'on/off relative line-numbers'},
        -- ['s']    = {':Lspsaga', 'Run Lspsaga command'},
        ['S']    = {':StripWhitespace', 'strip whitespace'},
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

    -- Configure Neovim
    ['n'] = {
        ['name'] = '+Neovim',
        ['i']    = {':e ~/.config/web-nvim/init.lua', 'Open [nvim]/init.lua'},
        ['I']    = {':source ~/.config/web-nvim/init.lua', 'Reload [nvim]/init.lua'},
        ['k']    = {':e ~/.config/web-nvim/lua/keymaps.lua', 'Open keybinding: keymaps.lua'},
        ['K']    = {':e ~/.config/web-nvim/lua/plugins/vim-which-key.lua', 'Open which-key configuration'},
        ['p']    = {':e ~/.config/web-nvim/lua/plugins/init.lua', 'Open [plugings]/init.lua'},
        ['P']    = {':Telescope find_files shorten_path=true', 'Search configuration of plugin'},
        ['C']    = {':PackerCompile', 'PackerCompile'},
        ['s']    = {':e ~/.config/web-nvim/lua/settings.lua', 'Open setting: settings.lua'},
        ['S']    = {':PackerSync', 'PackerSync'},
    },

    -- File
    ['f'] = {
        ['name'] = '+find',
        ['a']    = {':Telescope live_grep', 'Find word'},
        ['b']    = {':Telescope marks', 'Bookmarks'},
        ['f']    = {':Telescope find_files', 'Find files'},
        ['h']    = {':Telescope oldfiles', 'History'},
        ['r']    = {':FloatermNew ranger', 'Picture Viewer'},
        ['v']    = {':FloatermNew vifm', 'ViFm'},
    },

    -- Git
    ['g'] = {
        ['name'] = '+git',
        ['a']    = {':Git add .', 'add all' },
        ['b']    = {':Git blame', 'blame' },
        ['B']    = {':GBrowse', 'Browse GitHub repo' },
        ['c']    = {':Git commit', 'commit' },
        ['d']    = {
            ['name'] = '+Diff',
            ['h']    = {':Gdiffsplit',  'diff split' },
            ['v']    = {':Gvdiffsplit', 'diff vsplit' },
            ['n']    = {':Git diff', 'Normal diff' },
        },
        ['g']    = {':GGrep', 'git grep' },
        ['l']    = {':Git log', 'List log with details' },
        ['L']    = {':Git log --oneline', 'List log within one line' },
        ['p']    = {':Git push', 'push' },
        ['P']    = {':Git pull', 'pull' },
        ['r']    = {':GRemove', 'remove' },
        ['s']    = {':Git', 'status'},
        ['S']    = {':GitGutterSignsToggle', 'toggle signs' },
        ['T']    = {':Git log --no-walk --tags --pretty="%h %d %s" --decorate=full', 'List all tags in log' },
    },

    -- Gist
    ['G'] = {
        ['name'] = '+gist',
        -- ['a']    = {':Gist -a', 'post a gist anonymously' },
        -- ['b']    = {':Gist -b', 'post gist browser' },
        ['d']    = {':Gist -d', 'delete gist' },
        ['e']    = {':Gist -e', 'edit gist' },
        ['l']    = {':Gist -l', 'list public gists' },
        ['s']    = {':Gist -ls', 'list starred gists' },
        ['m']    = {':Gist -m', 'post a gist with all open buffers' },
        ['p']    = {':Gist -p', 'post public gist' },
        ['P']    = {':Gist -P', 'post private gist' },
    },

    -- LSP / Language
    ['l'] = {
        ['name'] = '+lsp',
        ['a']    = {
            ['name'] = '+ALE',
            ['p']    = {":ALEPrevious", 'ALEPrevious'},
            ['n']    = {":ALENext", 'ALENext'},
            ['f']    = {":call v:lua.vim.lsp.buf.formatting()", 'Formatting'},
            ['d']    = {":call v:lua.vim.lsp.buf.declaration()", 'Go to declaration'},
            ['D']    = {":call v:lua.vim.lsp.buf.definition()", 'Go to definition'},
        },
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
        ['d']    = {
            ['name'] = '+DiagList',
            ['e']    = {":call v:lua.vim.diagnostic.open_float()", 'Open diagnostics floating'},
            ['l']    = {":call v:lua.vim.diagnostic.setloclist()", 'List all diagnostics'},
            ['p']    = {":call v:lua.vim.diagnostic.goto_prev()", 'Goto prev diagnostics'},
            ['n']    = {":call v:lua.vim.diagnostic.goto_next()", 'Goto next diagnostics'},
        },
        -- ['s']    = {
        --     ['name'] = '+Saga',
        --     ['a']    = {":Lspsaga code_action<CR>", 'Code action'},
        --     ['A']    = {":Lspsaga range_code_action<CR>", 'Code action for range'},
        --     ['f']    = {":Lspsaga lsp_finder<CR>", 'Async LSP finder'},
        --     ['h']    = {":Lspsaga hover_doc<CR>", 'Hover doc'},
        --     ['H']    = {":Lspsaga signature_help<CR>", 'Signature help'},
        --     ['l']    = {":Lspsaga ", 'Enter command Lspsaga'},
        --     ['S']    = {":Lspsaga show_cursor_diagnostics<CR>", 'Show djagnosics on cursor'},
        --     ['s']    = {":Lspsaga show_line_diagnostics<CR>", 'Show djagnosics'},
        --     ['[']    = {":Lspsaga diagnostic_jump_prev<CR>", 'Jump previous djagnosics'},
        --     [']']    = {":Lspsaga diagnostic_jump_next<CR>", 'Jump nex djagnosics'},
        --     ['p']    = {":Lspsaga preview_definition<CR>", 'Preview definition'},
        --     ['r']    = {":Lspsaga rename<CR>", 'rename'},
            -- ['f']    = {':lua vim.lsp.buf.formatting()', 'format code'},
            -- ['d']    = {":call v:lua.require'lspsaga.diagnostic'.show_line_diagnostics()", 'Show djagnosics'}
        -- },
        ['p']    = {
            ['name'] = '+Python',
            ['d']    = {':FloatermNew python manage.py shell', 'Django-admin Shell'},
            ['p']    = {':FloatermNew python', 'Python shell'},
            -- ['v']    = {':Vista!!', 'toogle vista view window'},
        },
        ['w']    = {
            ['name'] = '+Workspace',
            ['a']    = {':call v:lua.vim.lsp.buf.add_workspace_folder()', 'Add workspace folder'},
            ['r']    = {':call v:lua.vim.lsp.buf.remove_workspace_folder()', 'Remove workspace folder'},
            ['l']    = {':call v:lua.print(lua.vim.inspect(vim.lsp.bufelist_workspace_foldere()))', 'List workspace folder'},
        },
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
