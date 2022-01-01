local lspconfig = safe_require('lspconfig')
local lsp_installer = safe_require('nvim-lsp-installer')
if (not lspconfig) or (not lsp_installer) then
    return
end

--------------------------------------------------------------------
-- On attach
-- Set up buffer-local keymaps (vim.api.nvim_buf_set_keymap()), etc.
--------------------------------------------------------------------
local function on_attach(client, bufnr)
    require('lsp.on-attach')(client, bufnr)
end

--------------------------------------------------------------------
-- Capabilities
--------------------------------------------------------------------
local capabilities = vim.lsp.protocol.make_client_capabilities()
if package.loaded['cmp_nvim_lsp'] then
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
end

--------------------------------------------------------------------
-- UI: Borders
--------------------------------------------------------------------
vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

local border = {
      {"╭", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╮", "FloatBorder"},
      {"│", "FloatBorder"},
      {"╯", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╰", "FloatBorder"},
      {"│", "FloatBorder"},
}

-- LSP settings (for overriding per client)
local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
}

--------------------------------------------------------------------
-- Settings for servers
--------------------------------------------------------------------
local servers = require('lsp.servers-settings')

--------------------------------------------------------------------
-- Get configuration of specific server
--------------------------------------------------------------------
local function get_config(server_name)
    -- Specify the default options which we'll use to setupll servers
    local config = servers[server_name] or {}
    config.on_attach = on_attach
    config.capabilities = capabilities
    config.border = border
    config.handlers = handlers
    return config
end

--------------------------------------------------------------------
-- Main Process
--------------------------------------------------------------------
lsp_installer.on_server_ready(function(server)
    server:setup(get_config(server.name))
    vim.cmd [[ do User LspAttachBuffers ]]
end)
