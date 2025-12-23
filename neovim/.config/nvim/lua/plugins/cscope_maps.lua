return {
    "dhananjaylatkar/cscope_maps.nvim",
    lazy = true,
    cmd = { "Cscope" },
    ft = { "c", "cpp" },
    dependencies = {
        "folke/which-key.nvim", -- optional [for whichkey hints]
        -- "nvim-telescope/telescope.nvim", -- optional [for picker="telescope"]
        -- "ibhagwan/fzf-lua", -- optional [for picker="fzf-lua"]
        -- "echasnovski/mini.pick", -- optional [for picker="mini-pick"]
        "folke/snacks.nvim", -- optional [for picker="snacks"]
    },
        keys = {
            { "<LEADER>c", "", desc = "Cscope" },
        },
    opts = {
        skip_input_prompt = true, -- "true" doesn't ask for input
        cscope = {
            picker = "snacks", -- "quickfix", "location", "telescope", "fzf-lua", "mini-pick" or "snacks"
            project_rooter = {
                enable = true,
            },
        },
    }
}
