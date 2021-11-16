-- bubbles.lua
--
-- Lualine has sections as shown below.
-- +-------------------------------------------------+
-- | A | B | C                             X | Y | Z |
-- +-------------------------------------------------+

local lsp_provider = require('utils.lsp').lsp_provider

--------------------------------------------------------
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

-- stylua: ignore
local colors = {
    blue   = '#80a0ff',
    cyan   = '#79dac8',
    black  = '#080808',
    white  = '#c6c6c6',
    red    = '#ff5189',
    violet = '#d183e8',
    grey   = '#303030',
}
-- local colors = {
--     yellow = '#ECBE7B',
--     cyan = '#008080',
--     darkblue = '#081633',
--     green = '#98be65',
--     orange = '#FF8800',
--     violet = '#a9a1e1',
--     magenta = '#c678dd',
--     blue = '#51afef',
--     red = '#ec5f67'
-- }


local bubbles_theme = {
    normal = {
        a = { fg = colors.black, bg = colors.violet },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.black, bg = colors.black },
    },

    insert = { a = { fg = colors.black, bg = colors.blue } },
    visual = { a = { fg = colors.black, bg = colors.cyan } },
    replace = { a = { fg = colors.black, bg = colors.red } },

    inactive = {
        a = { fg = colors.white, bg = colors.black },
        b = { fg = colors.white, bg = colors.black },
        c = { fg = colors.black, bg = colors.black },
    },
}

local config = {
    options = {
        theme = bubbles_theme,
        component_separators = '|',
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = {
            { 'mode', separator = { left = '' }, right_padding = 2 },
        },
        lualine_b = {
            'filename',
            'branch'
        },
        lualine_c = {
            'fileformat',
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
        },
        lualine_y = {
            'encoding',
            'filetype',
            lsp_provider,
            'progress'
        },
        lualine_z = {
            { 'location', separator = { right = '' }, left_padding = 2 },
        },
    },
    inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
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
}

--------------------------------------------------------
-- Inserts a component in lualine_c at left section
local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
end

ins_left({
    'lsp_progress',
    display_components = {
        'lsp_client_name',
        'spinner',
        { 'title', 'percentage', 'message' }
    },
    -- With spinner
    -- display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' }},
    colors = {
        percentage  = colors.cyan,
        title  = colors.cyan,
        message  = colors.cyan,
        spinner = colors.cyan,
        lsp_client_name = colors.magenta,
        use = true,
    },
    separators = {
        component = ' ',
        progress = ' | ',
        message = { pre = '(', post = ')'},
        -- message = { commenced = 'In Progress', completed = 'Completed' },
        percentage = { pre = '', post = '%% ' },
        title = { pre = '', post = ': ' },
        lsp_client_name = { pre = '[', post = ']' },
        spinner = { pre = '', post = '' },
    },
    timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
    spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
})

require('lualine').setup({
    options = config.options,
    sections = config.sections,
    inactive_sections = config.inactive_sections,
    tabline = config.tabline,
    extensions = config.extensions,
})
