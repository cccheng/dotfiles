local PROMPTS = require("plugins.codecompanion.prompts")

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
            -- {
            --     "Davidyz/VectorCode",
            --     dependencies = { "nvim-lua/plenary.nvim" },
            --     cmd = "VectorCode",
            --     build = "uv tool upgrade vectorcode", -- optional but recommended. This keeps your CLI up-to-date.
            --     -- build = "pipx upgrade vectorcode",
            --     opts = {},
            -- },
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
                copilot = function()
                    return require("codecompanion.adapters").extend("copilot", {
                        schema = { model = { default = "claude-sonnet-4" } },
                    })
                end,
                copilot_inline = function()
                    return require("codecompanion.adapters").extend("copilot", {
                        schema = { model = { default = "claude-sonnet-4" } },
                    })
                end,
                opts = {
                    show_model_choices = true,
                },
            },
            strategies = {
                chat = {
                    adapter = "copilot",
                    roles = {
                        user = " " .. os.getenv("USER"),
                        llm = function(adapter)
                            local model_name = ""
                            if adapter.schema and adapter.schema.model and adapter.schema.model.default then
                                local model = adapter.schema.model.default
                                if type(model) == "function" then
                                    model = model(adapter)
                                end
                                model_name = "(" .. model .. ")"
                            end
                            return "󱚤 " .. adapter.formatted_name .. model_name
                        end,
                    },
                    variables = {
                        ["buffer"] = {
                            opts = {
                                default_params = "watch", -- or "pin"
                            },
                        },
                    },
                    keymaps = {
                        toggle = {
                            modes = {
                                n = "q",
                            },
                            index = 3,
                            callback = function()
                                vim.cmd("CodeCompanionChat Toggle")
                            end,
                            description = "Toggle Chat",
                        },
                        close = {
                            modes = {
                                n = "Q",
                            },
                            index = 3,
                            callback = "keymaps.close",
                            description = "Close Chat",
                        },
                        stop = {
                            modes = {
                                n = "<C-c>",
                            },
                            index = 4,
                            callback = "keymaps.stop",
                            description = "Stop Request",
                        },
                    },
                    opts = {
                        completion_provider = "blink", -- blink|cmp|coc|default
                    }
                },
                inline = {
                    adapter = "copilot_inline",
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
                -- vectorcode = {
                --     opts = {
                --         add_tool = true,
                --     }
                -- },
                -- mcphub = {
                --     callback = "mcphub.extensions.codecompanion",
                --     opts = {
                --         make_vars = true,
                --         make_slash_commands = true,
                --         show_result_in_chat = true
                --     }
                -- },
            },
            opts = {
                system_prompt = PROMPTS.SYSTEM_PROMPT,
            },
            prompt_library = PROMPTS.PROMPT_LIBRARY,
        },
        config = function(_, opts)
            require("codecompanion").setup(opts)
        end,
    },
}
