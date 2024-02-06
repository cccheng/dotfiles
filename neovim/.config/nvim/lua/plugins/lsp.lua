return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                PATH = "prepend", -- "skip" seems to cause the spawning error
            })
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "clangd",
                    "rust_analyzer",
                    "lua_ls",
                    "typos_lsp",
                    "marksman", -- markdown
                    "taplo", -- toml
                }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local lspconfig = require("lspconfig")

            lspconfig.clangd.setup({
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
            })

            lspconfig.rust_analyzer.setup({
                -- Server-specific settings. See `:help lspconfig-setup`
                settings = {
                    ['rust-analyzer'] = {},
                }
            })

            lspconfig.lua_ls.setup({})
            lspconfig.typos_lsp.setup({})
            lspconfig.marksman.setup({})
            lspconfig.taplo.setup({})

            local wk = require("which-key")

            wk.register({ ["<leader>e"] = { name = "+Diagnostic" } })
            wk.register({ ["<leader>l"] = { name = "+LSP" } })

            vim.keymap.set("n", "[d",         vim.diagnostic.goto_prev,   { desc = "Prev diagnostic" })
            vim.keymap.set("n", "]d",         vim.diagnostic.goto_next,   { desc = "Next diagnostic" })
            vim.keymap.set("n", "<leader>es", vim.diagnostic.open_float,  { desc = "Show diagnostic" })
            vim.keymap.set("n", "<leader>el", vim.diagnostic.setloclist,  { desc = "Diagnostic List" })
            vim.keymap.set("n", "<leader>s",  vim.lsp.buf.hover,          { desc = "Hover" })
            vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration,    { desc = "Declaration" })
            vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format,         { desc = "Format" })
            vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action,    { desc = "Code action" })
            vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, { desc = "Signature" })
            vim.keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
            vim.keymap.set("n", "<leader>lS", "<cmd>LspStop<cr>", { desc = "Stop LSP" })
            vim.keymap.set("n", "<leader>lI", "<cmd>LspInfo<cr>", { desc = "LSP Info" })
            vim.keymap.set("n", "<leader>ld", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, { desc = "Definition" })
            -- vim.keymap.set("n", "<leader>lt", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, { desc = "Type definition" })
            -- vim.keymap.set("n", "<leader>li", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, { desc = "Implementation" })
        end
    },
    {
        "L3MON4D3/LuaSnip",
        event = "VeryLazy",
        build = "make install_jsregexp"
    },
    {
        "hrsh7th/nvim-cmp",
        event = "VeryLazy",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                },
                snippet = {
                    expand = function(args)
                        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
                        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping({
                        i = function(fallback)
                            if cmp.visible() and cmp.get_active_entry() then
                                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                            else
                                fallback()
                            end
                        end,
                        s = cmp.mapping.confirm({ select = true }),
                        c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                    })
                }),
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                sources = cmp.config.sources({
                        { name = "nvim_lsp" },
                        { name = "luasnip" },
                        { name = "path" },
                        { name = "buffer" },
                }),
            })

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" }
                }
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                    { name = "cmdline" }
                }),
            })

            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            require('lspconfig')["clangd"].setup {
                capabilities = capabilities
            }
        end
    },
    {
        "DNLHC/glance.nvim",
        event = "VeryLazy",
        config = function()
            require('glance').setup({})

            vim.keymap.set("n", "<leader>d", "<cmd>Glance definitions<cr>", { desc = "Definition" })
            vim.keymap.set("n", "<leader>r", "<cmd>Glance references<cr>", { desc = "References" })
            vim.keymap.set("n", "<leader>lt", "<cmd>Glance type_definitions<cr>", { desc = "Type Definition" })
            vim.keymap.set("n", "<leader>li", "<cmd>Glance implementations<cr>", { desc = "Implementation" })
        end
    },
}
