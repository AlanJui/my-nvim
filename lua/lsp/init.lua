-- configs for the Nvim LSP Client
local lspconfig = _G.safe_require("lspconfig")
-- LSP 安裝工具
local mason = _G.safe_require("mason")
-- Mason 輔助工具，用以協同作業，使透過 Mason 所安裝之 Nvim LSP Client
-- ，能以便捷之方式，完成 LSP Config 設定作業。
local mason_lspconfig = _G.safe_require("mason-lspconfig")
local mason_tool_installer = _G.safe_require("mason-tool-installer")
local cmp = _G.safe_require("cmp")
local luasnip = _G.safe_require("luasnip")
local lspkind = _G.safe_require("lspkind")
local lspsaga = _G.safe_require("lspsaga")

if not lspconfig or not mason or not mason_lspconfig or not mason_tool_installer then
    return
end

if not cmp or not luasnip or not lspkind then
    return
end

------------------------------------------------------------------------
-- Variables for this Module
------------------------------------------------------------------------
local nvim_config = _G.GetConfig()

------------------------------------------------------------------------
-- Automatic LSP Setup
-- It's important that you set up the plugins in the following order:
--
-- 1. mason.nvim
-- 2. mason-lspconfig.nvim
-- 3. Setup servers via lspconfig
------------------------------------------------------------------------
local LSP_SERVERS = {
    "lua_ls",
    "vimls",
    "diagnosticls",
    "pyright",
    "emmet_ls",
    "html",
    "cssls",
    "tailwindcss",
    "tsserver",
    "eslint",
    "jsonls",
    "stylelint_lsp",
    "texlab",
    "bashls",
}

---@diagnostic disable-next-line: unused-local
local mason_tool_installer_ensure_installed_list = {
    "lua-language-server",
    "diagnostic-languageserver",
    "pyright",
    "pylint",
    "debugpy",
    "tailwindcss-language-server",
    "prettier",
    "typescript-language-server",
    "json-lsp",
    "eslint-lsp",
}

local function setup_lsp_client_environment()
    --
    -- Mason: Easily install and manage LSP servers, DAP servers, linters, and formatters.
    --
    mason.setup({
        install_root_dir = nvim_config["runtime"] .. "/mason",
        ui = {
            icons = {
                server_installed = "✓",
                server_pending = "➜",
                server_uninstalled = "✗",
            },
        },
    })

    -- `mason-lspconfig` provides extra, opt-in, functionality that allows you to
    -- automatically set up LSP servers installed via `mason.nvim` without having to
    -- manually add each server setup to your Neovim configuration. It also makes it
    -- possible to use newly installed servers without having to restart Neovim!
    mason_lspconfig.setup({
        ensure_installed = LSP_SERVERS,
        -- auto-install configured servers (with lspconfig)
        automatic_installation = false,
    })

    -- 2023-04-09: 由於目前尚無法百分之百確認，mason_lspconfig 與 mason_tool_installer
    -- 分工的界限；且兩者皆有自動安裝 LSP Client 的功能，恐有作業時會相互影響
    -- 之問題發生，故暫先停用 mason_tool_installer 插件。
    -- mason_tool_installer.setup({
    --     -- a list of all tools you want to ensure are installed upon
    --     -- start; they should be the names Mason uses for each tool
    --     ensure_installed = mason_tool_installer_ensure_installed_list,
    --     -- if set to true this will check each tool for updates. If updates
    --     -- are available the tool will be updated. This setting does not
    --     -- affect :MasonToolsUpdate or :MasonToolsInstall.
    --     -- Default: false
    --     auto_update = true,
    --     -- automatically install / update on startup. If set to false nothing
    --     -- will happen on startup. You can use :MasonToolsInstall or
    --     -- :MasonToolsUpdate to install tools and check for updates.
    --     -- Default: true
    --     run_on_start = true,
    --     -- set a delay (in ms) before the installation starts. This is only
    --     -- effective if run_on_start is set to true.
    --     -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
    --     -- Default: 0
    --     start_delay = 3000, -- 3 second delay
    -- })
end

