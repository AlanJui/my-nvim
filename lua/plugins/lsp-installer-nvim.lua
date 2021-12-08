local lsp_installer = require("nvim-lsp-installer")
-- local on_attach = require('lsp.on_attach').nvim_lsp
local on_attach = require('lsp.on_attach').lsp_saga
local capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)
local system_name = require('utils.env').get_system()

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

    -- Limit for the maximum amount of servers to be installed at the same time. Once this limit is reached, any further
    -- servers that are requested to be installed will be put in a queue.
    max_concurrent_installers = 4,
})

-- Linter setup for `Setup Language Server`
--------------------------------------------------------------------------
--- Linter setup
local filetypes = {
  typescript = "eslint",
  typescriptreact = "eslint",
  -- python = "flake8",
}

local linters = {
  eslint = {
    sourceName = "eslint",
    command = "./node_modules/.bin/eslint",
    rootPatterns = {".eslintrc.js", "package.json"},
    debouce = 100,
    args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
    parseJson = {
      errorsRoot = "[0].messages",
      line = "line",
      column = "column",
      endLine = "endLine",
      endColumn = "endColumn",
      message = "${message} [${ruleId}]",
      security = "severity"
    },
    securities = {[2] = "error", [1] = "warning"}
  },
  -- flake8 = {
  --   command = "flake8",
  --   sourceName = "flake8",
  --   args = {"--format", "%(row)d:%(col)d:%(code)s: %(text)s", "%file"},
  --   formatPattern = {
  --     "^(\\d+):(\\d+):(\\w+):(\\w).+: (.*)$",
  --     {
  --         line = 1,
  --         column = 2,
  --         message = {"[", 3, "] ", 5},
  --         security = 4
  --     }
  --   },
  --   securities = {
  --     E = "error",
  --     W = "warning",
  --     F = "info",
  --     B = "hint",
  --   },
  -- },
}

-- Setup Language Server
--------------------------------------------------------------------------
lsp_installer.on_server_ready(function (server)
    -- Specify the default options which we'll use for all LSP servers
    local default_opts = {
        on_attach = on_attach,
        capabilities = capabilities,
    }
    local lsp_servers_path = vim.fn.stdpath('data') .. '/lsp_servers'

    -- Create a server_opts table where we'll specify our custom LSP server configuration
    local server_opts = {
        ['sumneko_lua'] = function()
            local lua_root_path = vim.fn.stdpath('data') .. '/lsp_servers/sumneko_lua/extension/server/bin/' .. system_name
            local lua_binary = lua_root_path .. '/lua-language-server'
            local runtime_path = vim.split(package.path, ';')
            table.insert(runtime_path, 'lua/?.lua')
            table.insert(runtime_path, 'lua/?/init.lua')

            default_opts.cmd = {
                lua_binary,
                '-E',
                lua_root_path .. '/main.lua',
            }

            default_opts.settings = {
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
            }

            default_opts.on_attach = on_attach
            return default_opts
        end,

        ['pyright'] = function ()
            default_opts.cmd = {
                lsp_servers_path .. "/python/node_modules/.bin/pyright-langserver",
                "--stdio"
            }
            default_opts.filetypes = { "python" }
            default_opts.settings = {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        diagnosticMode = "workspace",
                        useLibraryCodeForTypes = true,
                    }
                }
            }
            default_opts.on_attach = on_attach
            default_opts.capabilities = capabilities

            return default_opts
        end,

        ['tsserver'] = function ()
            default_opts.cmd = {
                lsp_servers_path .. "/tsserver/node_modules/.bin/typescript-language-server",
                "--stdio"
            }

            default_opts.filetypes = {
                'javascript',
                'javascriptreact',
                'typescript',
                'typescriptreact',
            }

            default_opts.on_attach = on_attach
            default_opts.capabilities = capabilities

            return default_opts
        end,

        ['html'] = function ()
            default_opts.cmd = {
                lsp_servers_path .. "/html/node_modules/.bin/vscode-html-language-server",
                "--stdio"
            }
            default_opts.filetypes = {
                "html",
                "htmldjango",
            }
            default_opts.on_attach = on_attach
            default_opts.capabilities = capabilities

            return default_opts
        end,

        ['cssls'] = function ()
            default_opts.cmd = {
                lsp_servers_path .. "/html/node_modules/.bin/vscode-css-language-server",
                "--stdio"
            }
            default_opts.filetypes = {
                "css",
                "scss",
                "less",
            }
            default_opts.on_attach = on_attach
            default_opts.capabilities = capabilities

            return default_opts
        end,

        ['emmet_ls'] = function ()
            local emmet_capabilities = vim.lsp.protocol.make_client_capabilities()
            emmet_capabilities.textDocument.completion.completionItem.snippetSupport = true

            default_opts.cmd = {
                lsp_servers_path .. "/emmet_ls/node_modules/.bin/emmet-ls",
                "--stdio"
            }
            default_opts.filetypes = {
                "html",
                "htmldjango",
                "blade",
                "css",
            }
            default_opts.on_attach = on_attach
            default_opts.capabilities = emmet_capabilities

            return default_opts
        end,

        ['diagnosticls'] = function ()
            default_opts.cmd = {
                lsp_servers_path .. "/diagnosticls/node_modules/.bin/diagnostic-languageserver",
                "--stdio"
            }
            default_opts.filetypes = vim.tbl_keys(filetypes)
            -- default_opts.root_dir = Vim's starting directory
            default_opts.init_options = {
                filetypes = filetypes,
                linters = linters,
            }
            default_opts.on_attach = on_attach
            default_opts.capabilities = capabilities

            return default_opts
        end,
    }

    -- We check to see if any custom server_opts exist for the LSP server, if so, load them,
    -- if not, use our default_opts
    server:setup(server_opts[server.name] and server_opts[server.name]() or default_opts)
    vim.cmd([[
        " do User LspAttachBuffers
        let g:completion_trigger_character = [ '.' ]
    ]])
end)

-- =======================================================================
-- LSP Servers Installation
-- =======================================================================
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
