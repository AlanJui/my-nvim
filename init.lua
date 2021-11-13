-- Essential configuration on development init.lua
-----------------------------------------------------------
-- Tabs
vim.bo.expandtab = true
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
-- Display line number on side bar
vim.wo.number = true
vim.wo.relativenumber = true
-- Disable line wrap
vim.opt.textwidth = 0
vim.opt.wrapmargin = 0
vim.wo.wrap = false

-- Plugin Manager: install plugins
-----------------------------------------------------------
local execute = vim.api.nvim_command
local fn = vim.fn
-- local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
-- local is_empty = require('utils.is_empty')
local is_empty = function(str)
	return str == nil or str == ''
end
local home_path = os.getenv('HOME')

local my_nvim
local nvim_config_path
local package_root
local compile_path
local install_path

my_nvim = os.getenv('MY_NVIM')
if is_empty(my_nvim) then
	my_nvim = 'nvim'
	nvim_config_path = home_path .. '/.config/' .. my_nvim
	package_root = home_path .. '/.local/share/' .. my_nvim .. '/site/pack'
else
	nvim_config_path = os.getenv('NVIM_CONFIG_DIR')
	package_root = os.getenv('NVIM_RUNTIME_DIR') .. '/site/pack'
end
compile_path = nvim_config_path .. '/plugin/packer_compiled.lua'
install_path = package_root .. '/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

require('packer').init({
	package_root = package_root,
	compile_path = compile_path,
})

local use = require('packer').use
require('packer').startup({ function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Causes all trailing whitespace characters to be highlighted
    use 'ntpeters/vim-better-whitespace'

    -- Add indentation guides even on blank lines
    use 'lukas-reineke/indent-blankline.nvim'

    -- Auto close parentheses and repeat by dot dot dot ...
    -- use 'jiangmiao/auto-pairs'
	use {
		'windwp/nvim-autopairs',
		config = [[ require('plugins.autopairs') ]]
	}

    -- surroundings: parentheses, brackets, quotes, XML tags, and more
    use 'tpope/vim-surround'

    -- Toggle comments in Neovim
    use 'terrortylor/nvim-comment'

    -- A collection of common configurations for Neovim's built-in language
    -- server client
    use {
      'neovim/nvim-lspconfig',
      config = [[ require('plugins.lspconfig') ]]
    }

    -- companion plugin for nvim-lspconfig that allows you to seamlessly
    -- install LSP servers locally
    use {
      'williamboman/nvim-lsp-installer',
      config = [[ require('plugins.lsp_installer_nvim') ]]
    }

    -- vscode-like pictograms for neovim lsp completion items Topics
    use {
      'onsails/lspkind-nvim',
      config = [[ require('plugins.lspkind') ]]
    }

    -- Utility functions for getting diagnostic status and progress messages
    -- from LSP servers, for use in the Neovim statusline
    use {
      'nvim-lua/lsp-status.nvim',
      config = [[ require('plugins.lspstatus') ]]
    }

    -- A completion plugin for neovim coded in Lua.
	use {
		'hrsh7th/nvim-cmp',
		requires = {
			-- nvim-cmp source for neovim builtin LSP client
			'hrsh7th/cmp-nvim-lsp',
			-- nvim-cmp source for nvim lua
			'hrsh7th/cmp-nvim-lua',
			-- nvim-cmp source for buffer words
			'hrsh7th/cmp-buffer',
			-- nvim-cmp source for filesystem paths
			'hrsh7th/cmp-path',
			-- nvim-cmp source for math calculation
			'hrsh7th/cmp-calc',

			-- LuaSnip completion source for nvim-cmp
			'saadparwaiz1/cmp_luasnip',
		},
      	config = [[ require('plugins.cmp') ]]
	}

	-- Snippet Engine for Neovim written in Lua.
	use {
		'L3MON4D3/LuaSnip',
		requires = {
			-- Snippets collection for a set of different programming languages for faster development
			'rafamadriz/friendly-snippets',
		},
		config = [[ require('plugins.luasnip') ]]
	}

	-- Nvim Treesitter configurations and abstraction layer
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		-- config = [[ require('plugins.treesitter') ]]
		config = [[ require('plugins.nvim-treesitter') ]]
	}
	-- Additional textobjects for treesitter
	use 'nvim-treesitter/nvim-treesitter-textobjects'

	-- colorscheme for neovim written in lua specially made for roshnvim
	-- use { 'shaeinst/roshnivim-cs' }

	-- Fuzzy files finder
	use {
		'nvim-telescope/telescope.nvim',
		requires = {
			{ 'nvim-lua/plenary.nvim', }
		}
	}

	-- Status Line
	use {
		'yamatsum/nvim-nonicons',
		requires = { 'kyazdani42/nvim-web-devicons' }
	}
	use {
		'glepnir/galaxyline.nvim',
		branch = 'main',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true },
		config = function() require('plugins.galaxyline.angeline') end
		-- config = [[ require('plugins.galaxyline.spaceline') ]]
		-- config = [[ require('plugins.galaxyline.bubbles') ]]
	}
	-- -- use 'itchyny/lightline.vim' -- Fancier statusline
	-- use {
	-- 	'nvim-lualine/lualine.nvim',
	-- 	requires = {'kyazdani42/nvim-web-devicons', opt = true},
	-- 	config = [[ require('plugins.lualine') ]]
	-- }
	-- use { 'arkav/lualine-lsp-progress' }
	-- use {
	-- 	'kdheepak/tabline.nvim',
	-- 	config = function ()
	-- 		require('tabline').setup({ enable = false })
	-- 	end,
	-- 	require = {
	-- 		'hoob3rt/lualine.nvim',
	-- 		'kyazdani42/nvim-web-devicons'
	-- 	}
	-- }

  end,

  config = {
    -- Move to lua dir so impatient.nvim can cache it
    compile_path = fn.stdpath('config') .. '/plugin/packer_compiled.lua'
  }
})

