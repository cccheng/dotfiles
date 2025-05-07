return {
    {
        -- "cocopon/iceberg.vim",
        "oahlen/iceberg.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            if vim.env.NVIM_COLORSCHEME == nil or
               vim.env.NVIM_COLORSCHEME == "iceberg" then
                vim.cmd.colorscheme("iceberg")
            end

            vim.api.nvim_set_hl(0, "TabLine", { fg = "#9a9ca5", bg = "#1f2233", bold = false })
            vim.api.nvim_set_hl(0, "TabLineFill", { fg = "#101218", bg = "#1f2233", bold = false })
            vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#9a9ca5", bg = "#2b335a", bold = true })
        end
    },
    {
        "sam4llis/nvim-tundra",
        lazy = false,
        priority = 1000,
        config = function()
            require("nvim-tundra").setup({
                -- transparent_background = true,
            })

            if vim.env.NVIM_COLORSCHEME == "tundra" then
                vim.cmd.colorscheme("tundra")
            end
        end
    },
    {
        "sho-87/kanagawa-paper.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("kanagawa-paper").setup({
                dimInactive = false,
                -- transparent = true,
            })

            if vim.env.NVIM_COLORSCHEME == "kanagawa" then
                vim.cmd.colorscheme("kanagawa-paper")
            end

            vim.api.nvim_set_hl(0, "TabLine", { fg = "#9a9ca5", bg = "#1f2233", bold = false })
            vim.api.nvim_set_hl(0, "TabLineFill", { fg = "#101218", bg = "#1f2233", bold = false })
            vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#9a9ca5", bg = "#2b335a", bold = true })
        end
    },
    {
        "webhooked/kanso.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("kanso").setup({
                -- compile = true,
                keywordStyle = { italic = false },
            })

            if vim.env.NVIM_COLORSCHEME == "kanso" then
                vim.cmd.colorscheme("kanso-ink")
                -- vim.cmd.colorscheme("kanso")
            end
        end
    },
}
