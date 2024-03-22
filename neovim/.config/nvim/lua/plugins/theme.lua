return {
    {
        -- "cocopon/iceberg.vim",
        "oahlen/iceberg.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            -- vim.cmd.colorscheme("iceberg")
        end
    },
    {
        "sam4llis/nvim-tundra",
        lazy = false,
        priority = 1000,
        config = function()
            require("nvim-tundra").setup({
                transparent_background = true,
            })
            vim.cmd.colorscheme("tundra")
        end
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("kanagawa").setup({
                theme = "wave",
                background = {
                    dark = "wave",
                    light = "lotus",
                },
                transparent = false,         -- do not set background color
                dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
            })
            -- vim.cmd.colorscheme("kanagawa")
        end
    },
}
