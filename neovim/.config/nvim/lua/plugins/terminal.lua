return {
    {
        "akinsho/toggleterm.nvim",
        event = "VeryLazy",
        config = function()
            require("toggleterm").setup({
                size = 17,
                open_mapping = { "<LEADER><ESC>", "<LEADER>`" },
            })
        end
    }
}
