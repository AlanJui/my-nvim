return {
    -----------------------------------------------------------
    -- LaTeX
    -----------------------------------------------------------
    -- Vimtex
    "lervag/vimtex",
    -- Texlab configuration
    {
        "f3fora/nvim-texlabconfig",
        config = function()
            require("texlabconfig").setup({
                cache_active = true,
                cache_filetypes = { "tex", "bib" },
                cache_root = vim.fn.stdpath("cache"),
                reverse_search_edit_cmd = "edit",
                file_permission_mode = 438,
            })
        end,
        ft = { "tex", "bib" },
        cmd = { "TexlabInverseSearch" },
    },
}
