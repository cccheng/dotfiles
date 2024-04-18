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
            { "<LEADER>gc", "<CMD>OGPT<CR>", desc = "GPT chat" },
            { "<LEADER>ga", "<CMD>OGPTActAs<CR>", desc = "GPT act as" },
            { "<LEADER>gg", "<CMD>OGPTRun grammar_correction<CR>", desc = "GPT Grammar Correction", mode = { "v" } },
            { "<LEADER>gt", "<CMD>OGPTRun translate<CR>", desc = "GPT Translate", mode = { "v" } },
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
