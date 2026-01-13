-- Get the selected theme from environment variable (default to iceberg)
local selected_theme = vim.env.NVIM_COLORSCHEME or "iceberg"

return {
    {
        -- "cocopon/iceberg.vim",
        "oahlen/iceberg.nvim",
        lazy = selected_theme ~= "iceberg",
        priority = 1002,
        config = function()
            vim.cmd.colorscheme("iceberg")
            vim.api.nvim_set_hl(0, "TabLine", { fg = "#9a9ca5", bg = "#1f2233", bold = false })
            vim.api.nvim_set_hl(0, "TabLineFill", { fg = "#101218", bg = "#1f2233", bold = false })
            vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#9a9ca5", bg = "#2b335a", bold = true })
        end
    },
    {
        "sho-87/kanagawa-paper.nvim",
        lazy = selected_theme ~= "kanagawa",
        priority = 1000,
        config = function()
            require("kanagawa-paper").setup({
                dimInactive = false,
                -- transparent = true,
            })
            vim.cmd.colorscheme("kanagawa-paper")
            vim.api.nvim_set_hl(0, "TabLine", { fg = "#9a9ca5", bg = "#1f2233", bold = false })
            vim.api.nvim_set_hl(0, "TabLineFill", { fg = "#101218", bg = "#1f2233", bold = false })
            vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#9a9ca5", bg = "#2b335a", bold = true })
        end
    },
}
