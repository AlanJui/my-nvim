-- require('auto-cmp.nvim-cmp')
-- require('auto-cmp.luasnip')

------------------------------------------------------------
-- Setup nvim-cmp
------------------------------------------------------------

local luasnip = safe_require('luasnip')
local cmp = safe_require('cmp')

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
	local col = vim.fn.col('.') - 1
	if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
		return true
	else
		return false
	end
end

_G.tab_complete = function()
	if cmp and cmp.visible() then
		cmp.select_next_item()
	elseif luasnip and luasnip.expand_or_jumpable() then
		return t('<Plug>luasnip-expand-or-jump')
	elseif check_back_space() then
		return t('<Tab>')
	else
		cmp.complete()
	end
	return ''
end
_G.s_tab_complete = function()
	if cmp and cmp.visible() then
		cmp.select_prev_item()
	elseif luasnip and luasnip.jumpable(-1) then
		return t('<Plug>luasnip-jump-prev')
	else
		return t('<S-Tab>')
	end
	return ''
end

vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', { expr = true })
vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', { expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
vim.api.nvim_set_keymap('i', '<C-E>', '<Plug>luasnip-next-choice', {})
vim.api.nvim_set_keymap('s', '<C-E>', '<Plug>luasnip-next-choice', {})

------------------------------------------------------------
-- Add Snippets
------------------------------------------------------------

-- Load Vscode-like snippets:
-- To use existing vs-code style snippets from a plugin
-- (eg. rafamadriz/friendly-snippets)
--
require('luasnip.loaders.from_vscode').lazy_load()

-- Load your own custom vscode style snippets
-- Path format: path/of/your/nvim/config/my-snippets
-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./my-snippets" } })
require('luasnip.loaders.from_vscode').lazy_load({ paths = { '~/.config/my-nvim/my-snippets/' } })

-- enable html snippets in javascript/javascript(REACT)
-- luasnip.snippets.javascript = luasnip.snippets.html
-- luasnip.snippets.javascriptreact = luasnip.snippets.html
-- luasnip.snippets.typescriptreact = luasnip.snippets.html

-- enable  html snippets in htmldjango(Django Template)
-- luasnip.snippets.htmldjango = luasnip.snippets.html

-- You can also use lazy loading so you only get in memory snippets of languages you use
-- require'luasnip/loaders/from_vscode'.lazy_load()

-- -- snippets_path ="~/.config/nvim/my-snippets",
-- require('luasnip/loaders/from_vscode').load({
--     include = {
--         'html',
--         'htmldjango',
--         'python',
--         'css',
--         'javascript',
--         'typescript',
--     },
--     paths = {
--         '~/.config/my-nvim/my-snippets',
--         -- "~/.local/share/nvim/site/pack/packer/start/friendly-snippets",
--     },
-- })

-- Tells LuaSnip that for a buffer with ft=filetype, snippets from
-- extend_filetypes should be searched as well.
-- filetype_extend(filetype, extend_filetypes)
-- Example: luasnip.filetype_extend("lua", {"c", "cpp"})

luasnip.filetype_extend('htmldjango', { 'html' })
