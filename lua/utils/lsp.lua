local M = {}

M.get_lsp_client_name = function (msg)
    msg = msg or "LS Inactive"
    local buf_clients = vim.lsp.buf_get_clients()
    if next(buf_clients) == nil then
        -- TODO: clean up this if statement
        if type(msg) == "boolean" or #msg == 0 then
            return "LS Inactive"
        end
        return msg
    end
    local buf_ft = vim.bo.filetype
    local buf_client_names = {}

    -- add client
    for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
            table.insert(buf_client_names, client.name)
        end
    end

    -- add formatter
    local formatters = require "lvim.lsp.null-ls.formatters"
    local supported_formatters = formatters.list_registered_providers(buf_ft)
    vim.list_extend(buf_client_names, supported_formatters)

    -- add linter
    local linters = require "lvim.lsp.null-ls.linters"
    local supported_linters = linters.list_registered_providers(buf_ft)
    vim.list_extend(buf_client_names, supported_linters)

    return table.concat(buf_client_names, ", ")
end

return M
