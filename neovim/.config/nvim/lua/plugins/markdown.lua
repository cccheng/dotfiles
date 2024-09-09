return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = "markdown",
        -- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
        -- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
        opts = {
            heading = {
                sign = false,
                icons = {},
            },
            code = {
                sign = false,
                language_pad = 1,
                left_pad = 1,
            },
        },
        keys = {
            { "<LEADER>lm", mode = {"n"}, "<CMD>ToggleMarkdown<CR>", desc = "Markdown render" },
        },
        config = function()
            vim.api.nvim_create_user_command("ToggleMarkdown", function()
                if require("render-markdown.state").enabled then
                    require("render-markdown").disable();
                else
                    require("render-markdown").enable();
                end
            end, {})
        end,
    }
}
