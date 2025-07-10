return {
    "dhananjaylatkar/cscope_maps.nvim",
    lazy = true,
    cmd = { "Cscope" },
    ft = { "c", "cpp" },
    dependencies = {
        "folke/which-key.nvim", -- optional [for whichkey hints]
        "nvim-telescope/telescope.nvim", -- optional [for picker="telescope"]
        -- "ibhagwan/fzf-lua", -- optional [for picker="fzf-lua"]
    },
    opts = {
        skip_input_prompt = true, -- "true" doesn't ask for input
        cscope = {
            picker = "telescope", -- "telescope", "fzf-lua" or "quickfix"
            project_rooter = {
                enable = true,
            },
        },
    }
}
