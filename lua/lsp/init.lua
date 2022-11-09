--------------------------------------------------------------------
-- Main Process
--------------------------------------------------------------------
-- (1) Setup configuration of nvim-lspconfig and nvim-cmp
-- (2) Setup LSP Client
-----------------------------------------------------------

-----------------------------------------------------------------------------------------------
-- (1) Configuretion of mason
-----------------------------------------------------------------------------------------------
local mason = safe_require("mason")
if not mason then
    return
end

require('mason.settings').set({
    ui = {
        border = 'rounded'
    }
})

mason.setup({
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
local lsp = require('lsp-zero')

-- local lsp_presets = 'per-project'
local lsp_presets = 'recommended'

if lsp_presets == 'recommended' then
    ---
    --- lsp.preset = recommended
    ---
    lsp.preset('recommended')

    lsp.set_preferences({
        suggest_lsp_servers = true,
        setup_servers_on_start = true,
        set_lsp_keymaps = true,
        configure_diagnostics = true,
        cmp_capabilities = true,
        manage_nvim_cmp = true,
        call_servers = 'local',
        sign_icons = {
            error = '✘',
            warn = ' ',
            hint = '',
            info = ''
        }
    })

    lsp.ensure_installed(LSP_SERVERS)

    lsp.nvim_workspace({
        library = vim.api.nvim_get_runtime_file('', true)
    })

    lsp.setup()
else
    ---
    --- lsp.preset = recommended
    ---

    lsp.preset('recommended')

    lsp.set_preferences({
        suggest_lsp_servers = true,
        setup_servers_on_start = true,
        set_lsp_keymaps = true,
        configure_diagnostics = true,
        cmp_capabilities = true,
        manage_nvim_cmp = true,
        call_servers = 'local',
        sign_icons = {
            error = '✘',
            warn = ' ',
            hint = '',
            info = ''
        }
    })

    lsp.ensure_installed(LSP_SERVERS)

    lsp.nvim_workspace({
        library = vim.api.nvim_get_runtime_file('', true)
    })

    --
    -- Setup configurations for Language Server
    --
    lsp.configure('sumneko_lua', {
        require('lua.lsp.settings.sumneko_lua')
    })
    lsp.configure('pyright', {
        require('lua.lsp.settings.pyright')
    })
    lsp.configure('html', {
        require('lua.lsp.settings.html')
    })
    lsp.configure('texlab', {
        require('lua.lsp.settings.texlab')
    })
    lsp.configure('tsserver', {
        filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
        root_dir = function() return vim.loop.cwd() end
    })
    --
    -- Setup Language Server with .setup_servers() function and Servers List
    --
    local lsp_opts = {
        flags = {
            debounce_text_changes = 150,
        }
    }

    lsp.setup_servers({
        'sumneko_lua',
        'pyright',
        'html',
        'cssls',
        'tsserver',
        opts = lsp_opts
    })
end

------------------------------------------------------------
-- Add Snippets
------------------------------------------------------------

-- Load your own custom vscode style snippets
-- Path format: path/of/your/nvim/config/my-snippets
-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./my-snippets" } })
    -- '~/.config/my-nvim/my-snippets',
SNIPPETS_PATH = {
    CONFIG_DIR .. "/my-snippets",
    RUNTIME_DIR .. "/site/pack/packer/start/friendly-snippets",
}
require('luasnip.loaders.from_vscode').lazy_load({ paths = SNIPPETS_PATH })

require('luasnip').filetype_extend('vimwik', {'markdown'})
require('luasnip').filetype_extend('html', { 'htmldjango' })
