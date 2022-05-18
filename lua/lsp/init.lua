--------------------------------------------------------------------
-- Main Process
--------------------------------------------------------------------
-- (1) Setup lsp-installer
-- (2) Setup LSP Client
-- (3) Setup UI for Diagnostic
-----------------------------------------------------------
local lsp_installer = safe_require('nvim-lsp-installer')
local lspconfig = safe_require('lspconfig')
if not lsp_installer or not lspconfig then
	return
end

--------------------------------------------------------------------
-- (1) Setup lsp-instller
--------------------------------------------------------------------
require('nvim-lsp-installer').setup({
	-- automatically detect which servers to install
	automatic_installation = true,
	ui = {
		-- (based on which servers are set up via lspconfig)
		icons = {
			server_installed = '✓',
			server_pending = '➜',
			server_uninstalled = '✗',
		},
	},
	-- The directory in which to installl servers.
	install_root_dir = RUNTIME_DIR .. '/lsp_servers',
})

--------------------------------------------------------------------
-- (2) Setup LSP Client
--------------------------------------------------------------------
-- Setup Language Servers
require('lsp/manager')

-- Setup null-ls for layout formatting, diagnosticing (language linting)
require('lsp/null-langserver')

--------------------------------------------------------------------
-- (3) Setup UI for Diannostics
--------------------------------------------------------------------

-- Change diagnostic symbols in the sign column (gutter)
local diagnostic_signs = {
	Error = '',
	Warn = '',
	Hint = '',
	Info = '',
}
for type, icon in pairs(diagnostic_signs) do
	local hl = 'DiagnosticSign' .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Customizing how diagnostics are displayed
vim.diagnostic.config({
	underline = true,
	-- disable virtual text
	-- virtual_text = false,
	-- virtual_text = true,
	virtual_text = {
		spacing = 2,
		severity_limit = 'Warning',
	},
	-- show signs
	signs = {
		active = diagnostic_signs,
	},
	update_in_insert = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = 'minimal',
		border = 'rounded',
		source = 'always',
		header = '',
		prefix = '',
	},
})

-- Setup UI: hover and popup dispalyed contents
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = 'rounded',
})
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = 'rounded',
})

-- Print diagnostics to message area
-- local PrintDiagnostics = require('lsp.print_diagnostics')
-- vim.cmd [[ autocmd CursorHold * lua PrintDiagnostics() ]]
-- Use floating popup window to display diagnostics from Language Server: Ref: on_attach

-- Show line diagnostics automatically in hover window
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 250
vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])

-- require('lspconfig').texlab.setup({
-- 	cmd = { 'texlab' },
-- 	filetypes = { 'tex', 'bib' },
-- 	settings = {
-- 		texlab = {
-- 			rootDirectory = nil,
-- 			--      ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓
-- 			build = _G.TeXMagicBuildConfig,
-- 			--      ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑
-- 			forwardSearch = {
-- 				executable = 'evince',
-- 				args = { '%p' },
-- 			},
-- 		},
-- 	},
-- })

--require('lspconfig').pyright.setup({
--	handlers = {
--		['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--			--Disable virtual_text
--			virtual_text = {
--				spacing = 2,
--				severity_limit = 'Warning',
--			},
--			-- Enable signs
--			-- signs = true,
--			signs = false,
--			-- Disable hint
--			-- tagSupport = 'Unnecessary',
--			tagSupport = true,
--		}),
--	},
--})
