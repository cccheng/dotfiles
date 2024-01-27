return {
    {
        "folke/tokyonight.nvim",
        event = "VeryLazy",
    }, {
        "cocopon/iceberg.vim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "iceberg"
        end
    }
}
