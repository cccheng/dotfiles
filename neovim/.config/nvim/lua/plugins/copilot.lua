return {
    {
        "github/copilot.vim",
        event = "InsertEnter",
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" },
            { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
        },
        build = "make tiktoken", -- Only on MacOS or Linux
        event = "InsertEnter",
        keys = {
            { "<LEADER>pcc", "<CMD>CopilotChatToggle<CR>", desc = "Copilot Chat" },
            { "<LEADER>pce", "<CMD>CopilotChatExplain<CR>", desc = "Explanation for the active selection", mode = { "v" } },
            { "<LEADER>pcr", "<CMD>CopilotChatReview<CR>", desc = "Review the selected code", mode = { "v" }  },
            { "<LEADER>pcf", "<CMD>CopilotChatFix<CR>", desc = "Rewrite the code with the bug fixed", mode = { "v" }  },
            { "<LEADER>pco", "<CMD>CopilotChatOptimize<CR>", desc = "Optimize the performance and readability", mode = { "v" }  },
            { "<LEADER>pcd", "<CMD>CopilotChatDocs<CR>", desc = "Add documentation comment for the selection", mode = { "v" }  },
        },
        opts = {
            -- debug = true, -- Enable debugging
            model = "claude-3.5-sonnet",
        },
    },
}
