-- =======================================================================
-- LSP Servers Installation
-- =======================================================================
-- require('lsp.nvim-lsp-installer')
-- Automatically install LSP servers
local lsp_installer = require('nvim-lsp-installer')
local servers = {
	'sumneko_lua',
	'pyright',
	'html',
	'emmet_ls',
	'tsserver',
	'vuels',
	'yamlls',
	'bashls',
}
for _, name in pairs(servers) do
	local ok, server = lsp_installer.get_server(name)
	-- Check that the server is supported in nvim-lsp-installer
	if ok then
		if not server:is_installed() then
			print('Installing ' .. name)
			server:install()
		end
	end
end

-- =======================================================================
-- Language Server Configuration
-- =======================================================================
local cmp = require('cmp')

local on_attach = require('lsp.on_attach').on_attach_saga
local capabilities = require('cmp_nvim_lsp').update_capabilities(
	vim.lsp.protocol.make_client_capabilities()
)

local system_name = require('utils').get_system()

-- Setup completion and snippets engine
--------------------------------------------------------------------------
local lspkind = require('lspkind')

local has_words_before = function ()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function (key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
	formatting = {
		format = lspkind.cmp_format(),
	},
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
		['<C-\\>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		-- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		['<C-e>'] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		-- Snippets shortcut key
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn['vsnip#available']() == 1 then
			  feedkey('<Plug>(vsnip-expand-or-jump)', '')
			elseif has_words_before() then
				cmp.complete()
			else
				-- The fallback function sends a already mapped key. In this case,
			  	-- it's probably `<Tab>`.
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn['vsnip#jumpable'](-1) == 1 then
			  feedkey('<Plug>(vsnip-jump-prev)', '')
			else
				fallback()
			end
		end, { 'i', 's' }),
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' }, -- For vsnip users.
		-- { name = 'luasnip' }, -- For luasnip users.
	}, {
	  { name = 'buffer' },
	})
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

-- Setup comp with lspconfig.
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
-- 	capabilities = capabilities
-- }

-- Setup Language Server
--------------------------------------------------------------------


-- Snippets Engine
--------------------------------------------------------------------------
-- require('lsp.LuaSnip')
-- require('lsp.vim-vsnip')

-- UI Tools
--------------------------------------------------------------------------
-- require('lsp.lspsaga')
