return {
    {
        "akinsho/toggleterm.nvim",
        event = "VeryLazy",
        config = function()
            require("toggleterm").setup({
                -- direction = 'vertical' | 'horizontal' | 'tab' | 'float',
                size = 24,
                open_mapping = { "<LEADER>`" },
                autochdir = true,
            })
        end
    }
}
