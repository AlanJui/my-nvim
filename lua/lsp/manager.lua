local lspconfig = safe_require('lspconfig')
local lsp_installer = safe_require('nvim-lsp-installer')
if (not lspconfig) or (not lsp_installer) then
    return
end

--------------------------------------------------------------------
-- UI
------- -------------------------------------------------------------
local function setup_diagnostic_config()
    --define diagnostic icon
    local diagnostic_signs = {
        Error = '',
        Warning = '',
        Hint = '',
        Information = ''
    }
    for type, icon in pairs(diagnostic_signs) do
        local hl = 'LspDiagnosticsSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    local config = {
        -- disable virtual text
        virtual_text = false,
        -- show signs
        signs = {
            active = diagnostic_signs,
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)
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
    return config
end

--------------------------------------------------------------------
-- Main Process
--------------------------------------------------------------------
setup_diagnostic_config()
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
})
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'rounded',
})

lsp_installer.on_server_ready(function(server)
    server:setup(get_config(server.name))
    vim.cmd [[ do User LspAttachBuffers ]]
end)
