local lsp_status = require('lsp-status')
lsp_status.register_progress()

lsp_status.config({
    indicator_errors = '✗',
    indicator_warnings = '⚠',
    indicator_info = '',
    indicator_hint = '',
    indicator_ok = '✔',
    current_function = true,
    diagnostics = false,
    update_interval = 100,
    status_symbol = ' 🇻',
    -- select_symbol = nil,
    select_symbol = function (cursor_pos, symbol)
        if symbol.valueRange then
            local value_range = {
                ["start"] ={
                    character = 0,
                    line = vim.fn.byte2line(symbol.valueRange[1])
                },
                ["end"] = {
                    character = 0,
                    line = vim.fn.byte2line(symbol.valueRange[2])
                }
            }

            return require('lsp-status.util').in_range(cursor_pos, value_range)
        end
    end
})

-- Language Server
-- local lspconfig = require('lspconfig')
--
-- lspconfig.pyls_ms.setup({
--     handlers = lsp_status.extensions.pyls_ms.setup(),
--     settings = {
--         python = { workspaceSymbols = { enabled = true } },
--     },
--     on_attach = lsp_status.on_attach,
--     capabilities = lsp_status.capabilities
-- })

-- Status Line
vim.cmd([[
function! LspStatus() abort
    if luaeval('#vim.lsp.buf_get_clients() > 0')
        return luaeval("require('lsp-status').status()")
    endif

    return ''
endfunction
]])
