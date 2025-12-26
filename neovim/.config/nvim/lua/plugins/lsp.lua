local lsp_servers = {
    clangd = {
        capabilities = {
            offsetEncoding = { "utf-16" },
            textDocument = {
                inlayHints = { enabled = true },
                completion = { editsNearCursor = true },
            },
        },
        cmd = {
            "clangd",
            "--background-index",
            "--background-index-priority=background",
            "--all-scopes-completion",
            "--pch-storage=memory",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--enable-config",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
        },
        init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
        },
        settings = {
            clangd = {
                semanticHighlighting = true,
            },
        },
    },
    rust_analyzer = {
        settings = {
            ["rust-analyzer"] = {
                imports = {
                    granularity = {
                        group = "module",
                    },
                    prefix = "self",
                },
                cargo = {
                    allFeatures = true,
                    loadOutDirsFromCheck = true,
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

                linters = {
                    SpellCheck = false, -- true,
                    SpelledNumbers = false,
                    AnA = true,
                    SentenceCapitalization = false, -- true,
                    UnclosedQuotes = true,
                    WrongQuotes = false,
                    LongSentences = true,
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
    yamlls = {
        settings = {
            yaml = {
                customTags = {
                    "!reference sequence",  -- gitlab-ci.yml
                },
            },
        },
    },
    autotools_ls = {},
    bashls = {},
    cssls = {},
    cssmodules_ls = {},
    dockerls = {},
    dotls = {},
    gitlab_ci_ls = {},
    html = {},
    jsonls = {},
    lua_ls = {},
    marksman = {}, -- markdown
    ruby_lsp = {},
    taplo = {}, -- toml
}

local lsp_server_names = {}
for key, _ in pairs(lsp_servers) do
    table.insert(lsp_server_names, key)
end

return {
    {
        "mason-org/mason.nvim",
        lazy = true,
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
        lazy = true,
        cmd = {
            "Mason",
        },
        dependencies = {
            "neovim/nvim-lspconfig",
            "mason-org/mason.nvim",
        },
        config = function()
            require("mason-lspconfig").setup({
                automatic_enable = false,
                ensure_installed = lsp_server_names
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        event = {
            "BufNewFile",
            "BufReadPre",
        },
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "saghen/blink.cmp",
            -- "p00f/clangd_extensions.nvim",
        },
        keys = {
            { "<LEADER>l", "", desc = "LSP" },
            { "<LEADER>ls",  function() vim.lsp.buf.hover({ border = "single" }) end, desc = "Hover" },
            { "<LEADER>lS",  function() vim.lsp.buf.signature_help({ border = "single" }) end, desc = "Signature" },
            { "<LEADER>lh",  function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, desc = "Toggle inlay hints" },
            { "<LEADER>la",  function() vim.lsp.buf.code_action() end, desc = "Code action" },
            { "<LEADER>lf",  function() vim.lsp.buf.format() end, desc = "Format" },
            { "<LEADER>lR",  function() vim.lsp.buf.rename() end, desc = "Rename" },
            { "<LEADER>lS",  "<CMD>LspStop<CR>", desc = "Stop LSP" },
            { "<LEADER>lI",  "<CMD>LspInfo<CR>", desc = "LSP Info" },
            { "<LEADER>lld", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
            { "<LEADER>llr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
            { "<LEADER>lli", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
            { "<LEADER>llt", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto Type Definition" },
            { "<LEADER>lls", function() Snacks.picker.lsp_symbols({ filter = LazyVim.config.kind_filter }) end, desc = "LSP Symbols" },
            { "<LEADER>llw", function() Snacks.picker.lsp_workspace_symbols({ filter = LazyVim.config.kind_filter }) end, desc = "LSP Workspace Symbols" },
            { "<LEADER>llci", function() Snacks.picker.lsp_incoming_calls() end, desc = "Calls Incoming" },
            { "<LEADER>llco", function() Snacks.picker.lsp_outgoing_calls() end, desc = "Calls Outgoing" },
        },
        config = function()
            for name, config in pairs(lsp_servers) do
                vim.lsp.config(name, {
                    capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities),
                    init_options = config.init_options,
                    on_attach = config.on_attach,
                    filetypes = config.filetypes,
                    settings = config.settings,
                })

                vim.lsp.enable(name)
            end
        end
    },
    {
        "DNLHC/glance.nvim",
        lazy = true,
        keys = {
            { "<LEADER>ld", "<CMD>Glance definitions<CR>", desc = "Definition" },
            { "<LEADER>lr", "<CMD>Glance references<CR>", desc = "References" },
            { "<LEADER>lt", "<CMD>Glance type_definitions<CR>", desc = "Type Definition" },
            { "<LEADER>li", "<CMD>Glance implementations<CR>", desc = "Implementation" },
        },
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
        end
    },
}
