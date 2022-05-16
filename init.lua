vim.bo.expandtab = true
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4

-----------------------------------------------------------
-- Tabs process
-----------------------------------------------------------
-- To convert tabs to spaces
-- 🆑 :set noexpandtab
-- 🆑 :retab!
-- 🆑 :set expandtab
-- 🆑 :retab!
-- Configure neovim convert tabs to spaces but not include yaml filetype
vim.cmd([[
	set tabstop=8 softtabstop=4 shiftwidth=4 expandtab
	autocmd FileType make       setlocal noexpandtab
	autocmd FileType javascript setlocal softtabstop=2 shiftwidth=2 expandtab
	autocmd FileType yaml setlocal softtabstop=2 shiftwidth=2 expandtab
	autocmd FileType yaml execute  ':silent! %s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
]])

vim.cmd([[
	set list
	set listchars=tab:▷▷,trail:.
	" Highlight tabs as errors.
	" https://vi.stackexchange.com/a/9353/3168
	match Error /\t/
]])
