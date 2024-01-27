return {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local tc = require("todo-comments")

        tc.setup({})
        vim.keymap.set("n", "]t", tc.jump_next, { desc = "Next todo comment" })
        vim.keymap.set("n", "[t", tc.jump_prev, { desc = "Next todo comment" })
        vim.keymap.set("n", "<leader>tt", "<cmd>TodoTelescope<cr>", { desc = "Find Todo" })
    end
}

