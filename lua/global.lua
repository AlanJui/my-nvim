-----------------------------------------------------------
-- Global Functions
-----------------------------------------------------------

function _G.join_paths(...)
    local PATH_SEPERATOR = vim.loop.os_uname().version:match "Windows" and "\\" or "/"
    local result = table.concat({ ... }, PATH_SEPERATOR) return result
end

function _G.safe_require(module)
  local ok, result = pcall(require, module)
  if not ok then
    vim.notify(string.format('Error requiring: %s', module), vim.log.levels.ERROR)
    return ok
  end
  return result
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

function _G.is_empty(str)
    return str == nil or str == ''
end

function _G.print_rtp()
    print(string.format('rtp = %s', vim.opt.rtp['_value']))
end

function Print_table(a_table)
    for k, v in pairs(a_table) do
        print('key = ', k, "    value = ", v)
    end
end
