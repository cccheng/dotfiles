return {
    {
        "akinsho/toggleterm.nvim",
        lazy = true,
        keys = {
            { "<LEADER>`", desc = "Terminal" },
        },
        config = function()
            require("toggleterm").setup({
                direction = "vertical", -- 'vertical' | 'horizontal' | 'tab' | 'float',
                size = 120,
                open_mapping = { "<LEADER>`" },
                autochdir = true,
            })
        end
    }
}
