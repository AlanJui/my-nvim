return {
	-----------------------------------------------------------
	-- Utility
	-----------------------------------------------------------
	-- File explorer: vifm
	"vifm/vifm.vim",
	-- Floater Terminal
	"voldikss/vim-floaterm",
	{
		"rcarriga/nvim-notify",
		enabled = false,
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{
				"stevearc/dressing.nvim",
			},
		},
		config = function()
			require("notify").setup {
				level = 2,
				minimum_width = 50,
				render = "default",
				stages = "fade",
				timeout = 3000,
				top_down = true,
			}

			vim.notify = require "notify"
		end,
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
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = "markdown",
	},
}
