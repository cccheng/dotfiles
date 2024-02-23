return {
    {
        "hedyhli/outline.nvim",
        event = "BufReadPre",
        config = function()
            vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Outline" })

            require("outline").setup({
            })
        end,
    },
}
