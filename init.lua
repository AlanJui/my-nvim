-----------------------------------------------------------
-- Global Functions
-- 載入 my-nvim 作業時，所需之各種 Global Functions 。
-----------------------------------------------------------
-- vim.api.nvim_command('luafile ~/.config/my-nvim/lua/globals.lua')
require('globals')

-----------------------------------------------------------
-- Initial environments for Neovim
-- 設定 my-nvim 作業時，所需之「全域常數」。
-----------------------------------------------------------
DEBUG = false
-- DEBUG = true

MY_VIM = 'my-nvim'
OS_SYS = which_os()
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
	'diagnosticls',
	'texlab',
	'pyright',
	'emmet_ls',
	'html',
	'cssls',
	'stylelint_lsp',
	'jsonls',
	'rust_analyzer',
	'tsserver',
}

DEBUGPY = '~/.virtualenvs/debugpy/bin/python'

-- Your own custom vscode style snippets
SNIPPETS_PATH = { CONFIG_DIR .. '/my-snippets/snippets' }

-----------------------------------------------------------
-- Initial environment
-- 執行「初始」作業，變更 Neovim 的 Run Time Path (rtp)，
-- 以便 my-nvim 可在「目錄路徑」： ~/.config/my-nvim/ 運行。
-----------------------------------------------------------
-- Setup runtimepath(rtp):
local function setup_rtp()
	-- 變更 stdpath('config') 預設的 rtp : ~/.config/nvim/
	vim.opt.rtp:remove(join_paths(vim.fn.stdpath('data'), 'site'))
	vim.opt.rtp:remove(join_paths(vim.fn.stdpath('data'), 'site', 'after'))
	vim.opt.rtp:prepend(join_paths(RUNTIME_DIR, 'site'))
	vim.opt.rtp:append(join_paths(RUNTIME_DIR, 'site', 'after'))

	-- 變更 stdpath('data') 預設的 rtp : ~/.local/share/nvim/
	vim.opt.rtp:remove(vim.fn.stdpath('config'))
	vim.opt.rtp:remove(join_paths(vim.fn.stdpath('config'), 'after'))
	vim.opt.rtp:prepend(CONFIG_DIR)
	vim.opt.rtp:append(join_paths(CONFIG_DIR, 'after'))

	-- 引用 rpt 設定 package path （即擴充擴件(plugins)的安裝路徑）
	-- 此設定需正確，指令：requitre('<PluginName>') 才能正常執行。
	vim.cmd([[let &packpath = &runtimepath]])
end

if not DEBUG then
	setup_rtp()
else
	-- 在「除錯」作業時，顯示 setup_rtp() 執行前、後， rtp 的設定內容。
	-- P(vim.api.nvim_list_runtime_paths())
	Print_table(vim.opt.runtimepath:get())
	print('-----------------------------------------------------------')

	setup_rtp()

	Print_table(vim.opt.runtimepath:get())
	print('-----------------------------------------------------------')
	-- P(vim.api.nvim_list_runtime_paths())
end

---------------------------------------------------------------
-- Install Plugin Manager & Plugins / Load Plugins
-- 當 packer.nvim 尚未安裝，可自動執行下載及安裝作業；
-- 若 packer.nvim 已安裝，則執行擴充套件 (plugins) 的載入作業。
---------------------------------------------------------------
require('load-plugins')

-- configure Neovim to automatically run :PackerCompile whenever
-- plugins.lua is updated with an autocommand:
-- plugins.lua 內容有所變更時，自動執行 PackerCompile
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])

-----------------------------------------------------------
-- configuration of plugins
-- 載入各擴充套件(plugins) 的設定
-----------------------------------------------------------
if DEBUG then
	-- 正處「除錯」作業階段時，僅只載入除錯時所需的
	-- 擴充套件(plugins) 設定。
	require('lsp.lsp-debug')
	_G.load_config()
