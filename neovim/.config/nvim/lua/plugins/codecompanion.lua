local PROMPTS = require("plugins.codecompanion.prompts")

return {
    {
        "zbirenbaum/copilot.lua",
        lazy = true,
        cmd = "Copilot",
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
        lazy = true,
        cmd = {
            "CodeCompanion",
            "CodeCompanionActions",
            "CodeCompanionChat",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "ravitemer/mcphub.nvim",
            -- {
            --     "Davidyz/VectorCode",
            --     dependencies = { "nvim-lua/plenary.nvim" },
            --     cmd = "VectorCode",
            --     build = "uv tool upgrade vectorcode", -- optional but recommended. This keeps your CLI up-to-date.
            --     -- build = "pipx upgrade vectorcode",
            --     opts = {},
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
                http = {
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
                    intro_message = "",
                    show_header_separator = true,
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
                mcphub = {
                    callback = "mcphub.extensions.codecompanion",
                    opts = {
                        -- MCP Tools
                        make_tools = true,                    -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
                        show_server_tools_in_chat = true,     -- Show individual tools in chat completion (when make_tools=true)
                        add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
                        show_result_in_chat = true,           -- Show tool results directly in chat buffer
                        format_tool = nil,                    -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
                        -- MCP Resources
                        make_vars = true,                     -- Convert MCP resources to #variables for prompts
                        -- MCP Prompts
                        make_slash_commands = true,           -- Add MCP prompts as /slash commands
                    }
                },
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
    {
        "ravitemer/mcphub.nvim",
        lazy = true,
        -- build = "npm install -g mcp-hub@latest",
        cmd = "MCPHub",
        keys = {
            { "<leader>am", "<cmd>MCPHub<cr>", mode = "n", desc = "MCPHub" },
        },
        config = function()
            require("mcphub").setup({
                edit_file = {
                    parser = {
                        track_issues = true,                    -- Track parsing issues for LLM feedback
                        extract_inline_content = true,          -- Handle content on marker lines
                    },
                    locator = {
                        fuzzy_threshold = 0.8,                  -- Minimum similarity for fuzzy matches (0.0-1.0)
                        enable_fuzzy_matching = true,           -- Allow fuzzy matching when exact fails
                    },
                    ui = {
                        go_to_origin_on_complete = true,        -- Jump back to original file on completion
                        keybindings = {
                            accept = ".",                       -- Accept current change
                            reject = ",",                       -- Reject current change
                            next = "n",                         -- Next diff
                            prev = "p",                         -- Previous diff
                            accept_all = "ga",                  -- Accept all remaining changes
                            reject_all = "gr",                  -- Reject all remaining changes
                        },
                    },
                    feedback = {
                        include_parser_feedback = true,         -- Include parsing feedback for LLM
                        include_locator_feedback = true,        -- Include location feedback for LLM
                        include_ui_summary = true,              -- Include UI interaction summary
                        ui = {
                            include_session_summary = true,     -- Include session summary in feedback
                            include_final_diff = true,          -- Include final diff in feedback
                            send_diagnostics = true,            -- Include diagnostics after editing
                            wait_for_diagnostics = 500,         -- Wait time for diagnostics (ms)
                            diagnostic_severity = vim.diagnostic.severity.WARN, -- Min severity to include
                        },
                    },
                }
            })
        end
    },
}
