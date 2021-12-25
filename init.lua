-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
DEBUG = false
-- DEBUG = true

if DEBUG then print('===== Begin of loading init.lua... =====') end
-----------------------------------------------------------
-- Global Functions
-----------------------------------------------------------
vim.api.nvim_command('luafile ~/.config/my-nvim/lua/globals.lua')

-----------------------------------------------------------
-- Initial environment
-----------------------------------------------------------
vim.api.nvim_command('luafile ~/.config/my-nvim/lua/init-env.lua')

-----------------------------------------------------------
-- Setup runtimepath: stdpath('config'), stdpath('data')
-----------------------------------------------------------
vim.api.nvim_command('luafile ~/.config/my-nvim/lua/setup-rtp.lua')

-----------------------------------------------------------
-- Essential configuration on development init.lua
-----------------------------------------------------------
require('essential')
require('nvim_utils')

-----------------------------------------------------------
-- Plugin Manager: install plugins
-----------------------------------------------------------
require('plugins')

-----------------------------------------------------------
-- Configurations for Neovim
-----------------------------------------------------------
require('options')

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
-- if INSTALLED then
--     require('plugins.which-key')
-- end

-----------------------------------------------------------
-- autocmd
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

-----------------------------------------------------------
-- Experiments
-----------------------------------------------------------
require('dbg')

-----------------------------------------------------------
-- local dap = require('dap')
-- dap.configurations.python = {
--     {
--         -- The first three options are required by nvim-dap
--         name = "Python: Django",
--         type = 'python',  -- the type here established the link to the adapter definition: `dap.adapters.python`
--         request = 'launch',
--         -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
--         program = "${workspaceFolder}/manage.py"; -- This configuration will launch the current file if used.
--         args = {
--             'runserver'
--         },
--         env = {
--             DJANGO_SETTINGS_MODULE = 'web_project.settings'
--         },
--         django = true,
--         pythonPath = function()
--             return bin_path
--         end,
--     },
-- }

if DEBUG then print('===== End of loading init.lua... =====') end
