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
        init = function()
            -- Disable entire built-in ftplugin mappings to avoid conflicts.
            -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
            vim.g.no_plugin_maps = true

            -- Or, disable per filetype (add as you like)
            -- vim.g.no_python_maps = true
            -- vim.g.no_ruby_maps = true
            -- vim.g.no_rust_maps = true
            -- vim.g.no_go_maps = true
        end,
        opts = {
            select = {
                -- Automatically jump forward to textobj, similar to targets.vim
                lookahead = true,
                -- You can choose the select mode (default is charwise 'v')
                --
                -- Can also be a function which gets passed a table with the keys
                -- * query_string: eg '@function.inner'
                -- * method: eg 'v' or 'o'
                -- and should return the mode ('v', 'V', or '<c-v>') or a table
                -- mapping query_strings to modes.
                selection_modes = {
                    ["@parameter.outer"] = "v", -- charwise
                    ["@function.outer"] = "V", -- linewise
                    ["@class.outer"] = "<c-v>", -- blockwise
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
                keymaps = {
                    select_textobject = {
                        ["a<C-s>"] = { query = "@local.scope", query_group = "locals", desc = "TSTextObject | Language Scope" },
                        ["a<M-c>"] = { query = "@conditional.outer", desc = "TSTextObject | Around Condition" },
                        ["aC"] = { query = "@comment.outer", desc = "TSTextObject | Around Comment" },
                        ["aa"] = { query = "@parameter.outer", desc = "TSTextObject | Outer Argument/Parameter" },
                        ["ac"] = { query = "@class.outer", desc = "TSTextObject | Around Class" },
                        ["af"] = { query = "@function.outer", desc = "TSTextObject | Around Function/Method" },
                        ["i<M-c>"] = { query = "@conditional.inner", desc = "TSTextObject | Inner Condition" },
                        ["iC"] = { query = "@comment.outer", desc = "TSTextObject | Inner Comment" },
                        ["ia"] = { query = "@parameter.inner", desc = "TSTextObject | Inner Argument/Parameter" },
                        ["ic"] = { query = "@class.inner", desc = "TSTextObject | Inner Class" },
                        ["if"] = { query = "@function.inner", desc = "TSTextObject | Inner Function/Method" },
                    },
                },
            },
            swap = {
                keymaps = {
                    swap_next = {
                        ["<lEADER>ln"] = { query = "@parameter.inner", desc = "TSTextObject | Swap Params Next" },
                    },
                    swap_previous = {
                        ["<LEADER>lp"] = { query = "@parameter.inner", desc = "TSTextObject | Swap Params Previous" },
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
                        ["]<M-C>"] = { query = "@comment.outer", desc = "TSTextObject | Next Comment Start" },
                        ["]C"] = { query = "@class.outer", desc = "TSTextObject | Next Class Start" },
                        ["]f"] = { query = "@function.outer", desc = "TSTextObject | Next Function/Method Start" },
                        ["]r"] = { query = "@return.outer", desc = "TSTextObject | Next Return" },
                        ["]F"] = { query = "@fold", query_group = "folds", desc = "TSTextObject | Next Fold Start" },
                    },
                    goto_previous_start = {
                        ["[<C-l>"] = { query = "@loop.*", desc = "TSTextObject | Previous Loop Start" },
                        ["[<C-s>"] = { query = "@scope", query_group = "locals", desc = "TSTextObject | Previous Scope Start" },
                        ["[<M-c>"] = { query = "@conditional.outer", desc = "TSTextObject | Previous Condition" },
                        ["[<M-C>"] = { query = "@comment.outer", desc = "TSTextObject | Previous Comment Start" },
                        ["[C"] = { query = "@class.outer", desc = "TSTextObject | Previous Class Start" },
                        ["[f"] = { query = "@function.outer", desc = "TSTextObject | Previous Function/Method Start" },
                        ["[r"] = { query = "@return.outer", desc = "TSTextObject | Previous Return" },
                        ["[F"] = { query = "@fold", query_group = "folds", desc = "TSTextObject | Previous Fold Start" },
                    },
                },
            },
        },
        config = function(_, opts)
            require("nvim-treesitter-textobjects").setup(opts)

            for select_func, select_values in pairs(opts.select.keymaps) do
                for select_keymap, select_keymap_value in pairs(select_values) do
                    vim.keymap.set({ "x", "o" }, select_keymap, function()
                        require("nvim-treesitter-textobjects.select")[select_func](select_keymap_value["query"], select_keymap_value["query_group"])
                    end, { desc = select_keymap_value["desc"], silent = true, })
                end
            end

            for swap_func, swap_values in pairs(opts.swap.keymaps) do
                for swap_keymap, swap_keymap_value in pairs(swap_values) do
                    vim.keymap.set("n", swap_keymap, function()
                        require("nvim-treesitter-textobjects.swap")[swap_func](swap_keymap_value["query"], swap_keymap_value["query_group"])
                    end, { desc = swap_keymap_value["desc"], silent = true, })
                end
            end

            for move_func, move_values in pairs(opts.move.keymaps) do
                for move_keymap, move_keymap_value in pairs(move_values) do
                    vim.keymap.set({ "n", "x", "o" }, move_keymap, function()
                        require("nvim-treesitter-textobjects.move")[move_func](move_keymap_value["query"], move_keymap_value["query_group"])
                    end, { desc = move_keymap_value["desc"], silent = true, })
                end
            end
        end,
    },
}
