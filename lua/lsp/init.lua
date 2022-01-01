-----------------------------------------------------------
-- LSP Module
-----------------------------------------------------------
local lsp_installer = safe_require('nvim-lsp-installer')
local lspconfig = safe_require('lspconfig')
if (not lsp_installer) or (not lspconfig) then
    return
end

--------------------------------------------------------------------
-- Local functions
------- -------------------------------------------------------------

-- Print diagnostics to message area
function PrintDiagnostics(opts, bufnr, line_nr, client_id)
  opts = opts or {}

  bufnr = bufnr or 0
  line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)

  local line_diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr, line_nr, opts, client_id)
  if vim.tbl_isempty(line_diagnostics) then return end

  local diagnostic_message = ""
  for i, diagnostic in ipairs(line_diagnostics) do
    diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
    print(diagnostic_message)
    if i ~= #line_diagnostics then
      diagnostic_message = diagnostic_message .. "\n"
    end
  end
  vim.api.nvim_echo({{diagnostic_message, "Normal"}}, false, {})
end

--------------------------------------------------------------------
-- Main Process
--------------------------------------------------------------------

-- Install Language Servers
require('lsp.installer')

-- Setup Language Servers
require('lsp.manager')

--------------------------------------------------------------------
-- Setup UI: Diannostics
--------------------------------------------------------------------

-- Change diagnostic symbols in the sign column (gutter)
local diagnostic_signs = {
    Error = '',
    Warn = '',
    Hint = '',
    Info = ''
}
for type, icon in pairs(diagnostic_signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Customizing how diagnostics are displayed
vim.diagnostic.config({
    underline = true,
    -- disable virtual text
    -- virtual_text = false,
    -- virtual_text = true,
    virtual_text = {
        spacing = 2,
        severity_limit = 'Warning',
    },
    -- show signs
    signs = {
        active = diagnostic_signs,
    },
    update_in_insert = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

-- Setup UI: hover and popup dispalyed contents
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
})
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'rounded',
})

-- Print diagnostics to message area
-- vim.cmd [[ autocmd CursorHold * lua PrintDiagnostics() ]]
-- Use floating popup window to display diagnostics from Language Server: Ref: on_attach

-- Show line diagnostics automatically in hover window
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

require('lspconfig').pyright.setup({
    handlers = {
        ['textDocument/publishDiagnostics'] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
                --Disable virtual_text
                virtual_text = {
                    spacing = 2,
                    severity_limit = 'Warning',
                },
                -- Enable signs
                -- signs = true,
                signs = false,
                -- Disable hint
                -- tagSupport = 'Unnecessary',
                tagSupport = true,
            }
        )
    }
})
