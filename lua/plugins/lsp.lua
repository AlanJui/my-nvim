return {
	-----------------------------------------------------------
	-- Completion: for auto-completion/suggestion/snippets
	-----------------------------------------------------------
	-- A completion plugin for neovim coded in Lua.
	{
		-- Completion framework
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter" },
		dependencies = {
			-- LSP completion source
			"hrsh7th/cmp-nvim-lsp",
			-- Useful completion sources
			"hrsh7th/cmp-nvim-lua", -- nvim-cmp source for buffer words
			"hrsh7th/cmp-buffer", -- nvim-cmp source for filesystem paths
			"hrsh7th/cmp-path", -- nvim-cmp source for math calculation
			"hrsh7th/cmp-calc",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-cmdline",
			-- LuaSnip completion source for nvim-cmp
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp", -- LSP Completions
			"hrsh7th/cmp-nvim-lua", -- Lua Completions
			"hrsh7th/cmp-cmdline", -- CommandLine Completions
			{
				"windwp/nvim-autopairs",
				config = function()
					local autopairs = require "nvim-autopairs"

					autopairs.setup {
						check_ts = true, -- treesitter integration
						disable_filetype = { "TelescopePrompt" },
					}

					local cmp_autopairs = require "nvim-autopairs.completion.cmp"
					local cmp_status_ok, cmp = pcall(require, "cmp")
					if not cmp_status_ok then
						return
					end
					cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done {})
				end,
			},
		},
	},
	-- Snippet Engine for Neovim written in Lua.
	{
	-- {
	-- 	"L3MON4D3/LuaSnip",
	-- 	-- follow latest release.
	-- 	version = "<CurrentMajor>.*",
	-- 	-- install jsregexp (optional!).
	-- 	build = "make install_jsregexp",
	-- },
		"L3MON4D3/LuaSnip", -- Snippet Engine
	-- Snippets collection for a set of different programming languages for faster development
		"rafamadriz/friendly-snippets", -- Bunch of Snippets
	},
	-----------------------------------------------------------
	-- LSP/LspInstaller: configurations for the Nvim LSP client
	-----------------------------------------------------------
	{
		-- companion plugin for nvim-lspconfig that allows you to seamlessly
		-- install LSP servers locally
		"williamboman/mason.nvim",
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonLog",
		}, -- Package Manager
		dependencies = "williamboman/mason-lspconfig.nvim",
	},
	{
		-- A collection of common configurations for Neovim's built-in language
		-- server client
		"neovim/nvim-lspconfig",
		"williamboman/mason-lspconfig.nvim",
		-- helps users keep up-to-date with their tools and to make certain
		-- they have a consistent environment.
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	-- LSP plugin based on Neovim build-in LSP with highly a performant UI
	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			--Please make sure you install markdown and markdown_inline parser
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},
	-- bridges gap b/w mason & null-ls
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
	},
	-- formatting & linting
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim", -- stylua-nvim is a mini Lua code formatter
			"ckipp01/stylua-nvim",
		},
	},
	-- vscode-like pictograms for neovim lsp completion items Topics
	"onsails/lspkind-nvim",
	-----------------------------------------------------------
	-- AI Tooles
	-----------------------------------------------------------
	-- AI code auto-complete
	"github/copilot.vim",
	"hrsh7th/cmp-copilot",
	-----------------------------------------------------------
	-- Lazy LSP
	-----------------------------------------------------------
	-- All in one LSP plugin (include auto-complete)
	--
	-- {
	--     "VonHeikemen/lsp-zero.nvim",
	--     branch = "v1.x",
	--     dependencies = {
	--         -- LSP Support
	--         { "neovim/nvim-lspconfig" }, -- Required
	--         { "williamboman/mason.nvim" }, -- Optional
	--         { "williamboman/mason-lspconfig.nvim" }, -- Optional
	--
	--         -- Autocompletion
	--         { "hrsh7th/nvim-cmp" }, -- Required
	--         { "hrsh7th/cmp-nvim-lsp" }, -- Required
	--         { "hrsh7th/cmp-buffer" }, -- Optional
	--         { "hrsh7th/cmp-path" }, -- Optional
	--         { "saadparwaiz1/cmp_luasnip" }, -- Optional
	--         { "hrsh7th/cmp-nvim-lua" }, -- Optional
	--
	--         -- Snippets
	--         { "L3MON4D3/LuaSnip" }, -- Required
	--         { "rafamadriz/friendly-snippets" }, -- Optional
	--
	--         -- Optional
	--         { "simrat39/rust-tools.nvim" },
	--     },
	-- },
}
