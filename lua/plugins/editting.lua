return {
    -----------------------------------------------------------
    -- Editting Tools
    -----------------------------------------------------------
    -- To make Neovim's fold look modern and keep high performance.
    {
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
    },
    -- replace with register contents using motion (gr + motion)
    -- 'inkarkat/vim-ReplaceWithRegister',
    -- surroundings: parentheses, brackets, quotes, XML tags, and more
    {
        "tpope/vim-surround",
        dependencies = { "tpope/vim-repeat" },
    },
    -- Toggle comments in Neovim
    -- 'tpope/vim-commentary',
    "numToStr/Comment.nvim",
    -- A Neovim plugin for setting the commentstring option based on the cursor
    -- location in the file. The location is checked via treesitter queries.
    "JoosepAlviste/nvim-ts-context-commentstring",
    -- Causes all trailing whitespace characters to be highlighted
    "cappyzawa/trim.nvim",
    -- Multiple cursor editting
    "mg979/vim-visual-multi",
    -- visualizes undo history and makes it easier to browse and switch between different undo branches
    "mbbill/undotree",
    -- Auto close parentheses and repeat by dot dot dot ...
    "windwp/nvim-autopairs",
    -- Use treesitter to autoclose and autorename html tag
    "windwp/nvim-ts-autotag",
    -- Auto change html tags
    "AndrewRadev/tagalong.vim",
}
