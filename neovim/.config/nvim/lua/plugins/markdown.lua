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
                    icons = {},
                },
                code = {
                    sign = false,
                    border = "thin",
                    language_pad = 1,
                    left_pad = 1,
                    left_margin = 1,
                },
                bullet = {
                    enabled = true,
                    icons = { '•' },
                },
                checkbox = {
                    enabled = true,
                    bullet = true,
                    unchecked = { icon = '󱍫 ', highlight = 'DiagnosticInfo' },
                    checked = { icon = '󱍧 ', highlight = 'DiagnosticOk' },
                    custom = {
                        in_progress = { raw = '[~]', rendered = '󱍬 ', highlight = 'DiagnosticInfo' },
                        wont_do = { raw = '[>]', rendered = '󱍮 ', highlight = 'DiagnosticError' },
                        waiting = { raw = '[!]', rendered = '󱍥 ', highlight = 'DiagnosticWarn' },
                    },
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
            }):map("<LEADER>tm")
        end,
    }
}
