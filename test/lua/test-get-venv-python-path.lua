
-- local python_path = os.getenv('VIRTUAL_ENV')
-- print(string.format('$VIRTUAL_ENV = %s', python_path))
-- if python_path == nil then
--     print('is nil')
-- else
--     print('???')
-- end


function _G.get_python_path_in_venv()
    local venv = os.getenv("VIRTUAL_ENV")
    if venv == nil then
        return
    else
        return vim.fn.getcwd() .. string.format("%s/bin/python", venv)
    end
end

local venv_path = get_python_path_in_venv()
print('venv_path = ', venv_path)
if venv_path == nil then
    print('環境變數未設定：venv_path == nil', venv_path)
end
if not venv_path then
    print('環境變數未設定：not venv_path', venv_path)
end
