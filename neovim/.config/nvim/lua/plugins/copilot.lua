return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "VeryLazy",
        config = function()
            require("copilot").setup({
                suggestion = {
                    auto_trigger = true,
                    keymap = {
                        accept = "<TAB>", -- false, -- handled by blink.cmp
                    },
                    panel = {
                        -- enabled = false,
                    },
                },
            })
        end,
    },
    {
        "olimorris/codecompanion.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            -- "ravitemer/mcphub.nvim",
        },
        keys = {
            { "<LEADER>a", mode = {"n", "v"}, "<CMD>CodeCompanionActions<CR>", desc = "CodeCompanion Actions" },
        },
        opts = {
            -- language = "English",
            strategies = {
            },
            display = {
                action_palette = {
                    opts = {
                        show_default_actions = true, -- Show the default actions in the action palette?
                        show_default_prompt_library = true, -- Show the default prompt library in the action palette?
                    },
                },
                chat = {
                    window = {
                    },
                },
                diff = {
                    provider = "default", -- default|mini_diff
                },
            },
            prompt_library = {
                ["Translate"] = {
                    strategy = "chat",
                    description = "Translate the selection into Traditional Chinese.",
                    opts = {
                        short_name = "trans",
                        auto_submit = true,
                    },
                    prompts = {
                        {
                            role = "system",
                            content = [[You are an expert translator with fluency in English and Chinese languages.]],
                        },
                        {
                            role = "user",
                            content = [[Please translate the selection into Traditional Chinese.]],
                        }
                    }
                },
                ["ProofReader"] = {
                    strategy = "chat",
                    description = "Proofread the selection.",
                    opts = {
                        short_name = "proof",
                        auto_submit = true,
                    },
                    prompts = {
                        {
                            role = "system",
                            content = [[You are a professional proofreader.]],
                        },
                        {
                            role = "user",
                            content = [[
Please review the selection for any spelling, grammar, or punctuation errors, verb tense issues,
or word choice problems. Once you have finished reviewing the text, please provide me with any
necessary corrections or suggestions to improve it.
                            ]],
                        },
                    },
                },
            },
        },
    },
}
