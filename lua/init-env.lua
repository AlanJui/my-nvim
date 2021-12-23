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

-----------------------------------------------------------
PYENV_ROOT_PATH = HOME .. '/.pyenv'
PYENV_GLOBAL_PATH = PYENV_ROOT_PATH .. '/versions/venv-nvim'
PYTHON_BINARY = PYENV_GLOBAL_PATH .. '/bin/python3'

vim.g.python3_host_prog = PYTHON_BINARY
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
