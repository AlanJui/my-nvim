-----------------------------------------------------------
-- Global Functions
-----------------------------------------------------------
function _G.is_empty(str)
	return str == nil or str == ""
end

function _G.join_paths(...)
	local PATH_SEPERATOR = vim.loop.os_uname().version:match("Windows") and "\\" or "/"
	local result = table.concat({ ... }, PATH_SEPERATOR)
	return result
end

function _G.is_git_dir()
	return os.execute("git rev-parse --is-inside-work-tree >> /dev/null 2>&1")
end

function _G.safe_require(module)
	local ok, result = pcall(require, module)
	if not ok then
		vim.notify(string.format("Error requiring: %s", module), vim.log.levels.ERROR)
		return nil, result
	end
	return result
end

function _G.which_os()
	local system_name

	if vim.fn.has("mac") == 1 then
		system_name = "macOS"
	elseif vim.fn.has("unix") == 1 then
		system_name = "Linux"
	elseif vim.fn.has("win32") == 1 then
		system_name = "Windows"
	else
		system_name = ""
	end

	return system_name
end

function P(cmd)
	print(vim.inspect(cmd))
end

function PrintTable(a_table)
	for k, v in pairs(a_table) do
		print("key = ", k, "    value = ", v)
	end
end

function _G.print_table(table)
	for k, v in pairs(table) do
		print("key = ", k, "    value = ", v)
	end
end

-- Setup runtimepath(rtp):
function SetupRTP(config_dir, runtime_dir)
	-- 變更 stdpath('config') 預設的 rtp : ~/.config/nvim/
	vim.opt.rtp:remove(join_paths(vim.fn.stdpath("data"), "site"))
	vim.opt.rtp:remove(join_paths(vim.fn.stdpath("data"), "site", "after"))
	vim.opt.rtp:prepend(join_paths(runtime_dir, "site"))
	vim.opt.rtp:append(join_paths(runtime_dir, "site", "after"))

	-- 變更 stdpath('data') 預設的 rtp : ~/.local/share/my-nvim/
	vim.opt.rtp:remove(vim.fn.stdpath("config"))
	vim.opt.rtp:remove(join_paths(vim.fn.stdpath("config"), "after"))
	vim.opt.rtp:prepend(config_dir)
	vim.opt.rtp:append(join_paths(config_dir, "after"))

	-- 引用 rpt 設定 package path （即擴充擴件(plugins)的安裝路徑）
	-- 此設定需正確，指令：requitre('<PluginName>') 才能正常執行。
	vim.cmd([[let &packpath = &runtimepath]])
end

function _G.print_rtp()
	print(string.format("rtp = %s", vim.opt.rtp["_value"]))
end
