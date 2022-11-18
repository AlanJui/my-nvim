local status, consolation = pcall(require, "consolation")
if not status then
	return
end

local Wrapper = require("consolation").Wrapper

BuiltinTerminalWrapper = Wrapper:new()
BuiltinTerminalWrapper:setup({
	create = function()
		vim.cmd("vnew | term")
	end,
	open = function(self)
		if self:is_open() then
			local winnr = vim.fn.bufwinnr(self.bufnr)
			vim.cmd(winnr .. "wincmd w")
		else
			vim.cmd("vnew")
			vim.cmd("b" .. self.bufnr)
		end
	end,
	close = function(self)
		local winnr = vim.fn.bufwinnr(self.bufnr)
		vim.cmd(winnr .. "wincmd c")
	end,
	kill = function(self)
		vim.cmd("bd! " .. self.bufnr)
	end,
})

-- Try:

-- BuiltinTerminalWrapper:open {cmd = "echo hi"}
-- BuiltinTerminalWrapper:send_command {cmd = "echo hi again"}
-- BuiltinTerminalWrapper:close()
-- BuiltinTerminalWrapper:toggle()
-- BuiltinTerminalWrapper:kill()
