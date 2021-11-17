" vim-better-whitespace.rc.vim
" Plugin configuraiton: vim-better-whitespace
" =============================================================================
"
" To enable/disable/toggle whitespace highlighting in a buffer, call one of:
" :EnableWhitespace
" :DisableWhitespace
" :ToggleWhitespace
"
" To enable/disable stripping of extra whitespace on file save for a buffer, call one of:
" :EnableStripWhitespaceOnSave
" :DisableStripWhitespaceOnSave
" :ToggleStripWhitespaceOnSave
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

autocmd FileType dashboard DisableWhitespace

" Disable white spacing highlights.
let g:better_whitespace_filetypes_blacklist = [ 'dashboard', 'packer', 'diff', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'fugitive' ]

" Don't ask for confirmation before whitespace is stripped when you save the file.
let g:strip_whitespace_confirm = 0

" Not to highlight space space characters that apper before on in-between tabs
let g:show_spaces_that_precede_tabs=1
