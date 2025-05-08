return {
    {
        "mason-org/mason.nvim",
        event = "BufReadPre",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
    },
    {
        "mason-org/mason-lspconfig.nvim",
        event = "BufReadPre",
        dependencies = {
            "mason-org/mason.nvim",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "clangd",
                    "rust_analyzer",
                    "ruby_lsp",
                    "bashls",
                    "autotools_ls",
                    "lua_ls",
                    "typos_lsp",
                    "harper_ls",
                    "gitlab_ci_ls",
                    "dotls",
                    "marksman", -- markdown
                    "yamlls",
                    "jsonls",
                    "taplo", -- toml
                    "dockerls",
                }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "saghen/blink.cmp",
            -- "p00f/clangd_extensions.nvim",
        },
        keys = {
            { "<LEADER>l", "", desc = "LSP" },
        },
        config = function()
            local lspconfig = require("lspconfig")

            local handlers = {
                -- none, single, double, rounded, shadow
                ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
                ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
            }

            -- :help lspconfig-server-configurations
            local servers = {
                clangd = {
                    capabilities = {
                        offsetEncoding = { "utf-16" },
                    },
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--header-insertion=iwyu",
                        "--completion-style=detailed",
                        "--function-arg-placeholders",
                        "--fallback-style=llvm",
                    },
                    init_options = {
                        usePlaceholders = true,
                        completeUnimported = true,
                        clangdFileStatus = true,
                    },
                },
                rust_analyzer = {
                    on_attach = function(_, bufnr)
                        vim.lsp.inlay_hint.enable(bufnr)
                    end,
                    settings = {
                        ["rust-analyzer"] = {
                            imports = {
                                granularity = {
                                    group = "module",
                                },
                                prefix = "self",
                            },
                            cargo = {
                                buildScripts = {
                                    enable = true,
                                },
                            },
                            procMacro = {
                                enable = true,
                            },
                            check = {
                                command = "clippy",
                                features = "all",
                            },
                            diagnostics = {
                                enable = true,
                            }
                        },
                    }
                },
                -- ruby_lsp = {},
                bashls = {},
                autotools_ls = {},
                lua_ls = {},
                typos_lsp = {
                    init_options = {
                        diagnosticSeverity = "warning",
                    },
                },
                harper_ls = {
                    settings = {
                        ["harper-ls"] = {
                            -- userDictPath = vim.fn.stdpath("config") .. "/dict/spell.txt",
                            diagnosticSeverity = "warning", -- "hint", "information", "warning", or "error"
                            isolateEnglish = true,
                            linters = {
                                SpellCheck = false, -- true,
                                SpelledNumbers = false,
                                AnA = true,
                                SentenceCapitalization = false, -- true,
                                UnclosedQuotes = true,
                                WrongQuotes = false,
                                LongSentences = false,
                                RepeatedWords = true,
                                Spaces = false,
                                Matcher = true,
                                CorrectNumberSuffix = true,
                            },
                        },
                    },
                    -- filetypes = {
                    --     "text",
                    --     "markdown",
                    --     "gitcommit",
                    --     "gitsendemail",
                    --     "changelog",
                    -- },
                },
                gitlab_ci_ls = {},
                dotls = {},
                marksman = {},
                yamlls = {},
                jsonls = {},
                taplo = {},
                dockerls = {},
            }

            -- Iterate over our servers and set them up
            for name, config in pairs(servers) do
                lspconfig[name].setup({
                    capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities),
                    init_options = config.init_options,
                    on_attach = config.on_attach,
                    filetypes = config.filetypes,
                    settings = config.settings,
                    handlers = handlers,
                })
            end

            vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
                pattern = ".gitlab*",
                callback = function()
                    vim.bo.filetype = "yaml.gitlab"
                end,
            })

            vim.diagnostic.config({
                -- virtual_text = {
                --     severity = {
                --         max = vim.diagnostic.severity.WARN,
                --     }
                -- },
                -- virtual_lines = {
                --     severity = {
                --         min = vim.diagnostic.severity.ERROR,
                --     }
                -- },
                virtual_text = true,
                virtual_lines = false,
                underline = false,
                signs = false,
                update_in_insert = false, -- false so diags are updated on InsertLeave
                severity_sort = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "single",
                    source = true,
                    header = "",
                },
            })
            vim.api.nvim_create_user_command("ToggleDiagnostics", function()
                if vim.g.diagnostics_mode == "enabled" then
                    vim.g.diagnostics_mode = "disabled"
                    vim.diagnostic.disable()
                elseif vim.g.diagnostics_mode == "disabled" then
                    vim.g.diagnostics_mode = "enabled"
                    vim.diagnostic.enable()
                else
                    vim.g.diagnostics_mode = "disabled"
                    vim.diagnostic.disable()
                end
            end, {})

            vim.keymap.set("n", "<LEADER>ls",  vim.lsp.buf.hover,                   { desc = "Hover" })
            vim.keymap.set("n", "<LEADER>llD", vim.lsp.buf.declaration,             { desc = "LSP Declaration" })
            vim.keymap.set("n", "<LEADER>lf",  vim.lsp.buf.format,                  { desc = "Format" })
            vim.keymap.set("n", "<LEADER>la",  vim.lsp.buf.code_action,             { desc = "Code action" })
            vim.keymap.set("n", "<LEADER>lS",  vim.lsp.buf.signature_help,          { desc = "Signature" })
            vim.keymap.set("n", "<LEADER>lR",  vim.lsp.buf.rename,                  { desc = "Rename" })
            -- vim.keymap.set("n", "<LEADER>lds", vim.diagnostic.open_float,           { desc = "Show diagnostic" })
            -- vim.keymap.set("n", "<LEADER>ldl", vim.diagnostic.setloclist,           { desc = "Diagnostic List" })
            vim.keymap.set("n", "<LEADER>lD", "<CMD>ToggleDiagnostics<CR>",        { desc = "Toggle diagnostic" })
            vim.keymap.set("n", "<LEADER>llr", "<CMD>Telescope lsp_references<CR>", { desc = "LSP References" })
            vim.keymap.set("n", "<LEADER>lh",  function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { desc = "Toggle inlay hints" })
            vim.keymap.set("n", "<LEADER>lS",  "<CMD>LspStop<CR>",                  { desc = "Stop LSP" })
            vim.keymap.set("n", "<LEADER>lI",  "<CMD>LspInfo<CR>",                  { desc = "LSP Info" })
            vim.keymap.set("n", "<LEADER>lld", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, { desc = "LSP Definition" })
            -- vim.keymap.set("n", "<LEADER>lt", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, { desc = "LSP Type Definition" })
            -- vim.keymap.set("n", "<LEADER>li", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, { desc = "LSP Implementation" })
            vim.keymap.set("n", "[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity["ERROR"] }) end, { desc = "Previous error" })
            vim.keymap.set("n", "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity["ERROR"] }) end, { desc = "Next error" })
            vim.keymap.set("n", "[w", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity["WARN"] }) end, { desc = "Previous warning" })
            vim.keymap.set("n", "]w", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity["WARN"] }) end, { desc = "Next warning" })
        end
    },
    {
        "saghen/blink.cmp",
        dependencies = {
            "echasnovski/mini.nvim",
            "Kaiser-Yang/blink-cmp-dictionary",
            "moyiz/blink-emoji.nvim",
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
                    "emoji",
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
                    emoji = {
                        name = "Emoji",
                        module = "blink-emoji",
                        score_offset = 0,
                        opts = { insert = true }, -- Insert emoji (default) or complete its name
                        -- should_show_items = function()
                        --     return vim.tbl_contains(
                        --     -- Enable emoji completion only for git commits and markdown.
                        --     { "gitcommit", "markdown" },
                        --     vim.o.filetype
                        --     )
                        -- end,
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
    {
        "DNLHC/glance.nvim",
        event = "BufReadPre",
        config = function()
            local glance = require("glance")
            local actions = glance.actions

            require("glance").setup({
                mappings = {
                    list = {
                        ["<C-e>"] = actions.preview_scroll_win(-1),
                        ["<C-y>"] = actions.preview_scroll_win(1),
                        ["<C-v>"] = actions.jump_vsplit, -- Open location in vertical split
                        ["<C-s>"] = actions.jump_split, -- Open location in horizontal split
                        ["<C-t>"] = actions.jump_tab, -- Open in new tab
                    },
                },
            })

            vim.keymap.set("n", "<LEADER>ld", "<CMD>Glance definitions<CR>", { desc = "Definition" })
            vim.keymap.set("n", "<LEADER>lr", "<CMD>Glance references<CR>", { desc = "References" })
            vim.keymap.set("n", "<LEADER>lt", "<CMD>Glance type_definitions<CR>", { desc = "Type Definition" })
            vim.keymap.set("n", "<LEADER>li", "<CMD>Glance implementations<CR>", { desc = "Implementation" })
        end
    },
}
