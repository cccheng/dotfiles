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
                "<leader>gc", "<cmd>OGPT<cr>", desc = "GPT chat",
            },
            {
                "<leader>ga", "<cmd>OGPTActAs<cr>", desc = "GPT act as",
            }
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
            popup = {
                border = {
                    style = "none",
                },
            },
            popup_layout = {
                default = "right",
                right = {
                    width = "45%",
                    width_parameters_open = "45%",
                },
            },
            output_window = {
                border = {
                    text = {
                        top = "",
                    },
                },
            },
        },
    },
}
