return {
    {
        "hedyhli/outline.nvim",
        event = "BufReadPre",
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
