return {
    {
        "hedyhli/outline.nvim",
        event = "BufReadPre",
        keys = {
            { "<LEADER>o", mode = {"n"}, "<CMD>Outline<CR>", desc = "Outline" },
        },
        config = function()
            require("outline").setup({
            })
        end,
    },
}
