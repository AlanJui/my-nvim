-- cmp.lua
local cmp = safe_require 'cmp'
local luasnip = safe_require 'luasnip'
local lspkind = safe_require 'lspkind'
if (not cmp) or (not luasnip) or (not lspkind) then
    return
end

-- Require function for tab to work with LUA-SNIP
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local kind_icons = {
    Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

-- Set completeopt to have a better completion experience
-- vim.o.completeopt = 'menuone,noselect'

cmp.setup({
    cmpletion = {
        completeopt = 'menu, menuone, noinsert',
    },

    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },

    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<F2>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },

        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }
        ),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }
        ),
    },

    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            -- fancy icons and a name of kind
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            -- vim_item.kind = require('lspkind').presets.default[vim_item.kind]
            -- vim_item.kind = string.format(
            --     '%s %s',
            --     lspkind.presets.default[vim_item.kind],
            --     vim_item.kind
            -- )
            -- set a name for each source
            vim_item.menu = ({
                buffer = "[Buff]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[Lua]",
                luasnip = "[LuaSnip]",
                latex_symbols = "[Latex]",
                spell = "[Spell]",
                treesitter = "[TreeSitter]",
                vsnip = "[VsSnip]",
                zsh = "[Zsh]",
                path = "[Path]",
            })[entry.source.name]

            return vim_item
        end
    },

    sources = {
        { name = 'luasnip' },
        { name = 'vsnip' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'path' },
        { name = 'emoji' },
        { name = 'spell' },
        -- { name = 'buffer', keyword_length = 1 },
        {
            name = 'buffer',
            options = {
                get_bufnrs = function ()
                    return vim.api.nvim_list_bufs()
                end,
            }
        },
        { name = 'calc' },
    },

    documentation = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },

    experimental = {
        ghost_text = false,
    }
})
