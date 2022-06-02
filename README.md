# 專案指引

## 專案簡介

Neovim 0.5 的發行，令 Neovim 推進到一個更加高階的里程碑。對於有心打造符合自己
需求，個人專用編輯器的使用者，Neovim 0.5 支援 LSP 及 Lua Script 的新功能，讓
懷抱著這個夢想的人們，可以有機會美夢成真。

【附註】：[Neovim Language Server Protocol (LSP) 主要功能列表：](https://neovim.io/doc/lsp/)

- Go to definition：定義跳轉
- (auto)completion：自動補全
- Code Actions (automatic formatting, organize imports, ...)：程式碼操作，如：
自動調整排版、組識 import 順序...等
- Show method signatures：顯示用法
- Show/go to references：顯示/跳轉引用處
- snippets：程式碼片段

當 Neovim 0.5 還在 Beta 版，便已開始使用，如今 Neovim 0.6 都已推出了，個人對
Neovim 的掌握度，仍是一知半解。想要擺脫這狀態，所以需要進行深入的研究；對於
研究該如何開展、如何檢驗是否達標，所以需要設定目標。

最後，將個人在 Django Project 應用的需要，彙整成這個研究的「專案需求」如下：

- 程式編碼可透過自動補全，加快輸入及避免打字錯誤
- 程式碼在呼叫某 method/function 時，能「顯示用法」，提示該輸入的引數順序，
    及應使用的資料類型（Data Type）
- 可使用 snippets ，加速編碼工作及避免打字錯誤
- 原先在 VS Code 已建置的 Snippets ，能於 Neovim 環境套用
- 自動檢查程式碼，確保沒有語法的錯誤
- 程式碼已被檢查到的錯誤，可提示：「統計總數」、「標示位置」
- 適用於 Django 開發專案
- 能依據語法標準（如：autopep8），自動調整程式碼的排版格式
- 可編輯及預覽 Markdown 文件，以便可以與 VuePress 整合，作為「技術文件」編輯器
- 可使用如 PlantUML 的工具，以文字描述，繪製 UML 圖形（Diagrams）
- 可以透過 [DAP](https://alpha2phi.medium.com/neovim-dap-enhanced-ebc730ff498b)
    與 Neovim 整合，讓 Neovim 可像 VS Code 一樣，當作除錯（Debug）工具來使用

Neovim 在執行時期，對於設定檔存放目錄及插件存放目錄，有其預設如下：

- 設定（Configuration）存放目錄路徑： `~/.config/nvim/`
- 執行（Runtime）存放目錄路徑： `~/.local/share/nvim/`
- 插件存放目錄路徑： `~/.local/share/nvim/site/pack/packer/start/`

目前網路各大高手及高高手所分享的 Neovim 設定，幾乎都是遵循上述預設而成。可是，
對於我這種入門新手，個人的期望是：「在鑽研 Neovim 的過程中，需要不斷參考，
各個高人們的心得成果，然後自行實作、驗證自己是否理解，最後決定是否要採用
，納入本專案的產出： `my-nvim` 」。所以，我需要兩個相互不影嚮的「工作空間」，
一個為參考用；另一個則為實作用。

基於上述的這個需求，my-nvim 被設計成不會佔用 Neovim 的預設目錄路徑：
`~/.config/nvim` 及 `~/.local/share/nvim` 。這個設計，固然能帶來各自獨立的好處；
但也有副作用的麻煩：您得改變以 nvim 指令啟動 Neovim 的習慣。

## 前置基礎（Prerequisites）

使用 my-nvim 之前，請先完成下列套件、執行環境的安裝及設定。個人慣用的安裝作業
程序，均有標示文件的「連結」網址，提供給有需要的朋友參考。

上述的安裝操作文件，因為原屬個人用的《備忘錄》，所以，其排版格式及遣詞用字，未必
完美；另外，適用的作業系統僅止於：（1）Manjaro (ArchLinux)、(2) Ubuntu 20.04、
(3) macOS 11.6 。

- 完成 [Neovim 0.6] (https://alanjui.github.io/my-dev-env/nvim/#%E5%AE%89%E8%A3%9D%E8%88%87%E6%93%8D%E4%BD%9C) 套件的安裝
- 完成 [Python](https://alanjui.github.io/my-docs/python.html#install-python-tools) 開發環境的安裝
- 完成 [Node.js](https://alanjui.github.io/my-docs/nodejs.html#%E5%AE%89%E8%A3%9D%E8%88%87%E8%A8%AD%E5%AE%9A) 開發環境的安裝（因為諸多的 Langage Server 均是以 Node.js 來運作）
- 完成 [Lua](https://alanjui.github.io/my-docs/lua.html#building-lua) 開發環境及 [Lua Langage Server](https://alanjui.github.io/my-docs/lua.html#install-lua-support-for-vim-neovim) 的安裝

## 安裝與設定作業（Setup process）

### 1. 下載（Download）

```sh
git clone git@github.com:AlanJui/my-nvim.git ~/.config
```

### 2. 安裝插件（Install plugins）

本專案使用 packer.nvim 作為 Neovim 的「插件管理工具」。my-nvim 會在 Neovim
啟動的時候，檢查 packer.nvim 是否已存在；並於必要的時候後，自動執行安裝作業。
另外，my-nvim 使用到的各種插件，也會由 packer.nvim 自動進行安裝。

(1) 安裝執行檔 my-nvim

請依下列指令，完成 my-nvim 這個 Shell Script 執行檔的安裝作業。

```sh
mkdir -p ~/.local/bin
cp ~/.config/my-nvim/tools/my-nvim ~/.local/bin
```

為了讓作業系統能依據 PATH 這個環境變數，搜尋到 my-nvim 這個執行銷，請記得在您使用
的 Bash Shell 或 ZSH Shell 設定檔中，於 PATH 環境變數加入 `~/.local/bin` 搜尋路徑。

```sh
...
export PATH="$HOME/.local/bin:$PATH"
```

重啟 Bash / ZSH Shell，以便新設定的 PATH 環境變數能生效。

```sh
source ~/.bashrc
```

或

```sh
source ~/.zshrc
```

(2) 安裝插件

在終端機輸入下列指令，以便 Neovim 可在不啟動 UI 介面的模式下執行（headless）。
以便 my-nvim 需要用到的各種插件(Plugins)，可以執行安裝作業。

每個插件在完成下載及安裝的工作後，均會顯示結果回報在畫面上，待看到「... has been
installed」的時候，則可按《Ctrl》＋《C》鍵，終結這個安裝指令。

```sh
my-nvim --headless
```

### 3. 操作 Neovim（Start Neovim）

請務必記得，使用 my-nvim 需以如下執行檔啟動，而不要直接執行 nvim 指令：

```sh
my-nvim
```

**【附註】：**

本專案的 Neovim 設定檔存放目錄及插件的存放目錄說明：

- 設定 (Configuration) 存放目錄路徑： `~/.config/my-nvim/`
- 執行時使月檔案及插件存放目錄路徑： `~/.local/share/my-nvim/`

## 後續規劃（Todos）

- 將 DAP 插入納入，以便可以針對 Python 、 JavaScript 及 Lua Script 進行除錯
- 編撰與 my-nvim 相關的《安裝作業》程序文件，如：Python 、NodeJS、Lua
- 製作示範影片，供人快速掌握 my-nvim 的操作應用

**【附註】：**

因個人能力、精力有限，目前預計編撰的《XYZ安裝作業》程序文件，其範圍僅下
述三種，且其優先順序由上而下：

- Manjaro (ArchLinux)
- macOS 11.6.1
- Ubuntu 22.04

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
