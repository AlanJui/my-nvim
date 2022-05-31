-----------------------------------------------------------
-- Initial environments for Neovim
-----------------------------------------------------------
DEBUG = false
MY_VIM = 'my-nvim'
HOME = os.getenv('HOME')

CONFIG_DIR = HOME .. '/.config/' .. MY_VIM
RUNTIME_DIR = HOME .. '/.local/share'

PACKAGE_ROOT = RUNTIME_DIR .. '/site/pack'
INSTALL_PATH = PACKAGE_ROOT .. '/packer/start/packer.nvim'
COMPILE_PATH = CONFIG_DIR .. '/plugin/packer_compiled.lua'

INSTALLED = false
LSP_SERVERS = {
    'sumneko_lua',
    'texlab',
    'pyright',
    'emmet_ls',
    'html',
    'jsonls',
    'rust_analyzer',
    'tsserver',
}

-----------------------------------------------------------
-- Initial environment
-----------------------------------------------------------

-- Join path
local on_windows = vim.loop.os_uname().version:match 'Windows'
local function join_paths(...)
    local path_sep = on_windows and '\\' or '/'
    local result = table.concat({ ... }, path_sep)
    return result
end

-- Setup runtimepath: stdpath('config'), stdpath('data')
local function setup_rtp()
    vim.cmd [[
        "set runtimepath^=RUNTIME_DIR
        set runtimepath+=(CONFIG_DIR)
        set runtimepath+=(CONFIG_DIR..'/after')
        set runtimepath+=(CONFIG_DIR..'/lua')
    ]]
    vim.cmd [[let &packpath = &runtimepath]]
end

local package_root = join_paths(RUNTIME_DIR, MY_VIM, 'site', 'pack')
local install_path = join_paths(package_root, 'packer', 'start', 'packer.nvim')
local compile_path = join_paths(CONFIG_DIR, 'plugin', 'packer_compiled.lua')
-- print('$VIMRUNTIME=' .. os.getenv('VIMRUNTIME'))
-- print('package_root=' .. package_root)
-- print('install_path=' .. install_path)
-- print('compile_path=' .. compile_path)

-- setup_rtp()


-----------------------------------------------------------
-- Local functions
-----------------------------------------------------------

_G.load_config = function()
    -- vim.lsp.set_log_level 'trace'
    -- if vim.fn.has 'nvim-0.5.1' == 1 then
    --     require('vim.lsp.log').set_format_func(vim.inspect)
    -- end
    local nvim_lsp = require 'lspconfig'
    local on_attach = function(_, bufnr)
        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end
        local function buf_set_option(...)
            vim.api.nvim_buf_set_option(bufnr, ...)
        end

        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        local opts = { noremap = true, silent = true }
        buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
        buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
        buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    end

    -- Add the server that troubles you here
    local name = 'pyright'
    local cmd = { 'pyright-langserver', '--stdio' } -- needed for elixirls, omnisharp, sumneko_lua
    if not name then
        print 'You have not defined a server name, please edit minimal_init.lua'
    end
    if not nvim_lsp[name].document_config.default_config.cmd and not cmd then
        print [[You have not defined a server default cmd for a server
        that requires it please edit minimal_init.lua]]
    end

    nvim_lsp[name].setup {
        cmd = cmd,
        on_attach = on_attach,
    }

    print [[You can find your log at $HOME/.cache/nvim/lsp.log. Please paste in a github issue under a details tag as described in the issue template.]]
end

-----------------------------------------------------------
-- Global Functions
-----------------------------------------------------------
vim.api.nvim_command('luafile ~/.config/my-nvim/lua/globals.lua')

-----------------------------------------------------------
-- Plugin Manager: install plugins
-----------------------------------------------------------
-- require('plugins')
vim.api.nvim_command('luafile ~/.config/my-nvim/lua/plugins/init.lua')

-- configure Neovim to automatically run :PackerCompile whenever
-- plugin-list.lua is updated with an autocommand:
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost ~/.config/my-nvim/lua/plugins/init.lua source <afile> | PackerCompile
augroup end
]])

-----------------------------------------------------------
-- configuration of plugins
-----------------------------------------------------------
-- require('plugins/nvim-treesitter')
vim.api.nvim_command('luafile ~/.config/my-nvim/lua/plugins/nvim-treesitter.lua')
require('lsp/luasnip')
require('lsp')
require('lsp/null-langserver')
require('debug')

-- _G.load_config()

-----------------------------------------------------------
-- Configurations for Neovim
-----------------------------------------------------------
vim.api.nvim_command('luafile ~/.config/my-nvim/lua/options.lua')
-- require('options')
require('settings')

-----------------------------------------------------------
-- Color Themes
-----------------------------------------------------------
require('color-themes')

-----------------------------------------------------------
-- Key bindings
-----------------------------------------------------------
-- Load Shortcut Key
-- require('keymaps')
vim.api.nvim_command('luafile ~/.config/my-nvim/lua/keymaps.lua')

-- Load Which-key
-- require('plugins/which-key')
vim.api.nvim_command('luafile ~/.config/my-nvim/lua/plugins/which-key.lua')
-- if INSTALLED then
--     require('plugins.which-key')
-- end

-----------------------------------------------------------
-- Experiments
-----------------------------------------------------------

