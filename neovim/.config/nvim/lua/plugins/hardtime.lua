return {
    {
        "m4xshen/hardtime.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        opts = {
        },
        config = function()
            require("hardtime").setup({
                restricted_keys = {
                    ["h"] = {},
                    ["j"] = {},
                    ["k"] = {},
                    ["l"] = {},
                }
            })
        end
    },
}
