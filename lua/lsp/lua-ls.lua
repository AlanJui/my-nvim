local custom_lsp_attach = function(client)
    -- See `:help nvim_buf_set_keymap()` for more information
    vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})
    vim.api.nvim_buf_set_keymap(0, 'n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true})
    -- ... and other keymappings for LSP

    -- Use LSP as the handler for omnifunc.
    --    See `:help omnifunc` and `:help ins-completion` for more information.
    vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Use LSP as the handler for formatexpr.
    --    See `:help formatexpr` for more information.
    vim.api.nvim_buf_set_option(0, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')

    -- For plugins with an `on_attach` callback, call them here. For example:
    -- require('completion').on_attach()
end

-- An example of configuring for `sumneko_lua`,
--  a language server for Lua.

-- set the path to the sumneko installation
-- local system_name = "Linux" -- (Linux, macOS, or Windows)
local system_name = OS_SYS

-- coc-sumneko-lua
-- local sumneko_root_path = HOME .. '/.config/coc/extensions/coc-sumneko-lua-data/sumneko-lua-ls/extension/server/bin/' .. OS_SYS
-- local sumneko_binary = sumneko_root_path .. '/lua-language-server'

-- Manually install
local sumneko_root_path = HOME .. '/.local/share/lua-language-server'
local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"

local runtime_path = vim.split(package.path, ';')
if DEBUG then
    print('<< Begin of setup Lua Server >>')
    -- print(string.format('package.path=%s', package.path))
    print('runtime_path=')
    Print_table(runtime_path)
end
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

if DEBUG then
    print('after table.insert: runtime_path=')
    Print_table(runtime_path)
    Print_rtp()
end

require('lspconfig').sumneko_lua.setup({
    -- cmd = { "lua-language-server" };
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    -- An example of settings for an LSP server.
    --    For more options, see nvim-lspconfig
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
        }
    },

    on_attach = custom_lsp_attach
})


if DEBUG then
    print('<< End of setup Lua Server >>')
    Print_rtp()
end
