
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd({"InsertLeave", "WinEnter"}, {
    desc = "Show cursor line only in active window",
    group = vim.api.nvim_create_augroup("ActiveWinCursor", { clear = true }),
    callback = function(event)
        if vim.bo[event.buf].buftype == "" then
            vim.opt_local.cursorline = true
        end
    end,
})
vim.api.nvim_create_autocmd({"InsertEnter", "WinLeave"}, {
    desc = "Show cursor line only in active window",
    group = vim.api.nvim_create_augroup("ActiveWinCursor", { clear = true }),
    callback = function()
        vim.opt_local.cursorline = false
    end,
})

