return {
    -----------------------------------------------------------
    -- Coding Tools
    -----------------------------------------------------------
    -- A pretty list for showing diagnostics, references, telescope results, quickfix and
    -- location lists to help you solve all the trouble your code is causing.
    {
        "folke/trouble.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("trouble").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end,
    },
    -- Yet Another Build System
    {
        "pianocomposer321/yabs.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
}
