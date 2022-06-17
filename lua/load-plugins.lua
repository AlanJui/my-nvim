if DEBUG then
    print('Loading plugins...')
end

-----------------------------------------------------------
-- Plugin Manager: install plugins
-----------------------------------------------------------
local fn = vim.fn
local packer_bootstrap

if vim.fn.empty(fn.glob(INSTALL_PATH)) > 0 then
    packer_bootstrap = fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        INSTALL_PATH,
    })
    vim.api.nvim_command('packadd packer.nvim')
    print('packer.nvim is installed and loaded...')
end

if DEBUG then
    print('PACKAGE_ROOT=', PACKAGE_ROOT)
    print('INSTALL_PATH=', INSTALL_PATH)
    print('COMPILE_PATH=', COMPILE_PATH)
    print('packer_bootstrap=', packer_bootstrap)
end

-----------------------------------------------------------
-- Initial Packer Manager
-----------------------------------------------------------
require('packer').init({
    package_root = PACKAGE_ROOT,
    compile_path = COMPILE_PATH,
    plugin_package = 'packer',
    display = {
        open_fn = require('packer.util').float,
    },
    max_jobs = 10,
})

-- 確認 packer.nvim 已能運作後，處理 nvim 套件安裝作業
local plugins = safe_require('plugins')
if not plugins then
	return
end

return require('packer').startup(function(use)
    plugins.load(use)
    -----------------------------------------------------------
    -- Automatically set up your configuration after cloning
    -- packer.nvim. Put this at the end after all plugins
    -----------------------------------------------------------
    if packer_bootstrap then
        require('packer').sync()
    end
end)
