-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
MY_VIM = 'web-nvim'
DEBUG = false
-- DEBUG = true

if DEBUG then print('===== Begin of loading init.lua... =====') end
-----------------------------------------------------------
-- Global Functions
-----------------------------------------------------------
PATH_SEPERATOR = vim.loop.os_uname().version:match "Windows" and "\\" or "/"

function Is_empty(str)
	return str == nil or str == ''
end

function Join_paths(...)
    local result = table.concat({ ... }, PATH_SEPERATOR) return result
end

function Print_rtp()
    print(string.format('rtp = %s', vim.opt.rtp['_value']))
end

function Print_table(a_table)
    for k, v in pairs(a_table) do
        print('key = ', k, "    value = ", v)
    end
end

-----------------------------------------------------------
-- Initial environment
-----------------------------------------------------------
-- require('init_env')
HOME = os.getenv('HOME')

CONFIG_DIR = os.getenv('MY_CONFIG_DIR')
if Is_empty(CONFIG_DIR) then
  CONFIG_DIR = HOME .. '/.config/' .. MY_VIM
end

RUNTIME_DIR = os.getenv('MY_RUNTIME_DIR')
if Is_empty(RUNTIME_DIR) then
  RUNTIME_DIR = HOME .. '/.local/share/' .. MY_VIM
end

COMPILE_PATH = CONFIG_DIR .. '/plugin/packer_compiled.lua'

-- Neovim defualt install path
-- local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
PACKAGE_ROOT = RUNTIME_DIR .. '/site/pack'
INSTALL_PATH = PACKAGE_ROOT .. '/packer/start/packer.nvim'

local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  system_name = ''
end
OS_SYS = system_name

-----------------------------------------------------------
-- Setup runtimepath: stdpath('config'), stdpath('data')
-----------------------------------------------------------
-- require('setup_rtp')
if DEBUG then
    print('<< Begin of Initial Envirnoment >>')
    Print_rtp()
    print('CONFIG_DIR=', CONFIG_DIR)
    print('RUNTIME_DIR=', RUNTIME_DIR)
end

vim.opt.rtp:remove(Join_paths(vim.fn.stdpath('data'), 'site'))
vim.opt.rtp:remove(Join_paths(vim.fn.stdpath('data'), 'site', 'after'))
vim.opt.rtp:prepend(Join_paths(RUNTIME_DIR, 'site'))
vim.opt.rtp:append(Join_paths(RUNTIME_DIR, 'site', 'after'))

vim.opt.rtp:remove(vim.fn.stdpath('config'))
vim.opt.rtp:remove(Join_paths( vim.fn.stdpath('config'), 'after' ))
vim.opt.rtp:prepend(CONFIG_DIR)
vim.opt.rtp:append(Join_paths(CONFIG_DIR, 'after'))

vim.cmd [[let &packpath = &runtimepath]]
vim.cmd [["set spellfile" .. Join_paths(CONFIG_DIR, "spell", "en.utf-8.add")]]

if DEBUG then
    print('<< End of Initial Envirnoment >>')
    Print_rtp()
    print("stdpath('config')=" , vim.fn.stdpath('config'))
    print("stdpath('data')=", vim.fn.stdpath('data'))
end

-----------------------------------------------------------
-- Essential configuration on development init.lua
-----------------------------------------------------------
require('essential')
require('nvim_utils')

-----------------------------------------------------------
-- Plugin Manager: install plugins
-----------------------------------------------------------
-- To do "PackerCompile" automatically when file:
-- `<Nvim>/lua/plugings/init.lua` is saved
-- vim.cmd([[
-- augroup packer_user_config
-- autocmd!
-- autocmd BufWritePost ~/.config/web-nvim/lua/plugins/init.lua source <afile> | PackerCompile
-- augroup end
-- ]])
local autocmds = {
    packer_user_config = {
        { "BufWritePost " .. CONFIG_DIR .. "/lua/plugins/init.lua source <afile> | PackerCompile " },
    }
}
nvim_create_augroups(autocmds)
require('plugins')

-----------------------------------------------------------
-- Configurations for Neovim
-----------------------------------------------------------
require('settings')

-- Themes
-- Tokyo Night Color Scheme Configuration
-- vim.g.tokyonight_style = 'day'
-- vim.g.tokyonight_style = 'night'
vim.cmd([[ colorscheme tokyonight ]])
vim.g.tokyonight_style = 'storm'
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_dark_float = true
vim.g.tokyonight_transparent = true
vim.g.tokyonight_sidebars = {
    'qf',
    'vista_kind',
    'terminal',
    'packer',
}
-- Change the "hint" color to the "orange" color,
-- and make the "error" color bright red
vim.g.tokyonight_colors = {
    hint = 'orange',
    error = '#ff0000'
}

-- vim.cmd([[ colorscheme solarized8_flat ]])
-- vim.cmd([[ colorscheme solarized8 ]])
-- vim.cmd([[ colorscheme OceanicNext ]])
-- vim.cmd([[ colorscheme rvcs ]])
-- vim.cmd([[ colorscheme nightfly ]])
-- vim.cmd([[ colorscheme moonfly ]])

-----------------------------------------------------------
-- Key bindings
-----------------------------------------------------------
-- Load Shortcut Key
require('keymaps')

-- Load Which-key
require('plugins.vim-which-key')

-----------------------------------------------------------
-- Experiments
-----------------------------------------------------------


if DEBUG then print('===== End of loading init.lua... =====') end