-- LSP/LspInstaller: configurations for the Nvim LSP client
-----------------------------------------------------------

-- Completion: for auto-completion/suggestion/snippets
-----------------------------------------------------------

-- Treesitter: for better syntax
-----------------------------------------------------------

-- Color scheme: for syntax highlighting
-----------------------------------------------------------

-- Configurations for Neovim
-----------------------------------------------------------
require('configs')

-- Themes
vim.o.termguicolors = true
vim.cmd([[ run time ./colors/NeoSolarized.vim ]])

-- Key bindings
-- --------------------------------------------------------
local keymap = require('utils.set_keymap')
local opts = { silent = true, noremap = true }

vim.g.maplocalleader = ','

keymap('i', 'jj', '<Esc>', opts)
keymap('n', 'H', '0', opts)
keymap('n', 'L', '$', opts)
keymap('n', 'X', 'd$', opts)
keymap('n', 'Y', 'y$', opts)

keymap('n', '\\', ':Explore<CR>', opts)
keymap('n', '<LocalLeader>f', ':Telescope<CR>', opts)

-- Move line
keymap('n', '<S-Down>', ':m .+1<CR>', opts)
keymap('n', '<S-Up>',   ':m .-2<CR>', opts)
keymap('i', '<S-Down>', '<Esc>:m .+1<CR>', opts)
keymap('i', '<S-Up>',   '<Esc>:m .-2<CR>', opts)
keymap('v', '<S-Down>', ":move '>+1<CR>gv-gv", opts)
keymap('v', '<S-Up>',   ":move '<-2<CR>gv-gv", opts)

-- Comment
keymap('n', '<C-_>', ':CommentToggle<CR>', { noremap = true })
keymap('v', '<C-_>', ':CommentToggle<CR>', { noremap = true })

-- Windows navigation
keymap('n', '<C-w>-',  ':split<CR>',  opts)
keymap('n', '<C-w>_',  ':vsplit<CR>', opts)
keymap('n', '<C-w>|',  ':vsplit<CR>', opts)

-- Window Zoom In/Out
keymap('n', '<LocalLeader>wi', '<C-w>| <C-w>_', opts)
keymap('n', '<LocalLeader>wo', '<C-w>=', opts)
