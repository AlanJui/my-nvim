local M = {}

local get_venv_name = function (venv)
    if string.find(venv, "/") then
        local final_venv = venv
        for w in venv:gmatch "([^/]+)" do
            final_venv = w
        end
        venv = final_venv
    end
    return venv
end

M.getVirtualEnv = function ()
    if vim.bo.filetype == "python" then
        local venv = os.getenv "CONDA_DEFAULT_ENV"
        if venv then
            -- return string.format("  (%s)", get_venv_name(venv))
            return string.format("(%s)", get_venv_name(venv))
        end
        venv = os.getenv "VIRTUAL_ENV"
        if venv then
            -- return string.format("  (%s)", get_venv_name(venv))
            return string.format("(%s)", get_venv_name(venv))
        end
        return ""
    end
    return ""
end

return M
