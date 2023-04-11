return {
  "nvim-tree/nvim-tree.lua",
  module = true,
  cmd = {
    "NvimTreeOpen",
    "NvimTreeToggle",
    "NvimTreeFocus",
    "NvimTreeFindFile",
    "NvimTreeFindFileToggle",
  },
  dependencies = {
    {
      "nvim-tree/nvim-web-devicons",
      config = function()
        local icons = require "nvim-web-devicons"

        icons.set_icon {
          deb = { icon = "", name = "Deb", color = "#A1B7EE" },
          lock = { icon = "", name = "Lock", color = "#C4C720" },
          mp3 = { icon = "", name = "Mp3", color = "#D39EDE" },
          mp4 = { icon = "", name = "Mp4", color = "#9EA3DE" },
          out = { icon = "", name = "Out", color = "#ABB2BF" },
          ["robots.txt"] = { icon = "ﮧ", name = "Robots", "#ABB2BF" },
          [""] = { icon = "", name = "default", "#ABB2Bf" },
          ttf = { icon = "", name = "TrueTypeFont", "#ABB2Bf" },
          rpm = { icon = "", name = "Rpm", "#FCA2Aa" },
          woff = { icon = "", name = "WebOpenFontFormat", color = "#ABB2Bf" },
          woff2 = { icon = "", name = "WebOpenFontFormat2", color = "#ABB2Bf" },
          xz = { icon = "", name = "Xz", color = "#519ABa" },
          zip = { icon = "", name = "Zip", color = "#F9D71c" },
          snippets = { icon = "", name = "Snippets", color = "#51AFEf" },
          ahk = { icon = "", name = "AutoHotkey", color = "#51AFEf" },
        }
      end,
    },
  },
  config = function()
    local nvim_tree = require "nvim-tree"
    local nvim_tree_config = require "nvim-tree.config"
    local tree_cb = nvim_tree_config.nvim_tree_callback
    nvim_tree.setup {
      auto_reload_on_write = true,
      -- disables netrw completely
      disable_netrw = true,
      -- hijack netrw window on startup
      hijack_netrw = true,
      -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
      open_on_tab = false,
      -- hijack the cursor in the tree to put it at the start of the filename
      hijack_cursor = false,
      -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
      update_cwd = false,
      -- show lsp diagnostics in the signcolumn
      diagnostics = {
        enable = false,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      -- update the focused file on `BufEnter`, un-collapses the folders recursively
      -- until it finds the file
      update_focused_file = {
        -- enables the feature
        enable = false,
        -- update the root directory of the tree to the one of the folder containing
        -- the file if the file is not under the current root directory only relevant
        -- when `update_focused_file.enable` is true
        update_cwd = false,
        -- list of buffer names / filetypes that will not update the cwd if the file
        -- isn't found under the current root directory only relevant when
        -- `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
        ignore_list = {},
      },
      -- configuration options for the system open command (`s` in the tree by default)
      system_open = {
        -- the command to run this, leaving nil should work in most cases
        cmd = nil,
        -- the command arguments as a list
        args = {},
      },
      view = {
        -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
        width = 30,
        -- height of the window, can be either a number (columns) or a string in `%`, for top or bottom side placement
        -- height = 30,
        -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
        side = "left",
        -- if true the tree will resize itself after opening a file
        -- 2022-06-30: unknown option
        -- auto_resize = false,
        mappings = {
          -- custom only false will merge the list with the default mappings
          -- if true, it will only use your list to set the mappings
          custom_only = false,
          -- list of mappings to set on the tree manually
          list = {},
        },
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
      },
    }
  end,
}
