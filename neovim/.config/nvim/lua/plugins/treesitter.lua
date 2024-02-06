return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "c", "cpp", "rust", "ruby", "comment",
                    "bash", "diff", "regex", "json",
                    "disassembly", "strace", "kconfig",
                    "markdown", "markdown_inline", "html",
                    "gitcommit", "git_rebase", "diff",
                    "yaml", "toml", "ini", "dockerfile",
                    "lua", "vim", "vimdoc", "gpg", "nix",
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
                trim_scope = "inner",
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
