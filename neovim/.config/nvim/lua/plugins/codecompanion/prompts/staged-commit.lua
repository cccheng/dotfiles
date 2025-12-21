return {
    diff = function(args)
        return vim.system({ "git", "diff", "--no-color", "--no-ext-diff", "--staged" }, { text = true }):wait().stdout
    end,
}
