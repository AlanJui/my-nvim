-----------------------------------------------------------
-- LSP Module
-----------------------------------------------------------
local lsp_installer = safe_require('nvim-lsp-installer')
local lspconfig = safe_require('lspconfig')
if (not lsp_installer) or (not lspconfig) then
    return
end

require('lsp.installer')
require('lsp.manager')
