return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = {
            "BufNewFile",
            "BufReadPre",
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "bash", "c", "cmake", "comment", "cpp", "css", "csv",
                    "diff", "disassembly", "dockerfile", "dot", "editorconfig",
                    "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore",
                    "gnuplot", "go", "gpg", "graphql",
                    "haskell", "html", "http", "hyprlang", "ini",
                    "java", "javascript", "json", "kconfig", "lua",
                    "make", "markdown", "markdown_inline", "mermaid", "muttrc",
                    "nix", "objdump", "passwd", "pem", "printf", "python",
                    "readline", "regex", "rst", "ruby", "rust",
                    "sql", "ssh_config", "strace", "tmux", "toml", "typst",
                    "udev", "vim", "vimdoc", "xml", "yaml"
                },
                sync_install = false,
                highlight = {
                    enable = true
                },
                indent = {
                    enable = false,
                    disabled = {"c", "cpp"}, -- disabled for C proprocessor directive indent reset
                },
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = {
            "BufNewFile",
            "BufReadPre",
        },
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
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = {
            "BufNewFile",
            "BufReadPre",
        },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                textobjects = {
                    select = {
                        enable = true,
                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            -- You can optionally set descriptions to the mappings (used in the desc parameter of
                            -- nvim_buf_set_keymap) which plugins like which-key display
                            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                        },
                        -- You can choose the select mode (default is charwise 'v')
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * method: eg 'v' or 'o'
                        -- and should return the mode ('v', 'V', or '<c-v>') or a table
                        -- mapping query_strings to modes.
                        selection_modes = {
                            ['@parameter.outer'] = 'v', -- charwise
                            ['@function.outer'] = 'V', -- linewise
                            ['@class.outer'] = '<c-v>', -- blockwise
                        },
                        -- If you set this to `true` (default is `false`) then any textobject is
                        -- extended to include preceding or succeeding whitespace. Succeeding
                        -- whitespace has priority in order to act similarly to eg the built-in
                        -- `ap`.
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * selection_mode: eg 'v'
                        -- and should return true of false
                        include_surrounding_whitespace = true,
                    },
                },
            })
        end
    },
}
