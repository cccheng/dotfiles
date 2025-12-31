return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        event = {
            "BufNewFile",
            "BufReadPre",
        },
        config = function()
            require("nvim-treesitter").install({
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
        branch = "main",
        event = {
            "BufNewFile",
            "BufReadPre",
        },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            select = {
                lookahead = true,
                selection_modes = {
                    ["@class.outer"] = "V",
                    ["@function.outer"] = "v",
                    ["@parameter.outer"] = "v",
                },
                include_surrounding_whitespace = true,
                keymaps = {
                    select_textobject = {
                        ["aC"] = { query = "@comment.outer", desc = "TSTextObject | Around Comment" },
                        ["aa"] = { query = "@parameter.outer", desc = "TSTextObject | Outer Argument/Parameter" },
                        ["ac"] = { query = "@class.outer", desc = "TSTextObject | Around Class" },
                        ["af"] = { query = "@function.outer", desc = "TSTextObject | Around Function/Method" },
                        ["iC"] = { query = "@comment.outer", desc = "TSTextObject | Inner Comment" },
                        ["ia"] = { query = "@parameter.inner", desc = "TSTextObject | Inner Argument/Parameter" },
                        ["ic"] = { query = "@class.inner", desc = "TSTextObject | Inner Class" },
                        ["if"] = { query = "@function.inner", desc = "TSTextObject | Inner Function/Method" },
                    },
                },
            },
            move = {
                set_jumps = true,
                keymaps = {
                    goto_next_start = {
                        ["]<C-l>"] = { query = "@loop.*", desc = "TSTextObject | Next Loop Start" },
                        ["]<C-s>"] = { query = "@scope", query_group = "locals", desc = "TSTextObject | Next Scope Start" },
                        ["]<M-c>"] = { query = "@conditional.outer", desc = "TSTextObject | Next Condition" },
                        ["]C"] = { query = "@comment.outer", desc = "TSTextObject | Next Comment Start" },
                        ["]c"] = { query = "@class.outer", desc = "TSTextObject | Next Class Start" },
                        ["]f"] = { query = "@function.outer", desc = "TSTextObject | Next Function/Method Start" },
                        ["]r"] = { query = "@return.outer", desc = "TSTextObject | Next Return" },
                        ["]F"] = { query = "@fold", query_group = "folds", desc = "TSTextObject | Next Fold Start" },
                    },
                    goto_previous_start = {
                        ["[<C-l>"] = { query = "@loop.*", desc = "TSTextObject | Previous Loop Start" },
                        ["[<C-s>"] = { query = "@scope", query_group = "locals", desc = "TSTextObject | Previous Scope Start" },
                        ["[<M-c>"] = { query = "@conditional.outer", desc = "TSTextObject | Previous Condition" },
                        ["[C"] = { query = "@comment.outer", desc = "TSTextObject | Previous Comment Start" },
                        ["[c"] = { query = "@class.outer", desc = "TSTextObject | Previous Class Start" },
                        ["[f"] = { query = "@function.outer", desc = "TSTextObject | Previous Function/Method Start" },
                        ["[r"] = { query = "@return.outer", desc = "TSTextObject | Previous Return" },
                        ["[F"] = { query = "@fold", query_group = "folds", desc = "TSTextObject | Previous Fold Start" },
                    },
                },
            },
        },
    },
}
