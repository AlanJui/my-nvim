return {
    -----------------------------------------------------------
    -- User Interface
    -----------------------------------------------------------
    -- Quick switch between files
    "ThePrimeagen/harpoon",
    -- maximizes and restores current window
    "szw/vim-maximizer",
    -- tmux & split window navigation
    "christoomey/vim-tmux-navigator",
    -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    -- Status Line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
    },
    {
        "kdheepak/tabline.nvim",
        require = { "hoob3rt/lualine.nvim", "nvim-tree/nvim-web-devicons" },
    },
    "arkav/lualine-lsp-progress",
    -- Utility functions for getting diagnostic status and progress messages
    -- from LSP servers, for use in the Neovim statusline
    "nvim-lua/lsp-status.nvim",
}
