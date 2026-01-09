return {
    diff = function(args)
        return vim.system({ "git", "diff", "--no-color", "--no-ext-diff"}, { text = true }):wait().stdout:gsub("%%", "%%%%")
    end,
    staged_diff = function(args)
        return vim.system({ "git", "diff", "--no-color", "--no-ext-diff", "--staged" }, { text = true }):wait().stdout:gsub("%%", "%%%%")
    end,
}