------------------------------------------------------------------------
-- Setup configuration for every LSP
------------------------------------------------------------------------
local function setup_lsp_client()
    ------------------------------------------------------------------------
    -- Keybindings
    ------------------------------------------------------------------------
    -- local keymap = vim.keymap -- for conciseness
    --
    -- enable keybinds only for when lsp server available
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    -- local opts = { noremap = true, silent = true }
    -- keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
    -- keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    -- keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    -- keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
    --
    -- local lsp_attach = require("lsp/lsp-on-attach").key_bindings()

    --
    -- 使用 LSP Saga 代替 LSP Key Bindings
    --
    ---@diagnostic disable-next-line: unused-local
    local lsp_attach = function(client, bufnr) end -- luacheck: ignore

    ------------------------------------------------------------------------
    -- Setup lspconfig with setup_handlers of mason-ispconfig
    ------------------------------------------------------------------------
    local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- require("mason-lspconfig").setup_handlers({
    mason_lspconfig.setup_handlers({
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
            lspconfig[server_name].setup({
                on_attach = lsp_attach,
                capabilities = lsp_capabilities,
            })
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        -- ["rust_analyzer"] = function ()
        --     require("rust-tools").setup {}
        -- end,
        ["lua_ls"] = function()
            -- lspconfig.lua_ls.setup(
            --     require("lsp/settings/lua_ls").setup(lsp_attach, lsp_capabilities)
            -- )
            lspconfig.lua_ls.setup({
                on_attach = lsp_attach,
                capabilities = lsp_capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim", "hs" },
                        },
                    },
                },
            })
        end,
        ["emmet_ls"] = function()
            lspconfig.emmet_ls.setup({
                on_attach = lsp_attach,
                capabilities = lsp_capabilities,
                filetypes = {
                    "htmldjango",
                    "html",
                    "css",
                    "scss",
                    "typescriptreact",
                    "javascriptreact",
                    "markdown",
                },
                init_options = {
                    html = {
                        options = {
                            -- For possible options,
                            -- see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                            ["bem.enabled"] = true,
                        },
                    },
                },
            })
        end,
        ["pyright"] = function()
            lspconfig.pyright.setup(require("lsp/settings/pyright").setup(lsp_attach, lsp_capabilities))
        end,
        ["tsserver"] = function()
            lspconfig.tsserver.setup(require("lsp/settings/tsserver").setup(lsp_attach, lsp_capabilities))
        end,
        ["jsonls"] = function()
            lspconfig.jsonls.setup(require("lsp/settings/jsonls").setup(lsp_attach, lsp_capabilities))
        end,
        ["texlab"] = function()
            lspconfig.texlab.setup(require("lsp/settings/texlab").setup(lsp_attach, lsp_capabilities))
        end,
    })
end

------------------------------------------------------------
-- Setup Diagnostics
------------------------------------------------------------
local function setup_diagnostics()
    ---@diagnostic disable-next-line: redefined-local
    local sign = function(opts) -- luacheck: ignore
        vim.fn.sign_define(opts.name, {
            texthl = opts.name,
            text = opts.text,
            numhl = "",
        })
    end

    sign({ name = "DiagnosticSignError", text = "✘" })
    sign({ name = "DiagnosticSignWarn", text = " " })
    sign({ name = "DiagnosticSignHint", text = "" })
    sign({ name = "DiagnosticSignInfo", text = "" })

    vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

    vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
end

------------------------------------------------------------
-- Processes of Module
------------------------------------------------------------

-- (1) 設定 Auto Completion (Auto-cmp and snippets setup: cmp.nvim + luasnip)
-- require("lsp/lsp-autocmp-copilot")
require("plugins-rc/copilot")
require("lsp/lsp-autocmp")

-- (2) 設定 LSP 自動安裝機制 (Automatic LSP Setup)
setup_lsp_client_environment()

-- (3) 設定 LSP (Setup configuration for every LSP)
setup_lsp_client()

-- (4) 設定 Null Languager Server (Null-LS Setup)
require("lsp/lsp-null-ls").setup()

-- (5) 設定 LSP Diagnostics (Setup Diagnostics)
setup_diagnostics()

-- (6) 設定 Lsp Saga
require("plugins-rc/lspsaga-nvim")

-- (7) 令 Null Server 有最高使用權
-- local function select_lsp(client_id)
--     if client_id == 4 then -- null-ls 的客戶端 ID
--         return 1
--     end
--     return 0
-- end
--
-- vim.cmd([[
--   autocmd User lsp_setup call lsp#register_server({
--       \ 'name': 'null-ls',
--       \ 'priority': 100,
--       \ 'whitelist': ['markdown'],
--       \ 'config': {
--       \   'config_callback': v:lua.select_lsp,
--       \}})
-- ]])
