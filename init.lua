-----------------------------------------------------------
-- Initial environments for Neovim
-----------------------------------------------------------
DEBUG = false
MY_VIM = 'my-nvim'
HOME = os.getenv('HOME')

CONFIG_DIR = HOME .. '/.config/' .. MY_VIM
RUNTIME_DIR = HOME .. '/.local/share/' .. MY_VIM

PACKAGE_ROOT = RUNTIME_DIR .. '/site/pack'
INSTALL_PATH = PACKAGE_ROOT .. '/packer/start/packer.nvim'
COMPILE_PATH = CONFIG_DIR .. '/plugin/packer_compiled.lua'

INSTALLED = false
if vim.fn.empty(vim.fn.glob(INSTALL_PATH)) == 0 then
    INSTALLED = true
end

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
-- Global Functions
-----------------------------------------------------------
vim.api.nvim_command('luafile ~/.config/my-nvim/lua/globals.lua')

-----------------------------------------------------------
-- Initial environment
-----------------------------------------------------------

-- Setup runtimepath(rtp): stdpath('config'), stdpath('data')
local function setup_rtp()
    vim.opt.rtp:remove(join_paths(vim.fn.stdpath('data'), 'site'))
    vim.opt.rtp:remove(join_paths(vim.fn.stdpath('data'), 'site', 'after'))
    vim.opt.rtp:prepend(join_paths(RUNTIME_DIR, 'site'))
    vim.opt.rtp:append(join_paths(RUNTIME_DIR, 'site', 'after'))

    vim.opt.rtp:remove(vim.fn.stdpath('config'))
    vim.opt.rtp:remove(join_paths(vim.fn.stdpath('config'), 'after'))
    vim.opt.rtp:prepend(CONFIG_DIR)
    vim.opt.rtp:append(join_paths(CONFIG_DIR, 'after'))

    vim.cmd [[let &packpath = &runtimepath]]

    -- vim.cmd [[
    --     set runtimepath^=RUNTIME_DIR
    --     set runtimepath+=(CONFIG_DIR)
    --     set runtimepath+=(CONFIG_DIR..'/after')
    -- ]]
    -- vim.cmd [[set runtimepath+=RUNTIME_DIR]]
    -- vim.cmd [[let &packpath = &runtimepath]]
end

-- P(vim.api.nvim_list_runtime_paths())
Print_table(vim.opt.runtimepath:get())
print('-----------------------------------------------------------')

setup_rtp()

Print_table(vim.opt.runtimepath:get())
print('-----------------------------------------------------------')
-- P(vim.api.nvim_list_runtime_paths())

-----------------------------------------------------------
-- Install Plugin Manager & Plugins / Load Plugins
-----------------------------------------------------------
-- vim.api.nvim_command('luafile ~/.config/my-nvim/lua/plugins/init.lua')
require('plugins')

-- configure Neovim to automatically run :PackerCompile whenever
-- plugins.lua is updated with an autocommand:
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])

-----------------------------------------------------------
-- configuration of plugins
-----------------------------------------------------------
if DEBUG then
    require('lsp.lsp-debug')
    _G.load_config()
elseif INSTALLED then
    -- Neovim kernel
    require('plugins-rc.nvim-treesitter')
    require('lsp.luasnip')
    -- lsp
    require('lsp')
    require('lsp.null-langserver')
    -- User Interface
    require('plugins-rc.nvim-web-devicons')
    require('plugins-rc.telescope-nvim')
    require('plugins-rc.nvim-tree')
    require('plugins-rc.nvim-lightbulb')
    require('plugins-rc.tabline')
    -- status line
    -- require('plugins-rc.lspstatus')
    require('plugins-rc.lualine.material')
    -- git
    require('plugins-rc.gitsigns')
    require('plugins-rc.neogit')
    require('plugins-rc.vim-gist')
    -- editting tools
    require('plugins-rc.indent-blankline')
    require('plugins-rc.autopairs')
    require('plugins-rc.undotree')
    vim.cmd [[ runtime ./lua/plugins-rc/vim-better-whitespace.rc.vim ]]
    vim.cmd [[runtime ./lua/plugins-rc/emmet-vim.rc.vim]]
    vim.cmd [[runtime ./lua/plugins-rc/vim-closetag.rc.vim]]
    vim.cmd [[runtime ./lua/plugins-rc/tagalong-vim.rc.vim]]
    -- debug
    require('plugins-rc.ultest')
    require('debug')
    -- Utilities
    vim.cmd [[ runtime ./lua/plugins-rc/vim-instant-markdown.rc.vim ]]
    vim.cmd [[ runtime ./lua/plugins-rc/plantuml-previewer.rc.vim ]]
end

-----------------------------------------------------------
-- Configurations for Neovim
-----------------------------------------------------------
require('options')
require('settings')

-----------------------------------------------------------
-- Color Themes
-----------------------------------------------------------
require('color-themes')

-----------------------------------------------------------
-- Key bindings
-----------------------------------------------------------
-- Load Shortcut Key
require('keymaps')

-- Load Which-key
require('plugins-rc.which-key')

-----------------------------------------------------------
-- Experiments
-----------------------------------------------------------
