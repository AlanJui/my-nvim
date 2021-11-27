-- import module: lspconfig

-- options for lsp diagnostic
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable underline, use default values
    underline = true,
    -- Enable virtual text, ovveride spacing to 6
    virtual_text = {
      spacing = 6,
      prefix = '',
      -- severity_limit = 'Error'  -- Only show virtual text on error
    },
    -- Use a function to dynamically turn signs off
    -- and on, using buffer local variables
    signs =  function(bufnr, client_id)
        local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, 'show_signs')
        -- No buffer local variable set, so just enable by default
        if not ok then
            return true
        end

        return result
    end,
    -- Disable a feature
    update_in_insert = false,
    --
    -- signs = true,
    -- update_in_insert = true,
  }
)

-- set LSP diagnostic symbols/signs
vim.api.nvim_command [[ sign define LspDiagnosticsSignError         text=✗ texthl=LspDiagnosticsSignError       linehl= numhl= ]]
vim.api.nvim_command [[ sign define LspDiagnosticsSignWarning       text=⚠ texthl=LspDiagnosticsSignWarning     linehl= numhl= ]]
vim.api.nvim_command [[ sign define LspDiagnosticsSignInformation   text= texthl=LspDiagnosticsSignInformation linehl= numhl= ]]
vim.api.nvim_command [[ sign define LspDiagnosticsSignHint          text= texthl=LspDiagnosticsSignHint        linehl= numhl= ]]