elseif INSTALLED then
	-- 非「除錯」作業；且 packer.nvim 已安裝時，
	-- 則：開始載入各擴充套件（plugins）的設定；
	-- 否則：略過擴充套件設定的載入。

	-- Neovim kernel
	require('plugins-rc.nvim-treesitter')
	require('lsp.luasnip')
	-- lsp
	require('lsp')
	require('lsp.null-langserver')
	-- status line
	-- require('plugins-rc.lualine.material')
	require('plugins-rc.lualine-material')
	require('plugins-rc.tabline')
	-- require('plugins-rc.lspstatus')
	-- User Interface
	require('plugins-rc.nvim-lightbulb')
	require('plugins-rc.nvim-web-devicons')
	require('plugins-rc.indent-blankline')
	-- files management
	require('plugins-rc.telescope-nvim')
	require('plugins-rc.nvim-tree')
	-- editting tools
	require('plugins-rc.autopairs')
	require('plugins-rc.nvim-ts-autotag')
	require('plugins-rc.undotree')
	vim.cmd([[runtime ./lua/plugins-rc/vim-better-whitespace.rc.vim]])
	vim.cmd([[runtime ./lua/plugins-rc/emmet-vim.rc.vim]])
	vim.cmd([[runtime ./lua/plugins-rc/vim-closetag.rc.vim]])
	vim.cmd([[runtime ./lua/plugins-rc/tagalong-vim.rc.vim]])
	-- programming
	require('plugins-rc.toggleterm')
	require('plugins-rc.yabs')
	-- debug
	require('dap-debug')
	require('plugins-rc.ultest')
	-- versional control
	require('plugins-rc.neogit')
	require('plugins-rc.gitsigns')
	require('plugins-rc.vim-gist')
	-- vim.cmd([[ runtime ./lua/plugins-rc/vim-signify.rc.vim]])
	-- Utilities
	vim.cmd([[runtime ./lua/plugins-rc/bracey.rc.vim]])
	vim.cmd([[runtime ./lua/plugins-rc/vim-instant-markdown.rc.vim]])
	vim.cmd([[runtime ./lua/plugins-rc/plantuml-previewer.rc.vim]])
	vim.cmd([[runtime ./lua/plugins-rc/vimtex.rc.vim]])
end

-----------------------------------------------------------
-- Configurations for Neovim
-- 設定 Neovim 的 Options
-----------------------------------------------------------
-- Must have options of Neovim when under development of init.lua
-- 在開發階段，init.lua 務必須有的 Neovim 設定
require('essential')

-- General options of Neovim
-- 在開發完成後，Neovim 應有的設定
require('options')

-- User's specific options of Neovim
-- 使用者有個人應用需求的特殊設定
require('settings')

-----------------------------------------------------------
-- Color Themes
-- Neovim 畫面的色彩設定
-----------------------------------------------------------
if not INSTALLED or DEBUG then
	print('<< Load default colorscheme >>')
	-- Use solarized8_flat color scheme when first time start my-nvim
	vim.cmd([[ colorscheme solarized8_flat ]])
else
	require('color-themes')
end

-----------------------------------------------------------
-- Key bindings
-- 操作時的按鍵設定
-----------------------------------------------------------
-- Load Shortcut Key
-- 「快捷鍵」設定
require('keymaps')

-- Load Which-key
-- 提供【選單】式的指令操作
if INSTALLED then
	require('plugins-rc.which-key')
end

-----------------------------------------------------------
-- Experiments
-- 實驗用的臨時設定
-----------------------------------------------------------

-- For folding
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Say hello
local function blah()
	print('init.lua is loaded!')
	print('====================================================================')
	print(string.format('OS = %s', which_os()))
	print(string.format('${workspaceFolder} = %s', vim.fn.getcwd()))
	print(string.format('DEBUGPY = %s', DEBUGPY))

	-- print(string.format('$VIRTUAL_ENV = %s', os.getenv('VIRTUAL_ENV')))
	local util = require('utils.python')
	local venv_python = util.get_python_path_in_venv()
	print(string.format('$VIRTUAL_ENV = %s', venv_python))
	print('====================================================================')
end

blah()
