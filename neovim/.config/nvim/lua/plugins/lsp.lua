return {
    {
        "williamboman/mason.nvim",
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
        "williamboman/mason-lspconfig.nvim",
        event = "BufReadPre",
        dependencies = {
            "williamboman/mason.nvim",
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
            "hrsh7th/nvim-cmp",
            "p00f/clangd_extensions.nvim",
        },
        config = function()
            local lspconfig = require("lspconfig")

            -- nvim-cmp supports additional completion capabilities
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local default_capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
            local handlers = {
                -- none, single, double, rounded, shadow 
                ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
                ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
            }

            -- :help lspconfig-server-configurations
            local servers = {
                clangd = {
                    root_dir = function(fname)
                        return require("lspconfig.util").root_pattern(
                            "Makefile",
                            "configure.ac",
                            "configure.in",
                            "config.h.in",
                            ".clangd",
                            ".clang-tidy",
                            ".clang-format",
                            "compile_commands.json"
                        )(fname) or require("lspconfig.util").find_git_ancestor(fname)
                    end,
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--header-insertion=iwyu",
                        "--completion-style=detailed",
                        "--function-arg-placeholders",
                        "--fallback-style=llvm",
                        "--offset-encoding=utf-16",
                    },
                },
                rust_analyzer = {
                    -- on_attach = function(client, bufnr)
                    --     vim.lsp.inlay_hint.enable(bufnr)
                    -- end,
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
                ruby_lsp = {},
                bashls = {},
                autotools_ls = {},
                lua_ls = {},
                typos_lsp = {},
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
                    capabilities = default_capabilities,
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

            vim.api.nvim_create_user_command("ToggleDiagnostics", function()
                if vim.g.diagnostics_enabled == nil then
                    vim.g.diagnostics_enabled = false
                    vim.diagnostic.disable()
                elseif vim.g.diagnostics_enabled then
                    vim.g.diagnostics_enabled = false
                    vim.diagnostic.disable()
                else
                    vim.g.diagnostics_enabled = true
                    vim.diagnostic.enable()
                end
            end, {})

            require("which-key").add({
                { "<LEADER>e", group = "Diagnostic" },
                { "<LEADER>l", group = "LSP" },
            })

            vim.keymap.set("n", "<LEADER>ls",  vim.lsp.buf.hover,                   { desc = "Hover" })
            vim.keymap.set("n", "<LEADER>lD",  vim.lsp.buf.declaration,             { desc = "Declaration" })
            vim.keymap.set("n", "<LEADER>lf",  vim.lsp.buf.format,                  { desc = "Format" })
            vim.keymap.set("n", "<LEADER>la",  vim.lsp.buf.code_action,             { desc = "Code action" })
            vim.keymap.set("n", "<LEADER>lS",  vim.lsp.buf.signature_help,          { desc = "Signature" })
            vim.keymap.set("n", "<LEADER>lR",  vim.lsp.buf.rename,                  { desc = "Rename" })
            vim.keymap.set("n", "<LEADER>lds", vim.diagnostic.open_float,           { desc = "Show diagnostic" })
            vim.keymap.set("n", "<LEADER>ldl", vim.diagnostic.setloclist,           { desc = "Diagnostic List" })
            vim.keymap.set("n", "<LEADER>ldd", "<CMD>ToggleDiagnostics<CR>",        { desc = "Toggle diagnostic" })
            vim.keymap.set("n", "<LEADER>lr",  "<CMD>Telescope lsp_references<CR>", { desc = "References" })
            vim.keymap.set("n", "<LEADER>lh",  "<CMD>ClangdToggleInlayHints<CR>",   { desc = "Toggle inlay hints" })
            vim.keymap.set("n", "<LEADER>lS",  "<CMD>LspStop<CR>",                  { desc = "Stop LSP" })
            vim.keymap.set("n", "<LEADER>lI",  "<CMD>LspInfo<CR>",                  { desc = "LSP Info" })
            vim.keymap.set("n", "<LEADER>ld", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, { desc = "Definition" })
            -- vim.keymap.set("n", "<LEADER>lt", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, { desc = "Type definition" })
            -- vim.keymap.set("n", "<LEADER>li", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, { desc = "Implementation" })
            vim.keymap.set("n", "[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity["ERROR"] }) end, { desc = "Previous error" })
            vim.keymap.set("n", "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity["ERROR"] }) end, { desc = "Next error" })
            vim.keymap.set("n", "[w", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity["WARN"] }) end, { desc = "Previous warning" })
            vim.keymap.set("n", "]w", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity["WARN"] }) end, { desc = "Next warning" })
        end
    },
    {
        "hrsh7th/nvim-cmp",
        event = {
            "InsertEnter",
            "CmdlineEnter"
        },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-calc",
            "hrsh7th/cmp-cmdline",
            -- "hrsh7th/vim-vsnip",  -- remove it after neovim 0.10
            -- "hrsh7th/cmp-vsnip",  -- remove it after neovim 0.10
        },
        config = function()
            local cmp = require("cmp")
            local select_opts = { behavior = cmp.SelectBehavior.Select }

            vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

            cmp.setup({
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                    completion = {
                        completeopt = "menu,menuone,noinsert",
                        winblend = 10,
                    },
                    documentation = {
                        winblend = 10,
                    },
                },
                performance = {
                    debounce = 0, -- default is 60ms
                    throttle = 0, -- default is 30ms     
                },
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)  -- Use native snippets. Only works on Neovim >= 0.10!
                        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                        -- require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                        -- require("snippy").expand_snippet(args.body) -- For `snippy` users.
                        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                    end,
                },
                formatting = {
                    fields = {"menu", "abbr", "kind"},
                    format = function(entry, item)
                        local menu_icon = {
                            nvim_lsp = "λ",
                            buffer = "󰻫",
                            path = "🖫",
                            calc = "󰍛",
                        }

                        item.menu = menu_icon[entry.source.name]
                        return item
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping({
                        i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
                        s = cmp.mapping.confirm({ select = true }),
                        c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                    }),
                    ["<TAB>"] = cmp.mapping({
                        i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
                        s = cmp.mapping.confirm({ select = true }),
                        c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                    }),
                    ["<Up>"] = cmp.mapping.select_prev_item(select_opts),
                    ["<Down>"] = cmp.mapping.select_next_item(select_opts),
                    ["<C-k>"] = cmp.mapping.select_prev_item(select_opts),
                    ["<C-j>"] = cmp.mapping.select_next_item(select_opts),
                    ["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
                    ["<C-n>"] = cmp.mapping.select_next_item(select_opts),
                }),
                completion = {
                    completeopt = "menu,menuone,noinsert,noselect",
                },
                sources = cmp.config.sources({
                        { name = "nvim_lsp", max_item_count = 10 },
                        { name = "buffer",   max_item_count = 10, keyword_length = 2 },
                        { name = "path",     max_item_count = 10, keyword_length = 3 },
                        { name = "calc",     max_item_count = 10, keyword_length = 2 },
                        -- { name = "vsnip",    max_item_count = 10, keyword_length = 2 },
                }),
                experimental = {
                    ghost_text = false -- { hl_group = "CmpGhostText" },
                },
                sorting = require("cmp.config.default")().sorting,
            })

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" }
                },
                completion = {
                    autocomplete = false,
                },
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                    { name = "cmdline" }
                }),
                completion = {
                    autocomplete = false,
                },
            })
        end
    },
    {
        "DNLHC/glance.nvim",
        event = "BufReadPre",
        config = function()
            local glance = require('glance')
            local actions = glance.actions

            require("glance").setup({
                mappings = {
                    list = {
                        ["<C-e>"] = actions.preview_scroll_win(-1),
                        ["<C-y>"] = actions.preview_scroll_win(1),
                    },
                },
            })

            vim.keymap.set("n", "<LEADER>d", "<CMD>Glance definitions<CR>", { desc = "Definition" })
            vim.keymap.set("n", "<LEADER>r", "<CMD>Glance references<CR>", { desc = "References" })
            vim.keymap.set("n", "<LEADER>lt", "<CMD>Glance type_definitions<CR>", { desc = "Type Definition" })
            vim.keymap.set("n", "<LEADER>li", "<CMD>Glance implementations<CR>", { desc = "Implementation" })
        end
    },
}
