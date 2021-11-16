-- Essential configuration on development init.lua
-----------------------------------------------------------
-- Display line number on side bar
vim.wo.number = true
vim.wo.relativenumber = true
-- Disable line wrap
vim.opt.textwidth = 0
vim.opt.wrapmargin = 0
vim.wo.wrap = false
-- Tabs
vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.cmd([[
autocmd FileType lua setlocal expandtab shiftwidth=4 tabstop=4 smartindent
autocmd BufEnter *.lua set autoindent expandtab shiftwidth=4 tabstop=4
]])
-- Reformat indent line
-- gg=G
vim.cmd([[
command! -range=% Format :<line1>,<line2>s/^\s*/&&
]])

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
    -----------------------------------------------------------
    -- Essential plugins
    -----------------------------------------------------------

    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Causes all trailing whitespace characters to be highlighted
    use {
        'ntpeters/vim-better-whitespace',
        config = [[ require('plugins.telescope-nvim') ]]
    }

    -- Add indentation guides even on blank lines
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = [[ require('plugins.indent-blankline') ]]
    }

    -- Auto close parentheses and repeat by dot dot dot ...
    -- use 'jiangmiao/auto-pairs'
    use {
        'windwp/nvim-autopairs',
        config = [[ require('plugins.autopairs') ]]
    }

    -- surroundings: parentheses, brackets, quotes, XML tags, and more
    use 'tpope/vim-surround'

    -- Toggle comments in Neovim
    use {
        'terrortylor/nvim-comment',
        -- config = [[ require('plugins.nvim-comment') ]]
        config = function ()
            require('nvim_comment').setup()
        end
    }

    -----------------------------------------------------------
    -- LSP/LspInstaller: configurations for the Nvim LSP client
    -----------------------------------------------------------

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

    -----------------------------------------------------------
    -- Completion: for auto-completion/suggestion/snippets
    -----------------------------------------------------------

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

    -----------------------------------------------------------
    -- Treesitter: for better syntax
    -----------------------------------------------------------

    -- Nvim Treesitter configurations and abstraction layer
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        -- config = [[ require('plugins.treesitter') ]]
        config = [[ require('plugins.nvim-treesitter') ]]
    }
    -- Additional textobjects for treesitter
    use 'nvim-treesitter/nvim-treesitter-textobjects'

    -----------------------------------------------------------
    -- User Interface
    -----------------------------------------------------------

    -- colorscheme for neovim written in lua specially made for roshnvim
    -- use { 'shaeinst/roshnivim-cs' }

    -- Icons
    use {
        'kyazdani42/nvim-web-devicons',
        config = [[ require('plugins.nvim-web-devicons') ]]
    }
    -- use {
    --     'yamatsum/nvim-nonicons',
    --     requires = { 'kyazdani42/nvim-web-devicons' }
    -- }
    -- Fuzzy files finder
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim', }
        }
    }

    -- Status Line
    use {
    	'nvim-lualine/lualine.nvim',
    	requires = {'kyazdani42/nvim-web-devicons', opt = true},
    	-- config = [[ require('plugins.lualine.material') ]]
    	config = [[ require('plugins.lualine.bubbles') ]]
    }
    use {
        'arkav/lualine-lsp-progress',
    	-- config = [[ require('plugins.lualine.lualine-lsp-progress') ]]
    }
    use {
    	'kdheepak/tabline.nvim',
    	config = function ()
    		require('tabline').setup({ enable = false })
    	end,
    	require = {
    		'hoob3rt/lualine.nvim',
    		'kyazdani42/nvim-web-devicons'
    	}
    }
    -- use {
    --     'glepnir/galaxyline.nvim',
    --     branch = 'main',
    --     requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    --     config = function() require('plugins.galaxyline.angeline') end
    --     -- config = [[ require('plugins.galaxyline.spaceline') ]]
    --     -- config = [[ require('plugins.galaxyline.bubbles') ]]
    -- }
    -- use 'itchyny/lightline.vim' -- Fancier statusline

end,

    config = {
        -- Move to lua dir so impatient.nvim can cache it
        compile_path = fn.stdpath('config') .. '/plugin/packer_compiled.lua'
    }
})

-- Configurations for Neovim
-----------------------------------------------------------
require('configs')

-- Themes
vim.o.termguicolors = true
vim.cmd([[ run time ./colors/NeoSolarized.vim ]])

-- Key bindings
-----------------------------------------------------------
require('keymaps')

-- Experiment
-----------------------------------------------------------
-- require'nvim-web-devicons'.setup {
--     -- your personnal icons can go here (to override)
--     -- DevIcon will be appended to `name`
--     override = {
--         lua = {
--             icon = "",
--             color = "#428850",
--             name = "Lua"
--         }
--     };
--     -- globally enable default icons (default to false)
--     -- will get overriden by `get_icons` option
--     default = true;
-- }
