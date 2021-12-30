local lspconfig = safe_require('lspconfig')
local lsp_installer = safe_require('nvim-lsp-installer')
if (not lspconfig) or (not lsp_installer) then
    return
end

--------------------------------------------------------------------
-- Format
--------------------------------------------------------------------
local format_config = require('lsp.format')

--------------------------------------------------------------------
-- On attach
--------------------------------------------------------------------
local on_attach = require('lsp.on-attach')

--------------------------------------------------------------------
-- UI
------- -------------------------------------------------------------
local function symbols_override()
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
end

--------------------------------------------------------------------
-- setup
--------------------------------------------------------------------
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local servers = {
    sumneko_lua = {
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                    -- Setup your lua path
                    path = runtime_path,
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {'vim'},
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
    },
    emmet_ls = {
        filetypes = {
            'html',
            'htmldjango',
            'css'
        },
        single_file_support = true,
    },
    html = {
        filetypes = { 'html', 'htmldjango' },
        init_options = {
            configurationSection = { 'html', 'htmldjango', 'css', 'javascript', },
            embeddedLanguages = {
                css = true,
                javascript = true,
            }
        },
        settings = {},
        single_file_support = true,
    },
    jsonls = {
        filetypes = { 'json', 'jsonc', },
        init_options = {
            provideFormatter = true,
        },
        single_file_support = true,
    },
    pyright = {
        filetypes = { 'python' },
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = 'workspace',
                    useLibraryCodeForTypes = true,
                },
            },
        },
        single_file_support = true,
    },

}

local function get_config(server_name)
    local config = servers[server_name] or {}
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    if package.loaded['cmp_nvim_lsp'] then
        capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
    end
    config.on_attach = on_attach
    return config
end

--------------------------------------------------------------------
-- Main Process
--------------------------------------------------------------------
symbols_override()
require('nvim-lsp-installer').on_server_ready(function(server)
    server:setup(get_config(server.name))
    vim.cmd [[ do User LspAttachBuffers ]]
end)
