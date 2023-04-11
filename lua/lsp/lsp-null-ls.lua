local mason = _G.safe_require("mason")
local null_ls = _G.safe_require("null-ls")
local mason_null_ls = _G.safe_require("mason-null-ls")
if not mason or not null_ls or not mason_null_ls then
    return
end

local M = {}

local lsp_format_augroup = _G.LspFormattingAugroup

local null_ls_on_attach = function(current_client, bufnr)
    -- to setup format on save
    if current_client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = lsp_format_augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = lsp_format_augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({
                    bufnr = bufnr,
                    filter = function(client) -- luacheck: ignore
                        --  only use null-ls for formatting instead of lsp server
                        return client.name == "null-ls"
                    end,
                })
            end,
        })
    end
end

--------------------------------------------------------------
-- Install Null-LS automatically
--------------------------------------------------------------
local ensure_installed_list = {
    -- Lua
    -- "luacheck",
    "stylua",
    -- Web
    "prettier",
    -- Python/Django
    "pylint",
    -- "mypy",
    "pydocstyle",
    -- "flake8",
    "isort",
    "djhtml",
    "djlint",
    -- "autopep8",
    -- Markdown
    "markdownlint",
    -- Shell
    "zsh",
    "shellcheck",
    -- Misc.
    "jq",
}

-- register any number of sources simultaneously
-- local formatting = null_ls.builtins.formatting -- to setup formatters
-- local diagnostics = null_ls.builtins.diagnostics -- to setup linters
-- local completion = null_ls.builtins.completion
-- local code_actions = null_ls.builtins.code_actions
-- local utils = require("null-ls.utils")

local setup_handlers = {
    function(source_name, methods)
        -- all sources with no handler get passed here

        -- To keep the original functionality of `automatic_setup = true`,
        -- please add the below.
        require("mason-null-ls.automatic_setup")(source_name, methods)
    end,
    ---@diagnostic disable-next-line: unused-local
    stylua = function(source_name, methods) -- luacheck: ignore
        null_ls.register(null_ls.builtins.formatting.stylua)
    end,
    ---@diagnostic disable-next-line: unused-local
    pylint = function(source_name, methods) -- luacheck: ignore
        null_ls.register(null_ls.builtins.diagnostics.pylint.with({
            command = "pylint",
            -- extra_args = { "--load-plugins", "pylint_django" },
            -- init_options = {
            --     "init-hook='import sys; import os; from pylint.config import find_pylintrc; sys.path.append(os.path.dirname(find_pylintrc()))'",
            -- },
        }))
    end,
    ---@diagnostic disable-next-line: unused-local
    pydocstyle = function(source_name, methods) -- luacheck: ignore
        null_ls.register(null_ls.builtins.diagnostics.pydocstyle.with({
            extra_args = { "--config=$ROOT/setup.cfg" },
        }))
    end,
    ---@diagnostic disable-next-line: unused-local
    mypy = function(source_name, methods)
        null_ls.register(null_ls.builtins.diagnostics.mypy.with({
            extra_args = { "--config-file", "pyproject.toml" },
            -- extra_args = { "--config-file", "mypy.ini" },
            -- extra_args = { "--config-file", "setup.cfg" },
            -- cwd = function(_) return vim.fn.getcwd() end,
            -- runtime_condition = function(params) return utils.path.exists(params.bufname) end,
        }))
    end,
    ---@diagnostic disable-next-line: unused-local
    prettier = function(source_name, methods)
        null_ls.register(null_ls.builtins.formatting.prettier.with({
            filetypes = {
                "html",
                "css",
                "scss",
                "less",
                "javascript",
                "typescript",
                "vue",
                "json",
                "jsonc",
                "yaml",
                "markdown",
                "handlebars",
            },
            extra_filetypes = {},
        }))
    end,
}
--------------------------------------------------------------------
-- null-ls sources
--------------------------------------------------------------------
-- register any number of sources simultaneously
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters
local completion = null_ls.builtins.completion
local code_actions = null_ls.builtins.code_actions

local sources = {
    -- Built-in sources have access to a special method, with(),
    -- which modifies a subset of the source's default options.
    code_actions.gitsigns,
    ---------------------------------------------------------------
    -- Lua
    ---------------------------------------------------------------
    -- Snippet engine for Neovim, written in Lua.
    completion.luasnip, -- for linting and static analysis of Lua code
    diagnostics.luacheck, -- Reformats your Lua source code.
    -- formatting.lua_format.with({
    --     extra_args = {
    --         '--no-keep-simple-function-one-line', '--no-break-after-operator',
    --         '--column-limit=100', '--break-after-table-lb', "--indent-width=4"
    --     }
    -- }),
    formatting.stylua,
    ---------------------------------------------------------------
    -- Web
    ---------------------------------------------------------------
    -- Tags completion source.
    diagnostics.eslint, -- null_ls.builtins.completion.tags,
    -- null_ls.builtins.completion.spell,
    -- Find and fix problems in your JavaScript code.
    -- formatting.eslint,
    formatting.prettier.with({
        filetypes = {
            "html",
            "css",
            "scss",
            "less",
            "javascript",
            "typescript",
            "vue",
            "json",
            "jsonc",
            "yaml",
            "markdown",
            "handlebars",
        },
        extra_filetypes = {},
    }),
    ---------------------------------------------------------------
    -- Python/Django
    ---------------------------------------------------------------
    -- Pylint is a Python static code analysis tool which looks for
    -- programming errors, helps enforcing a coding standard, sniffs
    -- for code smells and offers simple refactoring suggestions.
    -- diagnostics.pylint.with({
    -- 	diagnostics_postprocess = function(diagnostic)
    -- 		diagnostic.code = diagnostic.message_id
    -- 	end,
    -- }),
    formatting.isort,
    formatting.autopep8, -- formatting.black,
    -- A pure-Python Django/Jinja template indenter without dependencies.
    formatting.djhtml,
    formatting.djlint,

    -- mypy is an optional static type checker for Python that aims to
    -- combine the benefits fo dynamic (or "dock") typing and static typings.
    -- diagnostics.mypy,

    -- pydocstyle is a static analysis tool for checking compliance
    -- with Python docstring conventions.
    -- diagnostics.pydocstyle,

    -- flake8 is a python tool that glues together pycodestyle,
    -- pyflakes, mccabe, and third-party plugins to check the style
    -- and quality of Python code.
    diagnostics.flake8,

    -- A tool that automatically formats Python code to conform to
    -- the PEP 8 style guide.
    -- Django HTML Template Linter and Formatter.
    diagnostics.djlint,
    ---------------------------------------------------------------
    -- Markdown style and syntax checker
    diagnostics.markdownlint,
    -- A Node.js style checker and lint tool for Markdown/CommonMark
    -- files.
    formatting.markdownlint, -- A linter for YAML files
    diagnostics.zsh,
}

--------------------------------------------------------------------
-- Functions for Module
--------------------------------------------------------------------
function M.setup()
    mason_null_ls.setup({
        ensure_installed = ensure_installed_list,
        automatic_installation = false,
        handlers = setup_handlers,
    })

    -- to setup format on save
    null_ls.setup({
        sources = sources,
        on_attach = null_ls_on_attach,
    })
end

return M
