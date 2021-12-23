-----------------------------------------------------------
-- Color Themes
-----------------------------------------------------------
if not INSTALLED then
    if DEBUG then print('<< Load default colorscheme >>') end
    -- Use solarized8_flat color scheme when first time start my-nvim
    vim.cmd([[ colorscheme solarized8_flat ]])
    -- vim.cmd([[ colorscheme solarized8_flat ]])
    -- vim.cmd([[ colorscheme solarized8 ]])
    -- vim.cmd([[ colorscheme OceanicNext ]])
    -- vim.cmd([[ colorscheme rvcs ]])
    -- vim.cmd([[ colorscheme nightfly ]])
    -- vim.cmd([[ colorscheme moonfly ]])
else
    if DEBUG then print('<< Load Tokyo Night colorscheme >>') end
    -- Tokyo Night Color Scheme Configuration
    -- vim.g.tokyonight_style = 'day'
    -- vim.g.tokyonight_style = 'night'
    vim.cmd([[ colorscheme tokyonight ]])
    vim.g.tokyonight_style = 'storm'
    vim.g.tokyonight_italic_functions = true
    vim.g.tokyonight_dark_float = true
    vim.g.tokyonight_transparent = true
    vim.g.tokyonight_sidebars = {
        'qf',
        'vista_kind',
        'terminal',
        'packer',
    }
    -- Change the "hint" color to the "orange" color,
    -- and make the "error" color bright red
    vim.g.tokyonight_colors = {
        hint = 'orange',
        error = '#ff0000'
    }
end
