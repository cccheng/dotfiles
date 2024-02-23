return {
    {
        "uga-rosa/translate.nvim",
        event = "BufReadPre",
        config = function()
            vim.keymap.set("n", "<leader>gt", "<cmd>Translate ZH-TW<cr>", { desc = "Translate" })
        end,
    },
}
