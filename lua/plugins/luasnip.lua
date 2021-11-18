-- luasnip.lua
-- Snippets Engine
local ls = require('luasnip')

-- some shorthands...
-- local s = ls.snippet
-- local sn = ls.snippet_node
-- local t = ls.text_node
-- local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node

-- Every unspecified option will be set to the default.
ls.config.set_config({
    history = true,
    -- Update more often, :h events for more info.
    updateevents = "TextChanged,TextChangedI",
})

ls.snippets = {
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
        "~/.config/nvim/my-snippets",
        -- "~/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    }
})

-- enable  html snippets in htmldjango(Django Template)
ls.snippets.htmldjango = ls.snippets.html

-- enable html snippets in javascript/javascript(REACT)
ls.snippets.javascript = ls.snippets.html
ls.snippets.javascriptreact = ls.snippets.html
ls.snippets.typescriptreact = ls.snippets.html

-- You can also use lazy loading so you only get in memory snippets of languages you use
require'luasnip/loaders/from_vscode'.lazy_load()

-- Tells LuaSnip that for a buffer with ft=filetype, snippets from extend_filetypes should be searched as well.
-- filetype_extend(filetype, extend_filetypes)
-- Example: luasnip.filetype_extend("lua", {"c", "cpp"})
-- ls.filetype_extend('htmldjango', {'html', 'htmldjango'})

