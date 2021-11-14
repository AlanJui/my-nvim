-- material.lua
-- Lualine has sections as shown below.
-- +-------------------------------------------------+
-- | A | B | C                             X | Y | Z |
-- +-------------------------------------------------+

local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added    = gitsigns.added,
            modified = gitsigns.changed,
            removed  = gitsigns.removed
        }
    end
end

require('lualine').setup({
    -- options = { theme = 'jellybeans' }
    options = {
        icons_enabled = true,
        theme = 'material',
        -- section_separators = {'', ''},
        -- component_separators = {'', ''},
        -- fmt = string.lower,
        disabled_filetypes = { },
    },
    sections = {
        lualine_a = {
            'mode',
            -- fmt = function (str)
            -- 	return str:sub(1,1)
            -- end
        },
        lualine_b = {
            'branch',
        },
        lualine_c = {
            'filename',
            {
                'diff',
                source = diff_source
            },
            'lsp_progress',
        },
        lualine_x = {
            {
                'diagnostics',
                -- table of diagnostic sources, available sources:
                -- 'nvim_lsp', 'nvim', 'coc', 'ale', 'vim_lsp'
                -- Or a function that returns a table like:
                -- {error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt}
                sources = {'nvim_lsp', 'coc'},
                -- displays diagnostics from defined severity
                sections = {'error', 'warn', 'info', 'hint'},
                -- all colors are in format #rrggbb
                diagnostic_color = {
                    error = nil,
                    warn  = nil,
                    info  = nil,
                    hint  = nil,
                },
                symbols = {
                    error = ' ',
                    warn  = ' ',
                    info  = ' ',
                    hint  = ' ',
                },
                -- Update diagnostics in insert mode
                update_in_insert = false,
                -- Show diagnostics even if count is 0
                alwayw_visible = false,
            },
            'encoding',
            'filetype'
        },
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { require('tabline').tabline_buffers },
        lualine_x = { require('tabline').tabline_tabs },
        lualine_y = {},
        lualine_z = {},
    },
    extensions = {'fugitive'}
})
