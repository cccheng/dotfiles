return {
    {
        "m4xshen/hardtime.nvim",
        lazy = false,
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
