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
        -- autocmd BufWritePost lua/plugins/init.lua source <afile> | PackerCompile
require('plugins')
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost ~/.config/web-nvim/nvim/lua/plugins/init.lua source <afile> | PackerCompile
    augroup end
]])

-- Configurations for Neovim
-----------------------------------------------------------
-- require('lsp')
require('configs')

-- Themes
vim.o.termguicolors = true
-- vim.cmd([[ colorscheme solarized8_flat ]])
-- vim.cmd([[ colorscheme solarized8 ]])
-- vim.cmd([[ colorscheme rvcs ]])
-- vim.cmd([[ colorscheme nightfly ]])
-- vim.cmd([[ colorscheme moonfly ]])
-- vim.cmd([[ colorscheme OceanicNext ]])

-- Tokyo Night Color Scheme Configuration
vim.cmd([[ colorscheme tokyonight ]])
-- vim.g.tokyonight_style = 'day'
-- vim.g.tokyonight_style = 'night'
vim.g.tokyonight_style = 'storm'
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = {
    'qf',
    'vista_kind',
    'terminal',
    'packer',
}
-- Change the "hint" color to the "orange" color,
-- and make the "error" color bright red
vim.g.tokyonight_colors = {
    hint = 'orange',
    error = '#ff0000'
}

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

