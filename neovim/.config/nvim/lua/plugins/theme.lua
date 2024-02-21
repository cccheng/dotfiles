return {
    {
        -- "cocopon/iceberg.vim",
        "oahlen/iceberg.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("iceberg")
        end
    },
    {
        "sam4llis/nvim-tundra",
        event = "VeryLazy",
        config = function()
            require("nvim-tundra").setup({
                transparent_background = true,
            })
        end
    },
}
