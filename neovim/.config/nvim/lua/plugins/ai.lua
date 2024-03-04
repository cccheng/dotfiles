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
            },
            {
                "<leader>gg", "<cmd>OGPTRun grammar_correction<cr>", desc = "GPT Grammar Correction", mode = { "v" },
            },
            {
                "<leader>gt", "<cmd>OGPTRun translate<cr>", desc = "GPT Translate", mode = { "v" },
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
            output_window = {
                border = {
                    text = {
                        top = "",
                    },
                },
            },
            actions = {
                grammar_correction = {
                    type = "popup",
                    template = "Correct the given text to standard English:\n\n```{{{input}}}```",
                    system = "You are a helpful note writing assistant, given a text input, correct the text only for grammar and spelling error. You are to keep all formatting the same, e.g. markdown bullets, should stay as a markdown bullet in the result, and indents should stay the same. Return ONLY the corrected text.",
                    strategy = "display", -- replace
                    params = {
                        temperature = 0.3,
                    },
                    args = {
                        lang = {
                            type = "string",
                            optional = "true",
                            default = "english",
                        },
                    },
                },
                translate = {
                    type = "popup",
                    template = "Translate this into Traditional Chinese:\n\n{{{input}}}",
                    strategy = "display",
                    params = {
                        temperature = 0.3,
                    },
                    args = {
                        lang = {
                            type = "string",
                            optional = "true",
                            default = "chinese",
                        },
                    },
                },
            },
        },
    },
}
