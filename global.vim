"==============================================================
" Vim 通用設定
"==============================================================

" 與作業系統共用 Clipboard
" 欲將系統剪貼簿的內容貼入 Vim 前，需先按 <F2> 鍵。
set clipboard=unnamed

set undolevels=700
set history=1000
set timeout timeoutlen=500


"--------------------------------------------------------------
" 應用系統層級設定

" 令程式碼檔案可有語法（Syntax）高亮標示
" syntax on
" set background=dark

" User will have bad experience for diagnostic messages when it's default 4000
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
" set signcolumn=yes

set nocompatible            " Disable compatibility to old-time vi

set mouse=a

"--------------------------------------------------------------
" 檔案作業

set encoding=UTF-8

" 支援的檔案格式
set fileformats=unix,dos,mac

" 停用 backup 與 swap 功能
set nobackup
set nowritebackup
set noswapfile

" 文字搜尋：Serach configuration
set ignorecase              " 搜尋時怱略英文字母的大小寫
set smartcase               " turn on smartcase
set incsearch
set hlsearch                " highlight search results

