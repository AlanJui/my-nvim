-- on_attach.lua

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
-- Process:
--  * Enable completion and how to triggered
--  * key mapping conditional on server capabilities
--     - ff for whole file formatting: lua vim.lsp.buf.formatting()
--     - ff for range formatting: lua vim.lsp.buf.range_formatting()
--  * set autocommands conditional on server_capabilities
--     > resolve document_hightlight
--     > auto-format on save file

local function on_attach(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Key Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions

    -- Navigate between code
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<LocalLeader>t', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

    -- inspect documents for the code
    buf_set_keymap('n', 'K',     '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<LocalLeader>s', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

    -- View diagnostics
    -- buf_set_keymap('n', '<LocalLeader>dl', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    -- buf_set_keymap('n', '<LocalLeader>d',  '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d',  '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d',  '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

    -- actions
    buf_set_keymap('n', '<LocalLeader>r',  '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<LocalLeader>f',  '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    -- workspace
    -- buf_set_keymap('n', '<LocalLeader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    -- buf_set_keymap('n', '<LocalLeader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<LocalLeader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)

    --------------------------------------------------------------------
    -- Set autocommands conditional on server_capabilities
    -- {resolved_capabilities} (table): Normalized table of capabilities
    -- that we have detected based on the initialize response from the
    -- server in `server_capabilities`.
    --------------------------------------------------------------------

    -- Hightlight diagnostics symbol under cursor
    if client.resolved_capabilities.document_highlight then
        vim.cmd([[
            hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
            hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
            hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]])
    end

    -- CodeAction
    if client.name == 'null-ls' then
        client.resolved_capabilities.code_action = false
    end
    if client.resolved_capabilities.code_action then
        buf_set_keymap('n', '<LocalLeader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        buf_set_keymap('n', '<LocalLeader>ra', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
        -- vim.cmd([[
        --     augroup lsp_code_actions
        --         autocmd! * <buffer>
        --         autocmd CursorHold,CursorHoldI <buffer> lua require('nvim-lightbulb').update_lightbulb()
        --     augroup end
        -- ]])
        vim.cmd([[
        autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()
        ]])
    end

    -- Auto formatting
    -- Let it format on save
    if client.name == 'tsserver' then
        client.resolved_capabilities.document_formatting = false
    end

    if client.resolved_capabilities.document_formatting then
        vim.cmd([[
        augroup Format
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
        augroup end
        ]])
    end

    -- -- TODO
    -- --   if client.name == 'tsserver' then
    -- local ts_utils = safe_require 'nvim-lsp-ts-utils'
    -- if ts_utils then
    --     ts_utils.setup {}
    --     ts_utils.setup_client(client)
    -- end

    -- -- So that the only client with format capabilities is efm
    -- if client.name ~= 'efm' then
    --     client.resolved_capabilities.document_formatting = false
    -- end

    -- if client.resolved_capabilities.document_formatting then
    --     vim.cmd [[
    --     augroup Format
    --     au! * <buffer>
    --     au BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
    --     augroup END
    --     ]]
    -- end
end

return on_attach
