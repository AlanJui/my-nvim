return {
    -----------------------------------------------------------
    -- Git Tools
    -----------------------------------------------------------
    -- Git commands in nvim
    "tpope/vim-fugitive",
    -- Fugitive-companion to interact with github
    "tpope/vim-rhubarb",
    -- Add git related info in the signs columns and popups
    {
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
    },
    -- A work-in-progress Magit clone for Neovim that is geared toward the Vim philosophy.
    {
        "TimUntersberger/neogit",
        dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
    },
    -- for creating gist
    -- Personal Access Token: ~/.gist-vim
    -- token XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    { "mattn/vim-gist", dependencies = "mattn/webapi-vim" },
}
