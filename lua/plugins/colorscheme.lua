return {
	-----------------------------------------------------------
	-- colorscheme for neovim written in lua specially made for roshnvim
	-----------------------------------------------------------
	{
		"bluz71/vim-nightfly-colors",
		config = function()
			vim.cmd [[colorscheme nightfly]]
		end,
	},
	"bluz71/vim-moonfly-colors",
	"shaeinst/roshnivim-cs",
	"mhartington/oceanic-next",
	{
		"folke/tokyonight.nvim",
		-- config = function()
		-- 	-- Tokyo Night Color Scheme Configuration
		-- 	-- vim.g.tokyonight_style = 'day'
		-- 	-- vim.g.tokyonight_style = 'night'
		-- 	vim.cmd([[ colorscheme tokyonight ]])
		-- 	vim.g.tokyonight_style = "storm"
		-- 	vim.g.tokyonight_italic_functions = true
		-- 	vim.g.tokyonight_dark_float = true
		-- 	vim.g.tokyonight_transparent = true
		-- 	vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
		-- 	-- Change the "hint" color to the "orange" color,
		-- 	-- and make the "error" color bright red
		-- 	vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
		-- end,
	}
}
