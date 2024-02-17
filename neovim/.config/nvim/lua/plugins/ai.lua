return {
    {
        "huynle/ogpt.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        },
        keys = {
            {
                "<leader>g", "<cmd>OGPT<cr>", desc = "GPT",
            },
        },
        opts = {
            default_provider = "gemini",
            input_window = {
                border = {
                    text = {
                        top = "",
                    },
                },
            },
        },
    },
}
