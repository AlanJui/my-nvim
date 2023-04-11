-----------------------------------------------------------
-- Neovim options
-----------------------------------------------------------
-- Configurations of Neovim
vim.cmd([[
let g:tex_flavor = "latex"
]])

-----------------------------------------------------------
-- folding
-- opt.foldmethod = "indent"
-- opt.foldnestmax = 10
-- opt.foldenable = true
-- opt.foldlevel = 2

-- 打開文件時禁用 Neovim 的折疊功能，
-- vim.api.nvim_exec([[
--   autocmd BufRead,BufNewFile * setlocal nofoldenable
-- ]], false)
vim.api.nvim_exec(
    [[
        autocmd BufRead,BufNewFile *.lua setlocal nofoldenable
    ]],
    false
)
