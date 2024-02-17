return {
    {
        "echasnovski/mini.nvim",
        event = "VeryLazy",
        config = function()
            require("mini.align").setup({
            })

            require("mini.notify").setup({
            })

            require("mini.comment").setup({
            })

            require("mini.cursorword").setup({
            })
        end
    },
    {
        "jinh0/eyeliner.nvim",
        event = "VeryLazy",
        config = function()
            require("eyeliner").setup({
                highlight_on_key = true, -- show highlights only after keypress
                dim = false, -- dim all other characters if set to true (recommended!)
            })
        end
    },
    {
        "ggandor/leap.nvim",
        event = "VeryLazy",
        config = function()
            require("leap").create_default_mappings()
        end
    },
}
