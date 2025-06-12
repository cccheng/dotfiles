return {
    {
        "saghen/blink.cmp",
        dependencies = {
            "echasnovski/mini.nvim",
            "Kaiser-Yang/blink-cmp-dictionary",
        },
        event = {
            "InsertEnter",
            "CmdlineEnter"
        },
        version = "1.*",
        opts = {
            -- "default" (recommended) for mappings similar to built-in completions (C-y to accept)
            -- "super-tab" for mappings similar to vscode (tab to accept)
            -- "enter" for enter to accept
            -- "none" for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = {
                preset = "enter",
                ["<C-e>"] = { "show", "fallback" },
                ["<C-k>"] = { "select_prev", "fallback" },
                ["<C-j>"] = { "select_next", "fallback" },
            },

            signature = {
                enabled = true,
                window = {
                    border = "rounded",
                    winblend = 10,
                }
            },

            appearance = {
                -- "mono" (default) for "Nerd Font Mono" or "normal" for "Nerd Font"
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = "mono"
            },

            completion = {
                -- Display a preview of the selected item on the current line
                ghost_text = {
                    enabled = false,
                },

                menu = {
                    winblend = 10,
                    draw = {
                        treesitter = { "lsp" },
                    },
                },

                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 100,
                    window = {
                        border = "single",
                        winblend = 10,
                    },
                },

                -- "prefix" will fuzzy match on the text before the cursor
                -- "full" will fuzzy match on the text before _and_ after the cursor
                -- example: "foo_|_bar" will match "foo_" for "prefix" and "foo__bar" for "full"
                keyword = {
                    range = "full"
                },
            },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = {
                    "lsp",
                    "path",
                    "snippets",
                    "buffer",
                    "dictionary",
                },
                per_filetype = {
                    codecompanion = { "codecompanion" },
                },
                providers = {
                    lsp = {
                        name = "LSP",
                        module = "blink.cmp.sources.lsp",
                        score_offset = 10,
                        fallbacks = {
                            "buffer",
                        },
                        transform_items = function(_, items)
                            return vim.tbl_filter(function(item)
                                return item.kind ~= require("blink.cmp.types").CompletionItemKind.Keyword
                            end, items)
                        end,
                    },
                    buffer = {
                        score_offset = 5,
                        -- keep case of first char
                        transform_items = function (a, items)
                            local keyword = a.get_keyword()
                            local correct, case
                            if keyword:match('^%l') then
                                correct = '^%u%l+$'
                                case = string.lower
                            elseif keyword:match('^%u') then
                                correct = '^%l+$'
                                case = string.upper
                            else
                                return items
                            end

                            -- avoid duplicates from the corrections
                            local seen = {}
                            local out = {}
                            for _, item in ipairs(items) do
                                local raw = item.insertText
                                if raw:match(correct) then
                                    local text = case(raw:sub(1,1)) .. raw:sub(2)
                                    item.insertText = text
                                    item.label = text
                                end
                                if not seen[item.insertText] then
                                    seen[item.insertText] = true
                                    table.insert(out, item)
                                end
                            end
                            return out
                        end
                    },
                    dictionary = {
                        name = "Dict",
                        module = "blink-cmp-dictionary",
                        score_offset = 3,
                        -- Make sure this is at least 2. 3 is recommended
                        min_keyword_length = 3,
                        -- max_items = 10,
                        opts = {
                            dictionary_files = {
                                "/usr/share/dict/words",
                            },
                        }
                    },
                    cmdline = {
                        min_keyword_length = function(ctx)
                            -- when typing a command, only show when the keyword is 2 characters or longer
                            if ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil then return 2 end
                            return 0
                        end
                    },
                },
            },

            -- Use a preset for snippets, check the snippets documentation for more information
            snippets = {
                preset = "mini_snippets"
            },

            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = {
                implementation = "prefer_rust_with_warning"
            },

            cmdline = {
                keymap = {
                    preset = "inherit",
                    ["<Tab>"] = { "accept" },
                    ["<CR>"] = { "accept_and_enter", "fallback" },
                },
                completion = {
                    menu = {
                        auto_show = function(ctx)
                            return vim.fn.getcmdtype() == ':'
                        end,
                    },
                },
                sources = function()
                    local type = vim.fn.getcmdtype()
                    if type == ":" or type == "@" then return { "cmdline" } end
                    return {}
                end,
            },
        },
        opts_extend = {
            "sources.default"
        },
    },
}
