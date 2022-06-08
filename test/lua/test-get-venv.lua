local util = require('utils.python')
local venv_python = util.get_python_path_in_venv()
if not venv_python then
    venv_python = ''
end

print(string.format('$VIRTUAL_ENV = %s', venv_python))

