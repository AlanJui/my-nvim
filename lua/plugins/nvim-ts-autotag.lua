-- nvim-ts-autotag.lua
require('nvim-treesitter.configs').setup({
    autotag = {
        enable = true,
        filetypes = { "html", "htmldjango", "xml", "javascript", "javascriptreact", "typescriptreact", "vue" },
    }
})

-- require('nvim-ts-autotag').setup({
--     filetypes = { "html", "htmldjango", "xml", "javascript", "javascriptreact", "typescriptreact", "vue" },
-- })

-- vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
--     vim.lsp.diagnostic.on_publish_diagnostics,
--     {
--         underline = true,
--         virtual_text = {
--             spacing = 5,
--             severity_limit = 'Warning',
--         },
--         update_in_insert = true,
--     }
-- )
