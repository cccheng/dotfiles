return {
    {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        cmd = "Copilot",
        config = function()
            require("copilot").setup({
                suggestion = {
                    auto_trigger = true,
                    keymap = {
                        -- accept = "<M-l>",
                        -- accept_word = false,
                        -- accept_line = false,
                        -- next = "<M-]>",
                        -- prev = "<M-[>",
                        -- dismiss = "<C-]>",
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
        },
        keys = {
            { "<LEADER>a", "", desc = "AI Assistant" },
            { "<LEADER>aa", "<CMD>CodeCompanionActions<CR>", mode = { "n", "v" }, desc = "CodeCompanion actions" },
            { "<LEADER>ac", "<CMD>CodeCompanionChat Toggle<CR>", mode = { "n", "v" }, desc = "CodeCompanion chat" },
            { "<LEADER>ai", "<CMD>CodeCompanion<CR>", mode = { "n", "v" }, desc = "CodeCompanion inline" },
        },
        opts = {
            adapters = {
                -- https://docs.github.com/en/copilot/reference/ai-models/supported-models
                -- https://docs.github.com/en/copilot/reference/ai-models/model-comparison
            },
            rules = {
                opts = {
                    chat = {
                        enabled = function(chat)
                            return chat.adapter.type ~= "acp"
                        end,
                    },
                },
            },
            interactions = {
                chat = {
                    adapter = {
                        name = "copilot",
                        -- "gpt-5.2", "gpt-5.1", "gpt-5.1-codex", "gpt-5.1-codex-mini", "gpt-5.1-codex-max"
                        -- "gpt-5", "gpt-5-codex", "gpt-5-mini", "gpt-4o", "gpt-4.1",
                        -- "claude-haiku-4.5", "claude-sonnet-4.5", "claude-sonnet-4", "claude-opus-4.5", "grok-code-fast-1"
                        -- "gemini-3-pro-preview", "gemini-3-flash-preview", "gemini-2.5-pro",
                        model = "claude-opus-4.5",
                    },
                    roles = {
                        user = " " .. os.getenv("USER"),
                        llm = function(adapter)
                            if adapter.model then
                                return string.format(
                                    "󰄛 %s (%s)",
                                    adapter.formatted_name,
                                    adapter.model.name
                                )
                            else
                                return "󰄛 " .. adapter.formatted_name
                            end
                        end,
                    },
                    variables = {
                        ["buffer"] = {
                            opts = {
                                -- Always sync the buffer by sharing its "diff"
                                -- Or choose "all" to share the entire buffer
                                default_params = "diff", -- or "all"
                            },
                        },
                    },
                    slash_commands = {
                        ["buffer"] = {
                            opts = { provider = "snacks" },
                        },
                        ["file"] = {
                            opts = { provider = "snacks" },
                        },
                        ["terminal"] = {
                            opts = { provider = "snacks" },
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
                    -- adapter = "",
                },
                cmd = {
                    -- adapter = "",
                },
                background = {
                    -- adapter = "",
                },
            },
            display = {
                action_palette = {
                    provider = "snacks",
                    opts = {
                        show_preset_actions = true, -- Show the default actions in the action palette
                        show_preset_prompts = true, -- Show the default prompt library in the action palette
                    },
                },
                chat = {
                    intro_message = "",
                    show_header_separator = true,
                    fold_context = true,
                    window = {
                    },
                    icons = {
                        buffer_sync_all = "󰪴 ",
                        buffer_sync_diff = " ",
                        chat_context = " ",
                        chat_fold = " ",
                        tool_pending = "  ",
                        tool_in_progress = "  ",
                        tool_failure = "  ",
                        tool_success = "  ",
                    },
                },
                diff = {
                    enabled = true,
                    provider = "inline", -- "inline", "split", "mini_diff"
                },
            },
            extensions = {
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
            -- prompt_library = PROMPTS.PROMPT_LIBRARY,
            prompt_library = {
                markdown = {
                    dirs = {
                        vim.fn.stdpath("config") .. "/lua/plugins/codecompanion/prompts",
                        "~/.config/prompts",
                        vim.fn.getcwd() .. "/.prompts",
                    },
                },
            },
        },
        config = function(_, opts)
            require("codecompanion").setup(opts)
            require("plugins.codecompanion.extmarks").setup()
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
