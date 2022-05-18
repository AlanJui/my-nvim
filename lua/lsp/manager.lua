local lspconfig = safe_require('lspconfig')
local lsp_installer = safe_require('nvim-lsp-installer')
if not lspconfig or not lsp_installer then
	return
end

--------------------------------------------------------------------
-- On attach
-- Set up buffer-local keymaps (vim.api.nvim_buf_set_keymap()), etc.
--------------------------------------------------------------------
local function on_attach(client, bufnr)
	-- require('lsp.on-attach')(client, bufnr)
	require('lsp.mini-on-attach')(client, bufnr)
end

--------------------------------------------------------------------
-- Capabilities
--------------------------------------------------------------------
require('lsp/auto-cmp')
local capabilities = vim.lsp.protocol.make_client_capabilities()
if package.loaded['cmp_nvim_lsp'] then
	capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
end

--------------------------------------------------------------------
-- UI: Borders
--------------------------------------------------------------------
vim.cmd([[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]])
vim.cmd([[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]])

local border = {
	{ '╭', 'FloatBorder' },
	{ '─', 'FloatBorder' },
	{ '╮', 'FloatBorder' },
	{ '│', 'FloatBorder' },
	{ '╯', 'FloatBorder' },
	{ '─', 'FloatBorder' },
	{ '╰', 'FloatBorder' },
	{ '│', 'FloatBorder' },
}

-- LSP settings (for overriding per client)
local handlers = {
	['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
	['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

--------------------------------------------------------------------
-- Main Process
--------------------------------------------------------------------
local servers = {
	'sumneko_lua',
	'texlab',
	'pyright',
	'emmet_ls',
	'html',
	'jsonls',
}

-- Settings for servers
local servers_settings = require('lsp.servers-settings')

for _, lsp in pairs(servers) do
	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
		handlers = handlers,
		flags = {
			debounce_text_changes = 150,
		},
	}

	-- Get configuration of specific server
	local custom_opts = servers_settings[lsp] or {}
	if custom_opts then
		opts = vim.tbl_deep_extend('force', custom_opts, opts)
	end
	require('lspconfig')[lsp].setup(opts)
end

-- require('lspconfig').sumneko_lua.setup({
--     on_attach = on_attach,
--     settings = {
--         Lua = {
--             runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
--             completion = { keywordSnippet = 'Disable' },
--             diagnostics = {
--                 enable = true,
--                 globals = {
--                     'vim',
--                     'describe',
--                     'it',
--                     'before_each',
--                     'after_each',
--                 },
--             },
--             workspace = {
--                 library = {
--                     [vim.fn.expand('$VIMRUNTIME/lua')] = true,
--                     [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
--                 },
--             },
--         },
--     },
-- })
