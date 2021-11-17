local M = {}

M.get_system = function ()
    local system_name

    if vim.fn.has("mac") == 1 then
        system_name = "macOS"
    elseif vim.fn.has("unix") == 1 then
        system_name = "Linux"
    elseif vim.fn.has('win32') == 1 then
        system_name = "Windows"
    else
        -- Unsupported system
        system_name = ''
    end

    return system_name
end

return M
