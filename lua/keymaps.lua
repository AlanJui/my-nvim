if DEBUG then print('<< DEBUG: Loading keymaps.lua >>') end
-- keymap.lua
-- local keymap = require('utils.set_keymap')
local keymap = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true }

-- Line editting
keymap('i', 'jj', '<Esc>', opts)
keymap('i', '<Leader>O', '<Esc>O',   opts)
keymap('i', '<Leader>o', '<Esc>jO',  opts)
keymap('i', '<Leader>G', '<Esc>Go',  opts)
keymap('i', '<Leader>l', '<Esc>la',  opts)
keymap('i', '<Leader>a', '<Esc>A',   opts)
keymap('i', '<Leader>,', '<Esc>la,', opts)
keymap('i', '<Leader>:', '<Esc>la:', opts)

keymap('n', 'H', '0', opts)
keymap('n', 'L', '$', opts)
keymap('n', 'X', 'd$', opts)
keymap('n', 'Y', 'y$', opts)

-----------------------------------------------------------------------------
-- Find workds and Replace
keymap('n', 'fr', ':%s/', { noremap = true })

-- Find files
-- keymap('n', '\\', ":Lexplore<CR> :vertical resize 30<CR>", { noremap = true })
keymap('n', '<Leader>f', ':Telescope find_files<CR>', opts)

-- Indent/Unident
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Move line
keymap('n', '<S-Down>', ':m .+1<CR>', opts)
keymap('n', '<S-Up>',   ':m .-2<CR>', opts)
keymap('i', '<S-Down>', '<Esc>:m .+1<CR>', opts)
keymap('i', '<S-Up>',   '<Esc>:m .-2<CR>', opts)
keymap('v', '<S-Down>', ":move '>+1<CR>gv-gv", opts)
keymap('v', '<S-Up>',   ":move '<-2<CR>gv-gv", opts)

-- Windows navigation
keymap('n', 'sp',      ':sp<CR>',     opts)
keymap('n', 'vs',      ':vs<CR>',     opts)
keymap('n', '<C-w>-',  ':split<CR>',  opts)
keymap('n', '<C-w>_',  ':vsplit<CR>', opts)
keymap('n', '<C-w>|',  ':vsplit<CR>', opts)

-- Move focus on window
keymap('n', '<C-L>', '<C-W>l', opts)
keymap('n', '<C-H>', '<C-W>h', opts)
keymap('n', '<C-K>', '<C-W>k', opts)
keymap('n', '<C-J>', '<C-W>j', opts)

-- Window Resize
keymap('n', '<LocalLeader>w<', '30<C-w><', opts )
keymap('n', '<LocalLeader>w>', '30<C-w>>', opts )
keymap('n', '<LocalLeader>w+', '10<C-w>+', opts )
keymap('n', '<LocalLeader>w-', '10<C-w>-', opts )
keymap('n', '<LocalLeader>w_', '<C-w>_', opts )
keymap('n', '<LocalLeader>w=', '<C-w>=', opts )
keymap('n', '<LocalLeader>w|', '<C-w>|', opts )
keymap('n', '<LocalLeader>wo', '<C-w>|<C-w>_', opts )

-- Window Zoom In/Out
keymap('n', '<LocalLeader>wi', '<C-w>| <C-w>_', opts)
keymap('n', '<LocalLeader>wo', '<C-w>=', opts)

-- Tab operations
keymap('n', 'tn', ':tabnew<CR>', { noremap = true })
keymap('n', 'tk', ':tabnext<CR>', { noremap = true })
keymap('n', 'tj', ':tabprev<CR>', { noremap = true })
keymap('n', 'to', ':tabo<CR>', { noremap = true })

--------------------------------------------------------------------
-- Clear highlighting on escale in normal mode.
keymap('n', '<Esc>', ':noh<CR><Esc>', {silent = true, noremap = true})

--------------------------------------------------------------------
-- Terminal mode
keymap('t', '<Esc>', '<C-\\><C-n>', {noremap = true, silent = true})

--------------------------------------------------------------
-- None buildin commands
--------------------------------------------------------------
-- Tab navigation
keymap('n', 'gT', ':TablineBufferPrevious<CR>',  opts)
keymap('n', 'gt', ':TablineBufferNext<CR>',      opts)

-- Comment
keymap('n', '<C-_>', ':CommentToggle<CR>',      opts)
keymap('v', '<C-_>', ":'<,'>CommentToggle<CR>", opts)
