---------------------------------------------------------------------------
-- Treesitter
-- Can be used for things like highlighting, indentation, folding.
---------------------------------------------------------------------------
local treesitter = safe_require('nvim-treesitter')
if not treesitter then
    return
end

require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = {
        "lua",
        "vim",
        "comment",
        "python",
        "yaml",
        "dockerfile",
        "latex",
        "javascript",
        "typescript",
        "vue",
        "json",
        "jsonc",
        "go",
        "html",
        "toml",
        "css",
        "scss",
        "bash",
        "c",
        "cmake",
        "rust",
        "make",
        "markdown",
    },
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- List of parsers to ignore installing (for "all")
    -- ignore_install = { "javascript" },
    autopairs = {
        enable = true,
    },
    highlight = {
        -- `false` will disable the whole extension
        enable = true,
        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        disable = { "c", "rust" },
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
        disable = { 'yaml' },
    },
    autotag = {
        enable = true,
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
        config = {
            -- css = '/* %s */',
            -- javascript = {
            --     __default = '// %s',
            --     jsx_element = '{/* %s */}',
            --     jsx_fragment = '{/* %s */}',
            --     jsx_attribute = '// %s',
            --     comment = '// %s'
            -- },
            -- typescript = { __default = '// %s', __multiline = '/* %s */' },
        },
    },
}
