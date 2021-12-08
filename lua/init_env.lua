-----------------------------------------------------------
-- Initial environment
-----------------------------------------------------------

local config_dir = os.getenv('MY_CONFIG_DIR')
local runtime_dir = os.getenv('MY_RUNTIME_DIR')
local path_sep = vim.loop.os_uname().version:match "Windows" and "\\" or "/"

local function join_paths(...)
    local result = table.concat({ ... }, path_sep)
    return result
end

vim.opt.rtp:remove(join_paths(vim.fn.stdpath('data'), 'site'))
vim.opt.rtp:remove(join_paths(vim.fn.stdpath('data'), 'site', 'after'))
vim.opt.rtp:prepend(join_paths(runtime_dir, 'site'))
vim.opt.rtp:append(join_paths(runtime_dir, 'site', 'after'))

vim.opt.rtp:remove(vim.fn.stdpath('config'))
vim.opt.rtp:remove(join_paths( vim.fn.stdpath('config'), 'after' ))
vim.opt.rtp:prepend(config_dir)
vim.opt.rtp:append(join_paths(config_dir, 'after'))

vim.cmd [[let &packpath = &runtimepath]]
vim.cmd [["set spellfile" .. join_paths(config_dir, "spell", "en.utf-8.add")]]

