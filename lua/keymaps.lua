--------------------------------------------------------------------
-- keymap.lua
--------------------------------------------------------------------
if DEBUG then print('<< DEBUG: Loading keymaps.lua >>') end

-- local keymap = require('utils.set_keymap')
local keymap = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true }

keymap('i', 'jj', '<Esc>', opts)

--------------------------------------------------------------------
-- Line  editting
--------------------------------------------------------------------
-- Insert line
keymap('i', '<LocalLeader>O', '<Esc>O',   opts)
keymap('i', '<LocalLeader>o', '<Esc>jO',  opts)
keymap('i', '<LocalLeader>G', '<Esc>Go',  opts)

-- Move line
keymap('n', '<S-Down>', ':m .+1<CR>', opts)
keymap('n', '<S-Up>',   ':m .-2<CR>', opts)
keymap('i', '<S-Down>', '<Esc>:m .+1<CR>', opts)
keymap('i', '<S-Up>',   '<Esc>:m .-2<CR>', opts)
keymap('v', '<S-Down>', ":move '>+1<CR>gv-gv", opts)
keymap('v', '<S-Up>',   ":move '<-2<CR>gv-gv", opts)

-- Indent/Unident
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Remove Line
keymap('n', '<LocalLeader>d', 'k1dd', opts)
keymap('i', '<C-CR>', '<Esc>kdd', opts)

-- Editting in line
keymap('n', 'H', '0', opts)
keymap('n', 'L', '$', opts)
keymap('n', 'X', 'd$', opts)
keymap('n', 'Y', 'y$', opts)

keymap('i', '<LocalLeader>l', '<Esc>la',  opts)
keymap('i', '<LocalLeader>a', '<Esc>A',   opts)
keymap('i', '<LocalLeader>,', '<Esc>la,', opts)
keymap('i', '<LocalLeader><LocalLeader>,', '<Esc>A,', opts)
keymap('i', '<LocalLeader>:', '<Esc>la:', opts)
keymap('i', '<LocalLeader><LocalLeader>:', '<Esc>A:', opts)

keymap('n', 'ds', '<Plug>Dsurround', { noremap = false })
keymap('n', 'cs', '<Plug>Csurround', { noremap = false })
keymap('n', 'cS', '<Plug>CSurround', { noremap = false })
keymap('n', 's', '<Plug>Ysurround', { noremap = false })
keymap('n', 'S', '<Plug>YSurround', { noremap = false })
keymap('n', 'ss', '<Plug>Yssurround', { noremap = false })
keymap('n', 'SS', '<Plug>YSsurround', { noremap = false })
keymap('x', 's', '<Plug>VSurround', { noremap = false })
keymap('x', 'S', '<Plug>VgSurround', { noremap = false })

-----------------------------------------------------------------------------
-- Find workds and Replace
keymap('n', 'fr', ':%s/', { noremap = true })

-- Find files
-- keymap('n', '\\', ":Lexplore<CR> :vertical resize 30<CR>", { noremap = true })
keymap('n', '<Leader>f', ':Telescope find_files<CR>', opts)

--------------------------------------------------------------------
-- Windows navigation
--------------------------------------------------------------------
-- Split window
keymap('n', 'sp',      ':sp<CR>',     opts)
keymap('n', 'vs',      ':vs<CR>',     opts)
keymap('n', '<C-w>-',  ':split<CR>',  opts)
keymap('n', '<C-w>_',  ':vsplit<CR>', opts)
keymap('n', '<C-w>|',  ':vsplit<CR>', opts)

-- Move focus on window
-- keymap('n', '<C-h>', '<cmd>wincmd h<CR>', opts)
-- keymap('n', '<C-l>', '<cmd>wincmd l<CR>', opts)
-- keymap('n', '<C-k>', '<cmd>wincmd k<CR>', opts)
-- keymap('n', '<C-j>', '<cmd>wincmd j<CR>', opts)
keymap('n', '<C-H>', '<C-W>h', opts)
keymap('n', '<C-L>', '<C-W>l', opts)
keymap('n', '<C-K>', '<C-W>k', opts)
keymap('n', '<C-J>', '<C-W>j', opts)

-- Window Resize
keymap('n', '<ESC>k', '<cmd>wincmd -<CR>', opts)
keymap('n', '<ESC>j', '<cmd>wincmd +<CR>', opts)
keymap('n', '<ESC>h', '<cmd>wincmd <<CR>', opts)
keymap('n', '<ESC>l', '<cmd>wincmd ><CR>', opts)

