--------------------------------------------------------------------
-- Main Process
--------------------------------------------------------------------
-- (1) Setup lsp-installer
-- (2) Setup LSP Client
-- (3) Setup UI for Diagnostic
-----------------------------------------------------------
local lsp_installer = safe_require('nvim-lsp-installer')
local lsp_config = safe_require('lspconfig')
if not lsp_installer or not lsp_config then
	return
end

-----------------------------------------------------------------------------------------------
-- (1) Start and setup nvim-lsp-installer
-----------------------------------------------------------------------------------------------
require("nvim-lsp-installer").setup({
    -- automatically detect which servers to install
    -- (based on which servers are set up via lspconfig)
	automatic_installation = true,
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗",
		},
	},
	-- The directory in which to installl servers.
	-- install_root_dir = RUNTIME_DIR .. '/lsp_servers',
	-- install_root_dir = '/Users/alanjui/.local/share/my-nvim' .. '/lsp_servers',
	install_root_dir = RUNTIME_DIR .. '/lsp_servers',
})

-----------------------------------------------------------------------------------------------
-- (2) Setup LSP client for connectting to LSP server
-----------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------
-- on_attach: to map keys after the languate server attaches to the current buffer
-----------------------------------------------------------------------------------------------
-- local on_attach = require('lsp/on-attach') or {}
local on_attach = safe_require("lsp/on-attach")
if not on_attach then
    on_attach = nil
end

-----------------------------------------------------------------------------------------------
-- Capabilities
-----------------------------------------------------------------------------------------------

-- Setup nvim-cmp plugin
require("lsp/auto-cmp")

-- Initial capabilities option for LSP client
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-----------------------------------------------------------------------------------------------
-- Get extra setup options and setup for LSP server
-----------------------------------------------------------------------------------------------
local servers = LSP_SERVERS

for _, lsp in pairs(servers) do
    if lsp == 'cssls' then
        --Enable (broadcasting) snippet capability for completion
        capabilities.textDocument.completion.completionItem.snippetSupport = true
    end

	local setup_opts = {
		on_attach = on_attach,
		capabilities = capabilities,
		flags = { debounce_text_changes = 150 },
	}

	-- Get configuration of specific server
	-- local custom_opts = servers_settings[lsp] or {}
	-- if custom_opts then
	-- 	setup_opts = vim.tbl_deep_extend("force", custom_opts, setup_opts)
	-- end
    local has_custom_opts, lsp_custom_opts = pcall(require, 'lsp.settings.' .. lsp)
    if has_custom_opts then
        setup_opts = vim.tbl_deep_extend('force', lsp_custom_opts, setup_opts)
    end

	lsp_config[lsp].setup(setup_opts)
end

-----------------------------------------------------------------------------------------------
---- (3) Setup UI for Diannostics (Lint)
-----------------------------------------------------------------------------------------------

---- Change diagnostic symbols in the sign column (gutter)
local diagnostic_signs = {
	Error = '',
	Warn  = '',
	Hint  = '',
	Info  = '',
}
--for type, icon in pairs(diagnostic_signs) do
for _, sign in ipairs(diagnostic_signs) do
    vim.fn.sign_define(sign.name, {
        texthl = sign.name,
        text = sign.text,
        numhl = '',
    })
end

---- Customizing how diagnostics are displayed
vim.diagnostic.config({
	-- disable virtual text
	-- virtual_text = false,
	-- virtual_text = true,
	virtual_text = {
		spacing = 4,
		severity_limit = 'Warning',
	},
	-- show signs
	signs = {
		active = diagnostic_signs,
	},
	update_in_insert = true,
    underline = true,
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

---- Setup UI: hover and popup dispalyed contents
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = 'rounded',
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = 'rounded',
})
