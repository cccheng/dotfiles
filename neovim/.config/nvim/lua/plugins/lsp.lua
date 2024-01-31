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
                        "compile_commands.json",
                        "compile_flags.txt",
                        "configure.ac",
                        ".git"
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
                },
            })

            lspconfig.rust_analyzer.setup({
                -- Server-specific settings. See `:help lspconfig-setup`
                settings = {
                    ['rust-analyzer'] = {},
                }
            })

            vim.keymap.set("n", "<leader>ls", "<cmd>LspStart<cr>", { desc = "Start LSP server" })
            vim.keymap.set("n", "<leader>lS", "<cmd>LspStop<cr>", { desc = "Stop LSP server" })
            vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { desc = "Hover" })
            vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { desc = "Definition" })
            vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, { desc = "Declaration" })
            vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, { desc = "References" })
            vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format" })
            vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, { desc = "Implementation" })
            vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code action" })
        end
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "path" },
                }, {
                    { name = "buffer" },
                }),
            })
        end
    }
}
