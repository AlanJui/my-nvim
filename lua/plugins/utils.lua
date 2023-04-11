return {
	-----------------------------------------------------------
	-- Utility
	-----------------------------------------------------------

  -- measure startuptime
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  -- session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" } },
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },

  -- library used by other plugins
  { "nvim-lua/plenary.nvim", lazy = true },

  -- makes some plugins dot-repeatable like leap
  { "tpope/vim-repeat", event = "VeryLazy" },
	
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
