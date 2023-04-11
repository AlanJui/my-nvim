" URL: https://zhuanlan.zhihu.com/p/158604935
" 禁用插件的映射
" let g:plugin_disable_mappings = 1

" 禁止 Plugin 本身，使用「預設」按鍵
let g:surround_no_mappings = 1

" 使用者自訂快捷鍵
nmap ds <Plug>Dsurround
nmap cs <Plug>Csurround
nmap cS <Plug>CSurround
" nmap ys <Plug>Ysurround
" nmap yS <Plug>YSurround
" nmap yss <Plug>Yssurround
" nmap ySs <Plug>YSsurround
" nmap ySS <Plug>YSsurround

" 取消不需要的快捷键
"xmap S   <Plug>VSurround
"xmap gS  <Plug>VgSurround
"imap   <C-S> <Plug>Isurround
imap    <C-G>s <Plug>Isurround
imap    <C-G>S <Plug>ISurround
