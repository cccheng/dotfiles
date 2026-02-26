return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "Avante", "copilot-chat", "codecompanion" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-mini/mini.nvim",
            "folke/snacks.nvim",
        },
        -- dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
        -- dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" }, -- if you use standalone mini plugins
        -- dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
        keys = {
            { "<LEADER>lm", mode = {"n"}, "<CMD>ToggleMarkdown<CR>", desc = "Markdown render" },
        },
        config = function()
            require("render-markdown").setup({
                file_types = {
                    "markdown",
                    "Avante",
                    "copilot-chat",
                    "codecompanion",
                },
                completions = {
                    lsp = { enabled = true },
                    blink = { enabled = true },
                },
                heading = {
                    sign = false,
                    icons = {},
                },
                code = {
                    sign = false,
                    language_pad = 1,
                    left_pad = 1,
                },
                bullet = {
                    enabled = false,
                },
            })

            Snacks.toggle({
                name = "Render Markdown",
                get = function()
                    return require("render-markdown.state").enabled
                end,
                set = function(state)
                    require("render-markdown").toggle(state)
                end,
            }):map("<LEADER>tM")
        end,
    }
}
