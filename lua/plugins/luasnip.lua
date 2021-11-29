-- luasnip.lua
-- Snippets Engine
local luasnip = require('luasnip')

-- some shorthands...
-- local s = luasnip.snippet
-- local sn = luasnip.snippet_node
-- local t = luasnip.text_node
-- local i = luasnip.insert_node
-- local f = luasnip.function_node
-- local c = luasnip.choice_node
-- local d = luasnip.dynamic_node

-- Every unspecified option will be set to the default.
luasnip.config.set_config({
    history = true,
    -- Update more often, :h events for more info.
    updateevents = "TextChanged,TextChangedI",
})

luasnip.snippets = {
    all = {
    },
    html = {
    },
}

-- snippets_path ="~/.config/nvim/my-snippets",
require("luasnip/loaders/from_vscode").load({
    include = {
        "html",
        "htmldjango",
        "python",
        "css",
        "javascript",
        "typescript",
    },
    paths = {
        "~/.config/web-nvim/nvim/my-snippets",
        -- "~/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    }
})

-- enable html snippets in javascript/javascript(REACT)
luasnip.snippets.javascript = luasnip.snippets.html
luasnip.snippets.javascriptreact = luasnip.snippets.html
luasnip.snippets.typescriptreact = luasnip.snippets.html

-- enable  html snippets in htmldjango(Django Template)
-- luasnip.snippets.htmldjango = luasnip.snippets.html

-- You can also use lazy loading so you only get in memory snippets of languages you use
-- require'luasnip/loaders/from_vscode'.lazy_load()

-- Tells LuaSnip that for a buffer with ft=filetype, snippets from
-- extend_filetypes should be searched as well.
-- filetype_extend(filetype, extend_filetypes)
-- Example: luasnip.filetype_extend("lua", {"c", "cpp"})

luasnip.filetype_extend('htmldjango', {'html'})

require("luasnip/loaders/from_vscode").load({
    include = {"python", "html", "htmldjango", "javascript", "typescript", "css"},
    paths = {
        "~/.config/nvim/my-snippets",
        "~/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    }
})
