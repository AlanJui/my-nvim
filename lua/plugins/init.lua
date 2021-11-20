-- Plugin Manager: install plugins
-----------------------------------------------------------
local execute = vim.api.nvim_command
local fn = vim.fn

local package_root = require('utils').get_package_root()
local install_path = require('utils').get_install_path()
local compile_path = require('utils').get_compile_path()

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  execute 'packadd packer.nvim'
end

require('packer').init({
  package_root = package_root,
  compile_path = compile_path,
})

return require('packer').startup({
  function(use)
    -----------------------------------------------------------
    -- Essential plugins
    -----------------------------------------------------------

    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

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
    use 'shaeinst/roshnivim-cs'
    use 'mhartington/oceanic-next'
    use 'bluz71/vim-moonfly-colors'
    use 'bluz71/vim-nightfly-guicolors'

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

    -----------------------------------------------------------
    -- Tools
    -----------------------------------------------------------

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

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require('packer').sync()
    end
  end,

  config = {
    -- Move to lua dir so impatient.nvim can cache it
    -- compile_path = fn.stdpath('config') .. '/plugin/packer_compiled.lua'
    compile_path = compile_path
  }
})

