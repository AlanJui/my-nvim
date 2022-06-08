-- Tabs
vim.bo.expandtab = true
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4

vim.cmd [[
syn region  djangotagmarkers start="{{" end="}}"
syn region  djangovariablemarkers start="{%" end="%}"
command! -nargs=+ HiLink hi def link <args>
HiLink djangotagmarkers PreProc
HiLink djangovariablemarkers PreProc
delcommand HiLink
]]