keymap('n', '<M-Up>',    '<cmd>wincmd -<CR>', opts)
keymap('n', '<M-Down>',  '<cmd>wincmd +<CR>', opts)
keymap('n', '<M-Left>',  '<cmd>wincmd <<CR>', opts)
keymap('n', '<M-Right>', '<cmd>wincmd ><CR>', opts)

keymap('n', '<S-Up>',    '<cmd>wincmd -<CR>', opts)
keymap('n', '<S-Down>',  '<cmd>wincmd +<CR>', opts)
keymap('n', '<S-Left>',  '<cmd>wincmd <<CR>', opts)
keymap('n', '<S-Right>', '<cmd>wincmd ><CR>', opts)

keymap('n', '<F1>', '<cmd>wincmd -<CR>', opts)
keymap('n', '<F2>', '<cmd>wincmd +<CR>', opts)
keymap('n', '<F3>', '<cmd>wincmd <<CR>', opts)
keymap('n', '<F4>', '<cmd>wincmd ><CR>', opts)

-- keymap('n', '<LocalLeader>w<', '30<C-w><', opts )
-- keymap('n', '<LocalLeader>w>', '30<C-w>>', opts )
-- keymap('n', '<LocalLeader>w+', '10<C-w>+', opts )
-- keymap('n', '<LocalLeader>w-', '10<C-w>-', opts )
-- keymap('n', '<LocalLeader>w_', '<C-w>_', opts )
-- keymap('n', '<LocalLeader>w=', '<C-w>=', opts )
-- keymap('n', '<LocalLeader>w|', '<C-w>|', opts )
-- keymap('n', '<LocalLeader>wo', '<C-w>|<C-w>_', opts )

-- Window Zoom In/Out
keymap('n', '<LocalLeader>wi', '<C-w>| <C-w>_', opts)
keymap('n', '<LocalLeader>wo', '<C-w>=', opts)

--------------------------------------------------------------------
-- Buffers
--------------------------------------------------------------------
-- Tab operations
keymap('n', 'tn', ':tabnew<CR>', { noremap = true })
keymap('n', 'tk', ':tabnext<CR>', { noremap = true })
keymap('n', 'tj', ':tabprev<CR>', { noremap = true })
keymap('n', 'to', ':tabo<CR>', { noremap = true })

-- Tab navigation
keymap('n', 'gT', ':TablineBufferPrevious<CR>',  opts)
keymap('n', 'gt', ':TablineBufferNext<CR>',      opts)

-- Buffers
keymap('n', '<Tab>',           '<cmd>bn<CR>', opts)
keymap('n', '<S-Tab>',         '<cmd>bp<CR>', opts)
keymap('n', '<LocalLeader>bd', '<cmd>bd<CR>', opts)

--------------------------------------------------------------------
-- Clear highlighting on escale in normal mode.
--------------------------------------------------------------------
keymap('n', '<Esc>', ':noh<CR><Esc>', opts)

--------------------------------------------------------------------
-- Terminal mode
--------------------------------------------------------------------
keymap('t', '<Esc>', '<C-\\><C-n>', opts)

--------------------------------------------------------------
-- Nonbuild-in commands
--------------------------------------------------------------
-- Comment
-- keymap('n', '<C-_>', ':CommentToggle<CR>',      opts)
-- keymap('v', '<C-_>', ":'<,'>CommentToggle<CR>", opts)
keymap('n', '<C-_>', ':Commentary<CR>',      opts)
keymap('v', '<C-_>', ":'<,'>Commentary<CR>", opts)

-- Copy relative filepath eg: from nvim folder this would look like: "lua/core/keymaps.lua" copied to clipboard
keymap( 'n', '<LocalLeader>fp', '<cmd>let @*=fnamemodify(expand("%"), ":~:.") | echo( \'"\' . (fnamemodify(expand("%"), ":~:.")) . \'" copied to clipboard\')<CR>', {noremap = true})

-- Neogit
keymap('n', '<LocalLeader>g', ':Neogit<CR>', {noremap=true})

-- vim-surround
keymap('n', 'ds', '<Plug>Dsurround',  { noremap = false })
keymap('n', 'cs', '<Plug>Csurround',  { noremap = false })
keymap('n', 'cS', '<Plug>CSurround',  { noremap = false })
keymap('n', 's',  '<Plug>Ysurround',  { noremap = false })
keymap('n', 'S',  '<Plug>YSurround',  { noremap = false })
keymap('n', 'ss', '<Plug>Yssurround', { noremap = false })
keymap('n', 'SS', '<Plug>YSsurround', { noremap = false })
keymap('x', 's',  '<Plug>VSurround',  { noremap = false })
keymap('x', 'S',  '<Plug>VgSurround', { noremap = false })
