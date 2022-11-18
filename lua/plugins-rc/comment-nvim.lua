local Comment_setup, Comment = pcall(require, 'Comment')
if not Comment_setup then
    return
end

Comment.setup({
    -- pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
})
