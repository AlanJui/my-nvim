-- Plugin Manager: install plugins
-----------------------------------------------------------
local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn

local package_root = require('utils').get_package_root()
local install_path = require('utils').get_install_path()
local compile_path = require('utils').get_compile_path()
local packer_bootstrap

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
            config = [[ require('plugins.lsp-installer-nvim') ]]
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
        use 'folke/tokyonight.nvim'

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
            },
            config = [[ require('plugins.telescope-nvim') ]]
        }

        -- File/Flolders explorer:nvim-tree
        use {
            'kyazdani42/nvim-tree.lua',
            requires = 'kyazdani42/nvim-web-devicons',
            config = [[ require('plugins.nvim-tree') ]]
        }

        -- Status Line
        use {
            'nvim-lualine/lualine.nvim',
            requires = {'kyazdani42/nvim-web-devicons', opt = true},
            config = [[ require('plugins.lualine.material') ]]
            -- config = [[ require('plugins.lualine.bubbles') ]]
        }
        use {
            'arkav/lualine-lsp-progress',
            -- config = [[ require('plugins.lualine.lualine-lsp-progress') ]]
        }
        use {
            'kdheepak/tabline.nvim',
            require = {
                'hoob3rt/lualine.nvim',
                'kyazdani42/nvim-web-devicons'
            },
            config = function ()
                require('tabline').setup({ enable = false })
            end
        }

        -- Screen Navigation
        use {
            'liuchengxu/vim-which-key',
            config = [[ require('plugins.vim-which-key') ]]
        }

        -----------------------------------------------------------
        -- Git Tools
        -----------------------------------------------------------

        -- Git commands in nvim
        use 'tpope/vim-fugitive'

        -- Fugitive-companion to interact with github
        use 'tpope/vim-rhubarb'

        -- Add git related info in the signs columns and popups
        use {
            'lewis6991/gitsigns.nvim',
            requires = { 'nvim-lua/plenary.nvim' },
            config = function ()
                require('gitsigns').setup()
            end
        }

        -- A work-in-progress Magit clone for Neovim that is geared toward the Vim philosophy.
        -- use {
        --     'TimUntersberger/neogit',
        --     requires = 'nvim-lua/plenary.nvim',
        --     config = [[ require('plugins.neogit') ]]
        -- }

        -- for creating gist
        use {
            'mattn/vim-gist',
            requires = 'mattn/webapi-vim',
            config = vim.cmd([[
                let g:gist_clip_command = 'xclip -selection clipboard'
                let g:gist_open_browser_after_post = 1
                let g:github_user = 'AlanJui'
                let g:gist_token = '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'
            ]])
        }

        -----------------------------------------------------------
        -- Editting Tools
        -----------------------------------------------------------

        -- Toggle comments in Neovim
        use {
            'terrortylor/nvim-comment',
            -- config = [[ require('plugins.nvim-comment') ]]
            config = function ()
                require('nvim_comment').setup()
            end
        }

        -- Causes all trailing whitespace characters to be highlighted
        use {
            'ntpeters/vim-better-whitespace',
            config = vim.cmd([[
                runtime 'lua/plugins/vim-better-whitespace.rc.vim'
            ]])
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

        -- Multiple cursor editting
        use 'mg979/vim-visual-multi'

        -- visualizes undo history and makes it easier to browse and switch between different undo branches
        use {
            'mbbill/undotree',
            config = [[ require('plugins.undotree') ]]
        }

        -- HTML
        ---------------------------------------------------------------

        -- provides support for expanding abbreviations similar to emmet
        use {
            'mattn/emmet-vim',
            config = vim.cmd([[
                runtime 'lua/plugins/emmet-vim.rc.vim'
            ]])
        }

        -- Auto close tag
        use {
            'alvan/vim-closetag',
            config = vim.cmd([[
                runtime 'lua/plugins/vim-closetag.rc.vim'
            ]])
        }

        -- Auto change html tags
        use {
            'AndrewRadev/tagalong.vim',
            config = vim.cmd([[
                runtime 'lua/plugins/tagalong-vim.rc.vim'
            ]])
        }

        -- Use treesitter to autoclose and autorename HTML tag
        -- use {
        --     'windwp/nvim-ts-autotag',
        --     config = [[ require('plugins.nvim-ts-autotag') ]]
        -- }

        -- Python
        ---------------------------------------------------------------
        -- ALE (Asynchronous Lint Engine) is a plugin providing linting (syntax
        -- checking and semantic errors) in NeooVim while you edit your text files,
        -- and acts as a Vim Language Server Protocol client.
        use {
            'dense-analysis/ale',
            config = vim.cmd([[
                runtime 'lua/plugins/ale.rc.vim'
            ]])
        }

        --  Modifies Vim’s indentation behavior to comply with PEP8 and my aesthetic preferences.
        use 'Vimjas/vim-python-pep8-indent'

        -- Python: provides text objects and motions for Python classes, methods,
        -- functions and doc strings
        use 'jeetsukumaran/vim-pythonsense'

        -- View and search LSP symbols, tags in NeoVim
        use {
            'liuchengxu/vista.vim',
            config = vim.cmd([[
                runtime 'lua/plugins/vista.rc.vim'
            ]])
        }

        -----------------------------------------------------------
        -- Utility
        -----------------------------------------------------------

        -- Floater Terminal
        use 'voldikss/vim-floaterm'

        -- highlight your todo comments in different styles
        use {
            'folke/todo-comments.nvim',
            requires = 'nvim-lua/plenary.nvim',
            config = function ()
                require('todo-comments').setup({
                    -- configuration comes here
                    -- or leave it empty to use the default setting
                })
            end
        }

        -- Live server
        use 'turbio/bracey.vim'

        -- Markdown preview
        use {
            'instant-markdown/vim-instant-markdown',
            config = vim.cmd([[
                runtime 'lua/plugins/vim-instant-markdown.rc.vim'
            ]])
        }

        -- PlantUML
        use {
            'weirongxu/plantuml-previewer.vim',
            config = vim.cmd([[
                runtime 'lua/plugins/plantuml-previewer.rc.vim'
            ]])
        }

        -- PlantUML syntax highlighting
        use 'aklt/plantuml-syntax'

        -- Open URI with your favorite browser from your most favorite editor
        use 'tyru/open-browser.vim'

        -- Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all plugins
        if packer_bootstrap then
            require('packer').sync()
        end
    end,

    -- config = {
    --     -- Move to lua dir so impatient.nvim can cache it
    --     -- compile_path = fn.stdpath('config') .. '/plugin/packer_compiled.lua'
    --     compile_path = compile_path,
    -- }
})
