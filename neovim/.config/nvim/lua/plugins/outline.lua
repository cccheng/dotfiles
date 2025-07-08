return {
    {
        "hedyhli/outline.nvim",
        lazy = true,
        keys = {
            { "<LEADER>lo", mode = {"n"}, "<CMD>Outline<CR>", desc = "Outline" },
        },
        config = function()
            require("outline").setup({
                symbol_folding = {
                    autofold_depth = false,
                },
            })
        end,
    },
}
