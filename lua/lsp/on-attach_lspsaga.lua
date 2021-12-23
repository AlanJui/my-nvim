-- on_attach for LspSaga
local M = {}

-- Handler to attach LSP keymappings to buffers using LSP Saga.
M.lsp_saga = function(client, bufnr)
  -- helper methods for setting keymaps
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

  --- Mappings
  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', 'gr', "<cmd>Lspsaga rename<CR>", opts)
  buf_set_keymap('n', 'gx', "<cmd>Lspsaga code_action<CR>", opts)
  buf_set_keymap('x', 'gx', ":<C-u>Lspsaga range_code_action<CR>", opts)
  buf_set_keymap('n', 'K',  "<cmd>Lspsaga hover_doc<CR>", opts)
  buf_set_keymap('n', 'gh', "<cmd>lua require('lspsaga.provider').lsp_finder()<CR>", opts)

  -- Scroll up/down hover doc or scroll in definition preview popups
  buf_set_keymap('n', '<C-u>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts)
  buf_set_keymap('n', '<C-d>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts)

  -- View diagnostics
  buf_set_keymap('n', ';d', "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
  buf_set_keymap('n', '[d', "<cmd>Lspsaga lsp_jump_diagnostic_prev()<CR>", opts)
  buf_set_keymap('n', ']d', "<cmd>Lspsaga lsp_jump_diagnostic_next()<CR>", opts)

  -- Navigate and preview
  buf_set_keymap('n', 'gd', "<cmd>lua require('lspsaga.provider').preview_definition()<CR>", opts)
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gs', "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", opts)
end

return M
