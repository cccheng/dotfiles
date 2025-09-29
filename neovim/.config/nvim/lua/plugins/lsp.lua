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
        },
        config = function()
            local handlers = {
                -- none, single, double, rounded, shadow
                ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
                ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
            }

            for name, config in pairs(lsp_servers) do
                vim.lsp.config(name, {
                    capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities),
                    init_options = config.init_options,
                    on_attach = config.on_attach,
                    filetypes = config.filetypes,
                    settings = config.settings,
                    handlers = handlers,
                })

                vim.lsp.enable(name)
            end

            vim.keymap.set("n", "<LEADER>ls",  vim.lsp.buf.hover,                   { desc = "Hover" })
            vim.keymap.set("n", "<LEADER>llD", vim.lsp.buf.declaration,             { desc = "LSP Declaration" })
            vim.keymap.set("n", "<LEADER>lf",  vim.lsp.buf.format,                  { desc = "Format" })
            vim.keymap.set("n", "<LEADER>la",  vim.lsp.buf.code_action,             { desc = "Code action" })
            vim.keymap.set("n", "<LEADER>lS",  vim.lsp.buf.signature_help,          { desc = "Signature" })
            vim.keymap.set("n", "<LEADER>lR",  vim.lsp.buf.rename,                  { desc = "Rename" })
            -- vim.keymap.set("n", "<LEADER>lds", vim.diagnostic.open_float,           { desc = "Show diagnostic" })
            -- vim.keymap.set("n", "<LEADER>ldl", vim.diagnostic.setloclist,           { desc = "Diagnostic List" })
            vim.keymap.set("n", "<LEADER>llr", "<CMD>Telescope lsp_references<CR>", { desc = "LSP References" })
            vim.keymap.set("n", "<LEADER>lh",  function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { desc = "Toggle inlay hints" })
            vim.keymap.set("n", "<LEADER>lS",  "<CMD>LspStop<CR>",                  { desc = "Stop LSP" })
            vim.keymap.set("n", "<LEADER>lI",  "<CMD>LspInfo<CR>",                  { desc = "LSP Info" })
            vim.keymap.set("n", "<LEADER>lld", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, { desc = "LSP Definition" })
            -- vim.keymap.set("n", "<LEADER>lt", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, { desc = "LSP Type Definition" })
            -- vim.keymap.set("n", "<LEADER>li", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, { desc = "LSP Implementation" })
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
