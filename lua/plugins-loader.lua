local home_dir = os.getenv("HOME")
local my_nvim = os.getenv("MY_NVIM")
local config_dir = home_dir .. "/.config/" .. my_nvim
local runtime_dir = home_dir .. "/.local/share/" .. my_nvim
local lazy_dir = runtime_dir .. "/lazy"
local lazypath = lazy_dir .. "/lazy.nvim"

if vim.fn.isdirectory(lazypath) == 0 then
	vim.notify(
		"  Installing lazy...",
		vim.log.levels.INFO,
		{ title = "lazy.nvim" }
	)
	vim.fn.system {
		"git",
		"clone",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	}
end

vim.opt.runtimepath:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	return
end

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

local opts = {
	root = lazy_dir,
	install = {
		-- install missing plugins on startup. This doesn't increase startup time.
		missing = true,
		-- try to load one of these colorschemes when starting an installation during startup
		colorscheme = { "gruvbox", "onedark" },
	},
	lockfile = vim.fn.stdpath "data" .. "/lazy-lock.json", -- lockfile generated after running update.
}

lazy.setup("plugins", opts)
