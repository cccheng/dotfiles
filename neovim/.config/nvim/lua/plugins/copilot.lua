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
            {
                "Davidyz/VectorCode",
                dependencies = { "nvim-lua/plenary.nvim" },
                cmd = "VectorCode",
                build = "uv tool upgrade vectorcode", -- optional but recommended. This keeps your CLI up-to-date.
                -- build = "pipx upgrade vectorcode",
                opts = {},
            },
            -- {
            --     "ravitemer/mcphub.nvim",
            --     build = "npm install -g mcp-hub@latest",
            --     cmd = "MCPHub",
            --     keys = {
            --         { "<leader>am", "<cmd>MCPHub<cr>", mode = "n", desc = "MCPHub" },
            --     },
            --     config = function()
            --         require("mcphub").setup()
            --     end
            -- },
        },
        keys = {
            { "<LEADER>a", "", desc = "AI Assistant" },
            { "<LEADER>aa", "<CMD>CodeCompanionActions<CR>", mode = { "n", "v" }, desc = "CodeCompanion actions" },
            { "<LEADER>ac", "<CMD>CodeCompanionChat Toggle<CR>", mode = { "n", "v" }, desc = "CodeCompanion chat" },
            { "<LEADER>ai", "<CMD>CodeCompanion<CR>", mode = { "n", "v" }, desc = "CodeCompanion inline" },
        },
        opts = {
            -- language = "English",
            adapters = {
                gemini_25_pro = function()
                    return require("codecompanion.adapters").extend("copilot", {
                        schema = {
                            model = {
                                default = "gemini-2.5-pro",
                            },
                        },
                    })
                end,
                opts = {
                    show_model_choices = true,
                },
            },
            strategies = {
                chat = {
                    adapter = "gemini_25_pro",
                    variables = {
                        ["buffer"] = {
                            opts = {
                                default_params = "watch", -- or "pin"
                            },
                        },
                    },
                    opts = {
                        completion_provider = "blink", -- blink|cmp|coc|default
                    }
                },
                inline = {
                    adapter = "gemini_25_pro",
                },
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
                    provider = "mini_diff", -- default|mini_diff
                },
            },
            extensions = {
                vectorcode = {
                    opts = {
                        add_tool = true,
                    }
                },
                -- mcphub = {
                --     callback = "mcphub.extensions.codecompanion",
                --     opts = {
                --         make_vars = true,
                --         make_slash_commands = true,
                --         show_result_in_chat = true
                --     }
                -- },
            },
            prompt_library = {
                ["Translate"] = {
                    strategy = "chat",
                    description = "Translate the selection into Traditional Chinese.",
                    opts = {
                        short_name = "trans",
                        auto_submit = true,
                        is_slash_cmd = true,
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
                        is_slash_cmd = true,
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
