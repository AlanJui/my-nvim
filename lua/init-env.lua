-----------------------------------------------------------
-- Initial environment
-----------------------------------------------------------
MY_VIM = 'my-nvim'
OS_SYS = which_os()
HOME = os.getenv('HOME')

CONFIG_DIR = os.getenv('MY_CONFIG_DIR')
if is_empty(CONFIG_DIR) then
    CONFIG_DIR = HOME .. '/.config/' .. MY_VIM
end

RUNTIME_DIR = os.getenv('MY_RUNTIME_DIR')
if is_empty(RUNTIME_DIR) then
    RUNTIME_DIR = HOME .. '/.local/share/' .. MY_VIM
end

COMPILE_PATH = CONFIG_DIR .. '/plugin/packer_compiled.lua'

-- Neovim defualt install path
-- local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
PACKAGE_ROOT = RUNTIME_DIR .. '/site/pack'
INSTALL_PATH = PACKAGE_ROOT .. '/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(INSTALL_PATH)) > 0 then
    INSTALLED = false
else
    INSTALLED = true
end
