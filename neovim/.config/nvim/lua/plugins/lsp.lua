return {
    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        config = function()
            require("mason").setup({})
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "clangd",
                    "rust_analyzer",
                }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
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

            vim.keymap.set("n", "<leader>s", vim.lsp.buf.hover, { desc = "Hover" })
            vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, { desc = "Declaration" })
            vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format" })
            vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code action" })
            vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, { desc = "Signature" })
            vim.keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
            vim.keymap.set("n", "<leader>ld", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, { desc = "Definition" })
            -- vim.keymap.set("n", "<leader>lt", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, { desc = "Type definition" })
            -- vim.keymap.set("n", "<leader>li", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, { desc = "Implementation" })
        end
    },
    {
        "hrsh7th/nvim-cmp",
        event = "VeryLazy",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
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
                sources = cmp.config.sources(
                    {
                        { name = "nvim_lsp" },
                        { name = "path" },
                    }, {
                        { name = "buffer" },
                    }
                ),
            })

            -- cmp.setup.cmdline({ "/", "?" }, {
            --     mapping = cmp.mapping.preset.cmdline(),
            --     sources = {
            --         { name = "buffer" }
            --     }
            -- })

            -- cmp.setup.cmdline(":", {
            --     mapping = cmp.mapping.preset.cmdline(),
            --     sources = cmp.config.sources(
            --         {
            --             { name = "path" }
            --         }, {
            --             { name = "cmdline" }
            --         }
            --     ),
            -- })

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
