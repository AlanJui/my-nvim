local M = {}

local is_empty = require('utils.is_empty')

-- local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local home_path = os.getenv('HOME')
local my_nvim = os.getenv('MY_NVIM')
local nvim_config_path
local package_root
local compile_path
local install_path

if is_empty(my_nvim) then
    my_nvim = 'nvim'
    package_root = home_path .. '/.local/share/' .. my_nvim .. '/site/pack'
    nvim_config_path = home_path .. '/.config/' .. my_nvim
else
    package_root = os.getenv('NVIM_RUNTIME_DIR') .. '/site/pack'
    nvim_config_path = os.getenv('NVIM_CONFIG_DIR')
end
install_path = package_root .. '/packer/start/packer.nvim'
compile_path = nvim_config_path .. '/plugin/packer_compiled.lua'

M.get_system = function ()
    local system_name

    if vim.fn.has("mac") == 1 then
        system_name = "macOS"
    elseif vim.fn.has("unix") == 1 then
        system_name = "Linux"
    elseif vim.fn.has('win32') == 1 then
        system_name = "Windows"
    else
        -- Unsupported system
        system_name = ''
    end

    return system_name
end

-- Neovim defualt install path
-- local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
M.get_home_path = function ()
    return home_path
end

M.get_my_nvim = function ()
    return my_nvim
end

M.get_package_root = function ()
    return package_root
end

M.get_compile_path = function ()
    return compile_path
end

M.get_install_path = function ()
    return install_path
end

M.get_plugin_config_path = function ()
    local plugin_config_path = nvim_config_path .. '/nvim/lua/plugins'
    return plugin_config_path
end

return M


-- local is_empty = require('utils.is_empty')
-- local home_path = os.getenv('HOME')
-- local my_nvim = os.getenv('MY_NVIM')
-- local nvim_config_path
-- local package_root
-- local compile_path
-- local install_path

-- if is_empty(my_nvim) then
--     my_nvim = 'nvim'
--     nvim_config_path = home_path .. '/.config/' .. my_nvim
--     package_root = home_path .. '/.local/share/' .. my_nvim .. '/site/pack'
-- else
--     nvim_config_path = os.getenv('NVIM_CONFIG_DIR')
--     package_root = os.getenv('NVIM_RUNTIME_DIR') .. '/site/pack'
-- end
-- compile_path = nvim_config_path .. '/plugin/packer_compiled.lua'
-- install_path = package_root .. '/packer/start/packer.nvim'

