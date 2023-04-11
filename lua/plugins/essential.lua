return {
    -----------------------------------------------------------
    -- Essential plugins
    -----------------------------------------------------------
    -- lua functions that many plugins use
    "nvim-lua/plenary.nvim",
    -- Tools to migrating init.vim to init.lua
    "norcalli/nvim_utils",
    -- vs-code like icons
    "nvim-tree/nvim-web-devicons",
    -- File/Flolders explorer:nvim-tree
    {
        "kyazdani42/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- optional, for file icon
        },
    },
    -----------------------------------------------------------
    -- Treesitter: for better syntax
    -----------------------------------------------------------
    -- Nvim Treesitter configurations and abstraction layer
    {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    },
    -----------------------------------------------------------
    -- Fuzzy files finder: Telescope
    -----------------------------------------------------------
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-live-grep-raw.nvim",
        },
    },
    -- Telescope Extensions
    -- 'cljoly/telescope-repo.nvim',
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "dhruvmanila/telescope-bookmarks.nvim",
    "nvim-telescope/telescope-github.nvim",
    -- Trying command palette
    "LinArcX/telescope-command-palette.nvim",
    {
        "AckslD/nvim-neoclip.lua",
        config = function()
            require("neoclip").setup()
        end,
    },
    -- dependency for better sorting performance
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
    },
    "jvgrootveld/telescope-zoxide",
}
