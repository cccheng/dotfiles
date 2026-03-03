return {
    "alex-k03/sudo-write.nvim",
    lazy = true,
    cmd = "SudoWrite",
    config = function()
        require("sudo-write").setup()
    end,
}
