local lsp_installer = require("nvim-lsp-installer")

-- Provide settings first!
lsp_installer.settings({
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗",
        },
    },

    -- Limit for the maximum amount of servers to be installed at the same time. Once this limit is reached, any further
    -- servers that are requested to be installed will be put in a queue.
    max_concurrent_installers = 4,
})


---------------------------------------------------
local system_name

if vim.fn.has("mac") == 1 then
	system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
	system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
	system_name = "Windows"
else
	print("Unsupported system for sumneko")
end

local function make_server_ready(on_attach)
	lsp_installer.on_server_ready(function(server)
 		-- -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
 		-- local opts = {}
 		-- opts.on_attach = attach
 		-- server:setup(opts)
 		-- vim.cmd [[ do User LspAttachBuffers ]]
		----------------------------------------------------------------------------------------------------------

		-- Specify the default options which we'll use for all LSP servers
		local default_opts = {
			on_attach = on_attach,
			-- capabilities = capabilities,
		}

		local server_opts = {
			['sumneko_lua'] = function()
				local lua_root_path = vim.fn.stdpath('data') .. '/lsp_servers/sumneko_lua/extension/server/bin/' .. system_name
				local lua_binary = lua_root_path .. '/lua-language-server'
				local runtime_path = vim.split(package.path, ';')
				table.insert(runtime_path, 'lua/?.lua')
				table.insert(runtime_path, 'lua/?/init.lua')

				default_opts.cmd = {
					lua_binary,
					'-E',
					lua_root_path .. '/main.lua',
				}

				default_opts.settings = {
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
						-- Do not send telemetry data containing a randomized but unique identifier
						telemetry = {
						  enable = false,
						},
					},
				}

				default_opts.on_attach = on_attach
				-- default_opts.capabilities = capabilities
				return default_opts
			end,
		}

		-- We check to see if any custom server_opts exist for the LSP server, if so, load them,
		-- if not, use our default_opts
		server:setup(server_opts[server.name] and server_opts[server.name]() or default_opts)
		vim.cmd [[ do User LspAttachBuffers ]]
	end)
end

---------------------------------------------------
local function install_server(server)
	local lsp_installer_servers = require'nvim-lsp-installer.servers'
	local ok, server_analyzer = lsp_installer_servers.get_server(server)
	if ok then
		if not server_analyzer:is_installed() then
			server_analyzer:install(server)
		end
	end
end

---------------------------------------------------
local servers = {
    "sumneko_lua",
    "pyright",
    "tsserver",           -- for javascript
    "jsonls",             -- for json
}


-- setup the LS
require "plugins.lspconfig"
make_server_ready(On_attach)    -- LSP mappings

-- install the LS
for _, server in ipairs(servers) do
	install_server(server)
end
