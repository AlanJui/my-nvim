-- Essential configuration
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
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

local use = require('packer').use
return require('packer').startup({
  function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Causes all trailing whitespace characters to be highlighted
    use 'ntpeters/vim-better-whitespace'

    -- Add indentation guides even on blank lines
    use 'lukas-reineke/indent-blankline.nvim'

    -- Auto close parentheses and repeat by dot dot dot ...
    use 'jiangmiao/auto-pairs'

    -- surroundings: parentheses, brackets, quotes, XML tags, and more
    use 'tpope/vim-surround'

    -- Toggle comments in Neovim
    use 'terrortylor/nvim-comment'

    -- A collection of common configurations for Neovim's built-in language
    -- server client
    use {
      'neovim/nvim-lspconfig',
      config = [[ require('plugins/lspconfig') ]]
    }

    -- companion plugin for nvim-lspconfig that allows you to seamlessly
    -- install LSP servers locally
    use {
      'williamboman/nvim-lsp-installer',
      config = [[ require('plugins/lsp_installer_nvim') ]]
    }

    -- vscode-like pictograms for neovim lsp completion items Topics
    use {
      'onsails/lspkind-nvim',
      config = [[ require('plugins/lspkind') ]]
    }

    -- Utility functions for getting diagnostic status and progress messages
    -- from LSP servers, for use in the Neovim statusline
    use {
      'nvim-lua/lsp-status.nvim',
      config = [[ require('plugins/lspstatus') ]]
    }

    -- A completion plugin for neovim coded in Lua.
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
