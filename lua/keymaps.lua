if DEBUG then print('<< DEBUG: Loading keymaps.lua >>') end
-- keymap.lua
local keymap = require('utils.set_keymap')
local opts = { silent = true, noremap = true }

vim.g.maplocalleader = ','

keymap('i', 'jj', '<Esc>', opts)
keymap('i', '<LocalLeader>O', '<Esc>O',   opts)
keymap('i', '<LocalLeader>o', '<Esc>jO',  opts)
keymap('i', '<LocalLeader>G', '<Esc>Go',  opts)
keymap('i', '<LocalLeader>l', '<Esc>la',  opts)
keymap('i', '<LocalLeader>a', '<Esc>A',   opts)
keymap('i', '<LocalLeader>,', '<Esc>la,', opts)
keymap('i', '<LocalLeader>:', '<Esc>la:', opts)

keymap('n', 'H', '0', opts)
keymap('n', 'L', '$', opts)
keymap('n', 'X', 'd$', opts)
keymap('n', 'Y', 'y$', opts)

-----------------------------------------------------------------------------
-- Find workds and Replace
keymap('n', 'fr', ':%s/', { noremap = true })

-- Find files
keymap('n', '\\', ":Lexplore<CR> :vertical resize 30<CR>", { noremap = true })
keymap('n', '<LocalLeader>f', ':Telescope<CR>', opts)

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

keymap('n', '<C-L>', '<C-W><C-L>', opts)
keymap('n', '<C-H>', '<C-W><C-H>', opts)
keymap('n', '<C-K>', '<C-W><C-K>', opts)
keymap('n', '<C-J>', '<C-W><C-J>', opts)


-- Window Zoom In/Out
keymap('n', '<LocalLeader>wi', '<C-w>| <C-w>_', opts)
keymap('n', '<LocalLeader>wo', '<C-w>=', opts)

keymap('n', 'tn', ':tabnew<CR>', { noremap = true })
keymap('n', 'tk', ':tabnext<CR>', { noremap = true })
keymap('n', 'tj', ':tabprev<CR>', { noremap = true })
keymap('n', 'to', ':tabo<CR>', { noremap = true })

--------------------------------------------------------------
-- None buildin commands
--------------------------------------------------------------
-- Tab navigation
keymap('n', 'gT',  		  ':TablineBufferPrevious<CR>',  opts)
keymap('n', 'gt',  		  ':TablineBufferNext<CR>',      opts)

-- Comment
keymap('n', '<C-_>', ':CommentToggle<CR>',      opts)
keymap('v', '<C-_>', ":'<,'>CommentToggle<CR>", opts)
