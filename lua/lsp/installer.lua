-- =======================================================================
-- LSP Servers Installation
-- Automatically install LSP servers
-- =======================================================================
if DEBUG then print('<< Loading plugin: nvim-lsp-installer >>') end

local lsp_installer = safe_require("nvim-lsp-installer")
if not lsp_installer then
    if DEBUG then print('<< Loading plugin ERROR: nvim-lsp-installer >>') end
    return
end

--------------------------------------------------------------------------
-- Provide settings first!
--------------------------------------------------------------------------
lsp_installer.settings({
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗",
        },
    },

    -- The directory in which to installl servers.
    install_root_dir = RUNTIME_DIR .. '/lsp_servers',

    -- Limit for the maximum amount of servers to be installed at the same time. Once this limit is reached, any further
    -- servers that are requested to be installed will be put in a queue.
    max_concurrent_installers = 4,
})

--------------------------------------------------------------------------
-- LSP Servers Installation
--------------------------------------------------------------------------
-- Automatically install LSP servers
-- local lsp_installer = require('nvim-lsp-installer')
local servers = {
    'sumneko_lua',
    'diagnosticls',
    'pyright',
    'emmet_ls',
    'html',
    'cssls',
    'jsonls',
    'eslint',
    'tsserver',
    'vuels',
    'yamlls',
    'bashls',
    'dockerls',
    'sqlls',
    'lemminx',  -- XML
}
if DEBUG then print('<< Loading plugin: Begin of LSP Server Install >>') end
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
if DEBUG then print('<< Loading plugin: End of LSP Server Install >>') end
