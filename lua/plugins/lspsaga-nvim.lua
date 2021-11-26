local saga = require('lspsaga')

saga.init_lsp_saga {
  error_sign = '',   -- '\u{F658}',
  warn_sign  = '',   -- '\u{F071}'
  hint_sign  = '',   -- '\u{F835}'
  infor_sign = '',
  border_style = "round",
}

-- icon: options for lsp diagnostic
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    -- This sets the spacing and the prefix, obviously.
    virtual_text = {
      spacing = 4,
      prefix = '',
      severity_limit = 'Error',   -- Only show virtual text on error
    },
    -- Use a function to dynamically turn signs off
    -- and on, using buffer local variables
    signs = function (bufnr, client_id)
        local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, 'show_signs')
        -- No buffer local variable set, so just enable by default
        if not ok then
            return true
        end

        return result
    end,
    -- Disable a feature
    update_in_insert = false,
  }
)

-- Hover Doc
vim.cmd([[
" show hover doc
nnoremap <silent>K :Lspsaga hover_doc<CR>
]])


-- Signature help
vim.cmd([[
inoremap <silent> <C-k> <Cmd>Lspsaga signature_help<CR>
]])

-- Async LSP Finder
-- Find the cursor word definition and reference
vim.cmd([[
 nnoremap <silent> gh <Cmd>Lspsaga lsp_finder<CR>
]])

-- Diagnostics
-- npm install -g diagnostic-languageserver
vim.cmd([[
" show
nnoremap <silent>;cd <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>

" only show diagnostic if cursor is over the area
nnoremap <silent>;cc <cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>

" Set keymaps for jump diagnostic and show diagnostics:
nnoremap <silent> [e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
nnoremap <silent> ]e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>
]])
