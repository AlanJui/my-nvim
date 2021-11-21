" emmet-vim.rc.vim
let g:user_emmet_mode='a'

" Enable just for html/css
let g:user_emmet_install_global = 0
autocmd FileType html, htmldjango, css EmmetInstall

" Redefine trigger key
let g:user_emmet_leader_key = '<C-Y>'
" let g:user_emmet_leader_key = '<C-Z>'
