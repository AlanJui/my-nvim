-- Essential configuration on development init.lua
-----------------------------------------------------------
-- Display line number on side bar
vim.wo.number = true
vim.wo.relativenumber = true
-- Disable line wrap
vim.opt.textwidth = 0
vim.opt.wrapmargin = 0
vim.wo.wrap = false
-- Tabs
vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.cmd([[
autocmd FileType lua setlocal expandtab shiftwidth=4 tabstop=4 smartindent
autocmd BufEnter *.lua set autoindent expandtab shiftwidth=4 tabstop=4
]])
-- Reformat indent line
-- gg=G
vim.cmd([[
command! -range=% Format :<line1>,<line2>s/^\s*/&&
]])


-- Plugin Manager: install plugins
-----------------------------------------------------------
require('plugins')

-- Configurations for Neovim
-----------------------------------------------------------
-- require('lsp')
require('configs')

-- Themes
vim.o.termguicolors = true
vim.cmd([[ colorscheme solarized8_flat ]])
-- vim.cmd([[ colorscheme solarized8 ]])
-- vim.cmd([[ colorscheme rvcs ]])
-- vim.cmd([[ colorscheme OceanicNext ]])
-- vim.cmd([[ colorscheme nightfly ]])
-- vim.cmd([[ colorscheme moonfly ]])

-- Key bindings
-----------------------------------------------------------
require('keymaps')

-- Experiment
-----------------------------------------------------------
-- require'nvim-web-devicons'.setup {
--     -- your personnal icons can go here (to override)
--     -- DevIcon will be appended to `name`
--     override = {
--         lua = {
--             icon = "",
--             color = "#428850",
--             name = "Lua"
--         }
--     };
--     -- globally enable default icons (default to false)
--     -- will get overriden by `get_icons` option
--     default = true;
-- }
-- vim.cmd([[
-- autocmd BufWritePre *.py lua vim.lsp.buf.formatting()
--
-- " change popup menu color for non selected items
-- highlight Pmenu ctermfg=lightgrey ctermbg=black
--
-- " change popup menu color for selected item
-- highlight PmenuSel ctermfg=white ctermbg=gray
-- ]])

