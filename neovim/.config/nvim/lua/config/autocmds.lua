
-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Show cursor line only in active window
vim.api.nvim_create_autocmd({"InsertLeave", "WinEnter"}, {
    callback = function(event)
        if vim.bo[event.buf].buftype == "" then
            vim.opt_local.cursorline = true
        end
    end,
})
vim.api.nvim_create_autocmd({"InsertEnter", "WinLeave"}, {
    callback = function()
        vim.opt_local.cursorline = false
    end,
})

-- toggle relative number on the basis of mode
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
    pattern = "*",
    callback = function()
        if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
            vim.opt.relativenumber = true
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
    pattern = "*",
    callback = function()
        if vim.o.nu then
            vim.opt.relativenumber = false
            vim.cmd "redraw"
        end
    end,
})
