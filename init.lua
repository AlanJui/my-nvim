-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
MY_VIM = 'web-nvim'
DEBUG = false
-- DEBUG = true

if DEBUG then print('===== Begin of loading init.lua... =====') end

local function print_runtime_path()
    print(string.format('rtp = %s', vim.opt.rtp['_value']))
end

-----------------------------------------------------------
-- Initial environment
-----------------------------------------------------------
if DEBUG then
    print('<< Begin of init_my_vim() >>')
    print_runtime_path()
end
-----------------------------------------------------------
-- local init_env_path = os.getenv('HOME') .. '/.config/' .. MY_VIM .. '/lua/init_env.lua'
-- print(string.format('init_env_path = %s', init_env_path))
-- vim.cmd([[ "luafile " .. init_env_path ]])

local config_dir = os.getenv('MY_CONFIG_DIR')
local runtime_dir = os.getenv('MY_RUNTIME_DIR')
local path_sep = vim.loop.os_uname().version:match "Windows" and "\\" or "/"

local function join_paths(...)
    local result = table.concat({ ... }, path_sep)
    return result
end

vim.opt.rtp:remove(join_paths(vim.fn.stdpath('data'), 'site'))
vim.opt.rtp:remove(join_paths(vim.fn.stdpath('data'), 'site', 'after'))
vim.opt.rtp:prepend(join_paths(runtime_dir, 'site'))
vim.opt.rtp:append(join_paths(runtime_dir, 'site', 'after'))

vim.opt.rtp:remove(vim.fn.stdpath('config'))
vim.opt.rtp:remove(join_paths( vim.fn.stdpath('config'), 'after' ))
vim.opt.rtp:prepend(config_dir)
vim.opt.rtp:append(join_paths(config_dir, 'after'))

vim.cmd [[let &packpath = &runtimepath]]
vim.cmd [["set spellfile" .. join_paths(config_dir, "spell", "en.utf-8.add")]]

-----------------------------------------------------------
if DEBUG then
    print('<< End of init_my_vim() >>')
    print_runtime_path()
    -- print('config_dir=', config_dir)
    -- print('runtime_dir=', runtime_dir)
    -- print(vim.fn.stdpath('config'))
    -- print(vim.fn.stdpath('data'))
end

-----------------------------------------------------------
-- Essential configuration on development init.lua
-----------------------------------------------------------
require('essential')

-----------------------------------------------------------
-- Plugin Manager: install plugins
-----------------------------------------------------------
require('plugins')

-- vim.cmd([[
-- augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost ./lua/plugins/init.lua source <afile> | PackerCompile
-- augroup end
-- ]])
require('nvim_utils')
local nvim_config_path = require('utils.env').get_config_dir()
local autocmds = {
    packer_user_config = {
        { "BufWritePost " .. nvim_config_path .. "/lua/plugins/init.lua source <afile> | PackerCompile " },
    }
}
nvim_create_augroups(autocmds)

-----------------------------------------------------------
-- Configurations for Neovim
-----------------------------------------------------------
require('configs')

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
require('keymaps')

-----------------------------------------------------------
-- Experiment
-----------------------------------------------------------
if DEBUG then print('===== End of loading init.lua... =====') end
