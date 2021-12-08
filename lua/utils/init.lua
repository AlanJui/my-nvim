local M = {}

function M:is_empty(str)
	return str == nil or str == ''
end

function M:print_table(table)
    for k, v in pairs(table) do
        print('key = ', k, "    value = ", v)
    end
end

return M
