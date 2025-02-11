return {
    {
        -- "cocopon/iceberg.vim",
        "oahlen/iceberg.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("iceberg")

            vim.api.nvim_set_hl(0, "TabLine", { fg = "#9a9ca5", bg = "#1f2233", bold = false })
            vim.api.nvim_set_hl(0, "TabLineFill", { fg = "#101218", bg = "#1f2233", bold = false })
            vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#9a9ca5", bg = "#2b335a", bold = true })
        end
    },
    {
        "sam4llis/nvim-tundra",
        lazy = true,
        priority = 1000,
        config = function()
            require("nvim-tundra").setup({
                -- transparent_background = true,
            })
            vim.cmd.colorscheme("tundra")
        end
    },
    {
        "sho-87/kanagawa-paper.nvim",
        lazy = true,
        priority = 1000,
        config = function()
            require("kanagawa-paper").setup({
                dimInactive = false,
                -- transparent = true,
            })
            vim.cmd.colorscheme("kanagawa-paper")
        end
    },
}
