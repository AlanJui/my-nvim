# 設定指引

## Vim Script 寫法

檢查 plugin ，確認已安裝，再執行以下之設定作業

### 簡式作法

```vimscript
if !exists('g:loaded_cmp') | finish | endif
```

### 完整作法

```vimscript
if !exists('g:loaded_vimtex')
  echom "Not loaded vimtex"
  finish
endif
```

## Lua Script 寫法

```lua
lua << EOF
--vim.lsp.set_log_level("debug")
local status, lualine = pcall(require, "vimtex")
if (not status) then return end
EOF
```
