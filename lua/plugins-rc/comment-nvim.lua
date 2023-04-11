local Comment = _G.safe_require("Comment")
if not Comment then
    return
end

Comment.setup({
    ---Add a space b/w comment and the line
    padding = true,
    ---Whether the cursor should stay at its position
    sticky = true,
    ---Lines to be ignored while (un)comment
    ignore = nil,
    ---Function to call before (un)comment
    pre_hook = nil,
    ---Function to call after (un)comment
    post_hook = nil,
})
-- Comment.setup({
-- 	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
-- })

-- local call = require('Comment.api').call
--
-- vim.keymap.set(
--     'n',
--     '<Plug>(comment_toggle_linewise)',
--     call('toggle.linewise', 'g@'),
--     { expr = true, desc = 'Comment toggle linewise' }
-- )
--
-- vim.keymap.set(
--     'n',
--     '<Plug>(comment_toggle_blockwise)',
--     call('toggle.blockwise', 'g@'),
--     { expr = true, desc = 'Comment toggle blockwise' }
-- )
--
-- -- Toggle current line or with count
-- vim.keymap.set('n', 'gcc', function()
--     return vim.v.count == 0
--         and '<Plug>(comment_toggle_linewise_current)'
--         or '<Plug>(comment_toggle_linewise_count)'
-- end, { expr = true })
--
-- -- Toggle in Op-pending mode
-- vim.keymap.set('n', 'gc', '<Plug>(comment_toggle_linewise)')
--
-- -- Toggle in VISUAL mode
-- vim.keymap.set('x', 'gc', '<Plug>(comment_toggle_linewise_visual)')
--
-- vim.keymap.set(
--     'n',
--     '<Plug>(comment_toggle_blockwise_count)',
--     call('toggle.blockwise.count_repeat', 'g@$'),
--     { expr = true, desc = 'Comment toggle blockwise with count' }
-- )
