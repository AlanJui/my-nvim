-----------------------------------------------------------------------
-- My global functions
-----------------------------------------------------------------------
PATH_SEPERATOR = vim.loop.os_uname().version:match "Windows" and "\\" or "/"

function Join_paths(...)
    local result = table.concat({ ... }, PATH_SEPERATOR) return result
end

function P(cmd)
  print(vim.inspect(cmd))
end

function _G.which_os()
    local system_name

    if vim.fn.has("mac") == 1 then
        system_name = "macOS"
    elseif vim.fn.has("unix") == 1 then
        system_name = "Linux"
    elseif vim.fn.has('win32') == 1 then
        system_name = "Windows"
    else
        system_name = ''
    end

    return system_name
end

function _G.print_table(table)
    for k, v in pairs(table) do
        print('key = ', k, "    value = ", v)
    end
end

function _G.is_git_dir()
  return os.execute 'git rev-parse --is-inside-work-tree >> /dev/null 2>&1'
end

function _G.is_empty(str)
	return str == nil or str == ''
end

function _G.safe_require(module)
  local ok, result = pcall(require, module)
  if not ok then
    vim.notify(string.format('Error requiring: %s', module), vim.log.levels.ERROR)
    return ok
  end
  return result
end

function Is_empty(str)
    return str == nil or str == ''
end

-- function Print_rtp()
--     print(string.format('rtp = %s', vim.opt.rtp['_value']))
-- end

-----------------------------------------------------------------------
-- My module
-----------------------------------------------------------------------
local M = {}

local is_transparent = true
function M.toggle_background()
  if is_transparent == true then
    vim.cmd [[ hi Normal guibg=NONE ctermbg=NONE ]]
    is_transparent = false
  else
    vim.cmd [[ set background=dark ]]
    is_transparent = true
  end
end

-----------------------------------------------------------------------
-- Key Mappings Submodule
-----------------------------------------------------------------------
M.keymap = {}

local options = { noremap = true, silent = true }

function M.keymap.buf_map(mode, key, cmd, opts)
  vim.api.nvim_buf_set_keymap(0, mode, key, cmd, opts or options)
end

function M.keymap.map(mode, key, cmd, opts)
  vim.api.nvim_set_keymap(mode, key, cmd, opts or options)
end

return M
