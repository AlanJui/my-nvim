local lspsaga = require('lspsaga')

lspsaga.init_lsp_saga {
  -- error_sign = '',   -- '\u{F658}',
  -- warn_sign  = '',   -- '\u{F071}'
  -- hint_sign  = '',   -- '\u{F835}'
  -- infor_sign = '',
  border_style = "round",
}

lspsaga.setup { -- defaults ...
  debug = false,
  use_saga_diagnostic_sign = true,
  -- diagnostic sign
  error_sign = "",
  warn_sign = "",
  hint_sign = "",
  infor_sign = "",
  diagnostic_header_icon = "   ",
  -- code action title icon
  code_action_icon = " ",
  code_action_prompt = {
    enable = true,
    sign = true,
    sign_priority = 40,
    virtual_text = true,
  },
  finder_definition_icon = "  ",
  finder_reference_icon = "  ",
  max_preview_lines = 10,
  finder_action_keys = {
    open = "o",
    vsplit = "s",
    split = "i",
    quit = "q",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
  },
  code_action_keys = {
    quit = "q",
    exec = "<CR>",
  },
  rename_action_keys = {
    quit = "<C-c>",
    exec = "<CR>",
  },
  definition_preview_icon = "  ",
  border_style = "single",
  rename_prompt_prefix = "➤",
  server_filetype_map = {},
  diagnostic_prefix_format = "%d. ",
}

-- icon: options for lsp diagnostic
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    -- This sets the spacing and the prefix, obviously.
    virtual_text = {
      spacing = 6,
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

-- Colors can be simply changed by overwriting the default highlights groups LspSaga is using.
-- highlight link LspSagaFinderSelection guifg='#ff0000' guibg='#00ff00' gui='bold'
vim.cmd([[
highlight link LspSagaFinderSelection Search
]])

-- --- In lsp attach function
-- local map = nvim_buf_set_keymap,
-- map(0, "n", "gr", "<cmd>Lspsaga rename<cr>", {silent = true, noremap = true})
-- map(0, "n", "gx", "<cmd>Lspsaga code_action<cr>", {silent = true, noremap = true})
-- map(0, "x", "gx", ":<c-u>Lspsaga range_code_action<cr>", {silent = true, noremap = true})
-- map(0, "n", "K",  "<cmd>Lspsaga hover_doc<cr>", {silent = true, noremap = true})
-- map(0, "n", "go", "<cmd>Lspsaga show_line_diagnostics<cr>", {silent = true, noremap = true})
-- map(0, "n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", {silent = true, noremap = true})
-- map(0, "n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", {silent = true, noremap = true})
-- map(0, "n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>")
-- map(0, "n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>")

-- -- Hover Doc
-- vim.cmd([[
-- " show hover doc
-- nnoremap <silent>K :Lspsaga hover_doc<CR>
-- ]])
--
--
-- -- Signature help
-- vim.cmd([[
-- inoremap <silent> <C-k> <Cmd>Lspsaga signature_help<CR>
-- ]])
--
-- -- Async LSP Finder
-- -- Find the cursor word definition and reference
-- vim.cmd([[
--  nnoremap <silent> gh <Cmd>Lspsaga lsp_finder<CR>
-- ]])
--
-- -- Diagnostics
-- -- npm install -g diagnostic-languageserver
-- vim.cmd([[
-- " show
-- nnoremap <silent>;cd <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>
--
-- " only show diagnostic if cursor is over the area
-- nnoremap <silent>;cc <cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>
--
-- " Set keymaps for jump diagnostic and show diagnostics:
-- nnoremap <silent> [e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
-- nnoremap <silent> ]e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>
-- ]])
