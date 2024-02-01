return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "c", "cpp", "rust", "ruby",
                    "bash", "diff", "regex", "json",
                    "strace", "kconfig",
                    "markdown", "html", "yaml", "toml", "ini",
                    "lua", "vim", "vimdoc",
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("treesitter-context").setup({
                max_lines = 3,
                mode = "cursor",
                patterns = {
                    default = {
                        "class",
                        "function",
                        "method",
                    },
                },
            })
        end
    },
}
