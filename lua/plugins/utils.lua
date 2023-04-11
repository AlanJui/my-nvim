return {
    -----------------------------------------------------------
    -- Utility
    -----------------------------------------------------------
    -- File explorer: vifm
    "vifm/vifm.vim",
    -- Floater Terminal
    "voldikss/vim-floaterm",
    -- terminal
    "pianocomposer321/consolation.nvim",
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = true,
    },
    -- Live server
    {
        "turbio/bracey.vim",
        run = "npm install --prefix server",
    },
    -- Open URI with your favorite browser from your most favorite editor
    "tyru/open-browser.vim",
    -- PlantUML
    "weirongxu/plantuml-previewer.vim",
    -- PlantUML syntax highlighting
    "aklt/plantuml-syntax",
    -- provides support to mermaid syntax files (e.g. *.mmd, *.mermaid)
    "mracos/mermaid.vim",
    -- Markdown support Mermaid
    -- 'iamcco/markdown-preview.nvim',
    -- install without yarn or npm
    {
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
    -- Markdown preview
    -- 'instant-markdown/vim-instant-markdown',
    -- highlight your todo comments in different styles
    -- {
    -- 	'folke/todo-comments.nvim',
    -- 	dependencies = 'nvim-lua/plenary.nvim',
    -- 	config = function()
    -- 	    require('todo-comments').setup({
    --              -- configuration comes here
    --              -- or leave it empty to use the default setting
    -- 	    },
    -- 	end,
    -- },
}
