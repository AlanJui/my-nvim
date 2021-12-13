# 專案指引

## 專案簡介

Neovim 0.5 的發行，令 Neovim 推進到一個更加高階的里程碑。對於有心打造符合自己
需求，個人專用編輯器的使用者，Neovim 0.5 支援 LSP 及 Lua Script 的新功能，讓
懷抱著這個夢想的人們，可以有機會美夢成真。

【附註】：[Neovim Language Server Protocol (LSP) 主要功能列表：](https://neovim.io/doc/lsp/)

 - Go to definition：定義跳轉
 - (auto)completion：自動補全
 - Code Actions (automatic formatting, organize imports, ...)：
	 程式碼操作，如：自動調整排版、組識 import 順序...等
 - Show method signatures：顯示用法
 - Show/go to references：顯示/跳轉引用處
 - snippets：程式碼片段

當 Neovim 0.5 還在 Beta 版，便已開始使用，如今 Neovim 0.6 都已推出了，個人對
Neovim 的掌握度，仍是一知半解。想要擺脫這種狀態，於是想要進行深入的研究；想
要檢驗研究的結果是否有達標，需要設定目標。所以，將個人在 Django Project 的
應用需要，當成是這個研究的「專案需求」：

 - 程式編碼可用自動補全，加快輸入及避免打字錯誤
 - 程式碼在呼叫某 method/function 時，能「顯示用法」，提示該輸入的引數順序，
	 及應使用的資料類型（Data Type）
 - 可使用 snippets ，加速編碼工作及避免打字錯誤
 - 原先在 VS Code 已建置的 Snippets ，能於 Neovim 環境套用
 - 自動檢查程式碼，確保沒有語法的錯誤
 - 程式碼已被檢查到的錯誤，可提示：「統計總數」、「標示位置」
 - 適用於 Django 開發專案
 - 可編輯及預覽 Markdown 文件，以便可以與 VuePress 整合，作為「技術文件」編輯器
 - 可使用如 PlantUML 的工具，繪製 UML Diagrams
 - 可以透過 (DAP)[https://alpha2phi.medium.com/neovim-dap-enhanced-ebc730ff498b]
	 與 Neovim 整合，讓 Neovim 可像 VS Code 一樣，能當除錯（Debug）工具

## 先決條件（Prerequisites）

- [Neovim 0.6](https://alanjui.github.io/my-dev-env/nvim/#%E5%AE%89%E8%A3%9D%E8%88%87%E6%93%8D%E4%BD%9C)
- [Python](https://alanjui.github.io/my-docs/python.html#install-python-tools)
- [Node.js](https://alanjui.github.io/my-docs/nodejs.html#%E5%AE%89%E8%A3%9D%E8%88%87%E8%A8%AD%E5%AE%9A)
- [Lua Langage Server](https://alanjui.github.io/my-docs/lua.html#install-lua-support-for-vim-neovim)


## 安裝與設定作業（Setup process）

### 1. 下載（Download）

```sh
git clone git@github.com:AlanJui/my-nvim.git ~/.config
```

### 2. 安裝插件（Install plugins）

本專案使用 packer.nvim 作為 Neovim 的「插件管理工具」。Neovim 啟動後將自動安裝
packer.nvim 插件；而專案使用到的其它插件，其安裝工作，也會由 packer.nvim 自動
執行。

(1) 安裝執行檔（可啟動 Neovim 的 Shell Script 執行檔）

除非使用者做過設定，否則不能以 nvim 直接啟動 Neovim ，需要透過本專案提供的
Shell Script 執行檔： `my-nvim` 才能正常運作。

請依下列指令，完成 my-nvim 執行檔的安裝作業。

```sh
$ mkdir -p ~/.local/bin
$ cd ~/.config/my-nvim
$ ln -fns tools/my-nvim ~/.local/bin/
```

請記得在您所使用的 Bash Shell 或 ZSH Shell ，於 PATH 環境變數中加入
`~/.local/bin` 搜尋路徑。

```sh
...
export PATH="$HOME/.local/bin:$PATH"
```

重啟 Bash / ZSH Shell

```sh
source ~/.bashrc
```

或

```sh
source ~/.zshrc
```

(2) 安裝插件

在終端機輸入列指令，令 Neovim 可自動下載 nvim.packer 這插件管理工具，並安裝
其它本專案會用到的插入（plugins）。

每個插件在完成下載及安裝的工作後，均會顯示結果回報在畫面上，待看到「... has been
installed」的時候，則可按《Ctrl》＋《C》鍵，終結這個安裝指令。

```sh
$ my-nvim --headless
```

### 3. 操作 Neovim（Start Neovim）

本專案不會佔用 `~/.config/nvim` 這個目錄。其好處為：使用者若想自學 Neovim ，
這個目錄可留給您學習，做實驗用；但有麻煩則為：使用者若直接輸入指令 nvim ，則
無法使用本專案的 Neovim 設定。

請務必記得，需以如下指令啟動：

```
$ my-nvim
```

**【附註】：**

本專案的 Neovim 設定檔存放目錄及插件的存放目錄說明：

 - 設定存放目錄路徑： `~/.config/my-nvim/`
 - 插件存放目錄路徑： `~/.local/share/my-nvim/`

## 快捷鍵（Bindings）

【附註】：

**〈leader〉** = `《，》`

| Plugin    | Mapping      | Action                                  |
| --------- | ------------ | --------------------------------------- |
|           | \<Space\>e   | Open file explorer                      |
|           | \<Space\>;   | Open a terminal window                  |
|           | sp           | Split window horizontally               |
|           | vs           | Split window vertically                 |
|           | \<C-H\>      | Move cursor to split left               |
|           | \<C-J\>      | Move cursor to split down               |
|           | \<C-K\>      | Move cursor to split up                 |
|           | \<C-L\>      | Move cursor to split right              |
|           | fr           | Search & replace in current buffer      |
|           | tj           | Move one tab left                       |
|           | tk           | Move one tab right                      |
|           | tn           | Create a new tab                        |
|           | to           | Close all other tabs                    |
|           | gt           | Go to next tabline                      |
|           | gT           | Go to prettier tabline                  |
| coc       | \<C-@\>      | Open autocompletion                     |
| coc       | \<Enter\>    | Select autocompletion                   |
| coc       | \<S-Tab\>    | Browse previous autocompletion          |
| coc       | \<Tab\>      | Browse next autocompletion              |
| coc       | \<C-S\>      | Selections ranges                       |
| coc       | \<leader\>a  | Applying code action to selected region |
| coc       | \<leader\>ac | Applying code action for current buffer |
| coc       | \<leader\>qf | Apply AutoFix on current line           |
| coc       | \<leader\>l  | Execute code autofix                    |
| coc       | \<leader\>rn | Rename                                  |
| coc       | K            | Show document in pop up window          |
| coc       | gd           | Go to definition                        |
| coc       | gy           | Go to type definition                   |
| coc       | gi           | Go to implementation                    |
| coc       | gr           | Go to references                        |
| coc       | gr           | Go to references                        |
| coc       | [g           | Go to prettier diagnostic               |
| coc       | ]g           | Go to next diagnostic                   |
| coc       | \<Space\>a   | List all diagnostics                    |
| coc       | \<Space\>x   | List all coc extensions installed       |
| coc       | \<Space\>c   | Search command available in coc.nvim    |
| coc       | \<Space\>o   | Search symbol within outline view       |
| Telescope | ;b           | Switch opened files                     |
| Telescope | ;f           | Find file by file name                  |
| Telescope | ;g           | Find file by keyword(Live Grep)         |
| Telescope | ;t           | Open Git worktree picker                |
| Telescope | ;h           | Search help by tags                     |

## 使用插件（Plugins）

- [Lualine](https://github.com/nvim-lualine/lualine.nvim)
- [Packer](https://github.com/wbthomason/packer.nvim)
- [Plenary](https://github.com/nvim-lua/plenary.nvim)
- [Surround](https://github.com/blackCauldron7/surround.nvim)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [Tokyo Night](https://github.com/folke/tokyonight.nvim)
- [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring)
- [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)
- [vim-commentary](https://github.com/tpope/vim-commentary/)

## 維護者（Maintainers）

<a href="https://github.com/albingroen">
  <img src="https://avatars.githubusercontent.com/u/2138279?v=4" width="80" height="80" />
</a>
