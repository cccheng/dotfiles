return {
    {
        "akinsho/toggleterm.nvim",
        event = "VeryLazy",
        config = function()
            require("toggleterm").setup({
                open_mapping = "<leader>`",
            })

            vim.keymap.set("t", "<leader><esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
        end
    },
}
