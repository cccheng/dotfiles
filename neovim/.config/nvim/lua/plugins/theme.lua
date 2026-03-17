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

            vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { fg = "#84a0c6", bg = "#2c3157", bold = true })
            vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { fg = "#a093c7", bg = "#293052", bold = true })
            vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { fg = "#89b8c2", bg = "#25304a", bold = true })
            vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { fg = "#b4be82", bg = "#252940", bold = true, italic = true })
            vim.api.nvim_set_hl(0, "RenderMarkdownH5Bg", { fg = "#e2d478", bg = "#222540", bold = true, italic = true })
            vim.api.nvim_set_hl(0, "RenderMarkdownH6Bg", { fg = "#e2a478", bg = "#20233c", bold = true, italic = true })
            vim.api.nvim_set_hl(0, "RenderMarkdownH1", { fg = "#84a0c6", bold = true })
            vim.api.nvim_set_hl(0, "RenderMarkdownH2", { fg = "#a093c7", bold = true })
            vim.api.nvim_set_hl(0, "RenderMarkdownH3", { fg = "#89b8c2", bold = true })
            vim.api.nvim_set_hl(0, "RenderMarkdownH4", { fg = "#b4be82", bold = true, italic = true })
            vim.api.nvim_set_hl(0, "RenderMarkdownH5", { fg = "#e2d478", bold = true, italic = true })
            vim.api.nvim_set_hl(0, "RenderMarkdownH6", { fg = "#e2a478", bold = true, italic = true })
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
