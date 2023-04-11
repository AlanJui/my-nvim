return {
    -----------------------------------------------------------
    -- DAP
    -----------------------------------------------------------
    {
        "mfussenegger/nvim-dap",
        -- bridges mason.nvim with the nvim-dap plugin - making it
        -- easier to use both plugins together.
        "jay-babu/mason-nvim-dap.nvim",
    },
    --
    -- Language specific exensions
    --
    -- DAP for Python
    "mfussenegger/nvim-dap-python",
    -- DAP for Lua work in Neovim
    "jbyuki/one-small-step-for-vimkind",
    -- DAP for Node.js (nvim-dap adapter for vscode-js-debug)
    -- 'mxsdev/nvim-dap-vscode-js", dependencies = { "mfussenegger/nvim-dap" } },
    -- {
    -- 	"microsoft/vscode-js-debug",
    -- 	opt = true,
    -- 	run = "npm install --legacy-peer-deps && npm run compile",
    -- },
    --
    -- DAP UI Extensions
    --
    -- UI for nvim-dap
    -- Install icons for dap-ui: https://github.com/ChristianChiarulli/neovim-codicons
    "folke/neodev.nvim",
    -- 'rcarriga/nvim-dap-ui',
    -- Reset nvim-dap-ui to a specific commit
    {
        "rcarriga/nvim-dap-ui",
        tag = "v3.6.4",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
    },

    -- Inlines the values for variables as virtual text using treesitter.
    "theHamsta/nvim-dap-virtual-text",
    -- -- Integration for nvim-dap with telescope.nvim
    "nvim-telescope/telescope-dap.nvim",
    -- UI integration for nvim-dat with fzf
    "ibhagwan/fzf-lua",
    -- nvim-cmp source for using DAP completions inside the REPL.
    "rcarriga/cmp-dap",
}
