local lsp_servers = {
    "clangd",
    "rust_analyzer",
    "typos_lsp",
    "harper_ls",
    "yamlls",
    "bashls",
    "cssls",
    "cssmodules_ls",
    "dockerls",
    "dotls",
    "gitlab_ci_ls",
    "html",
    "jsonls",
    "lua_ls",
    "marksman", -- markdown
    "pylsp",
    "ruby_lsp",
    "taplo", -- toml
}

local lsp_server_names = {}
for key, _ in pairs(lsp_servers) do
    table.insert(lsp_server_names, key)
end

return {
    {
        "mason-org/mason-lspconfig.nvim",
        lazy = true,
        cmd = "Mason",
        dependencies = {
            {
                "mason-org/mason.nvim",
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
                "neovim/nvim-lspconfig"
            }
        },
        config = function()
            require("mason-lspconfig").setup({
                automatic_enable = false,
                ensure_installed = lsp_servers,
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
            vim.lsp.enable(lsp_servers)
        end
    },
    {
        "DNLHC/glance.nvim",
        lazy = true,
        cmd = "Glance",
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
