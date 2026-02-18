
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

vim.api.nvim_create_autocmd("BufWinEnter", {
    desc = "Move help window to the right when opened",
    group = vim.api.nvim_create_augroup("HelpWindowRight", { clear = true }),
    pattern = { "*.txt", "*.md" },
    callback = function()
        if vim.o.filetype == "help" then
            vim.cmd.winc("L")
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "close some filetypes with <q>",
    group = vim.api.nvim_create_augroup("CloseWithQ", { clear = true }),
    pattern = {
        "man",
        "qf",
        "help",
        "checkhealth",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.schedule(function()
            vim.keymap.set("n", "q", function()
                vim.cmd("quit")
                pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
            end, {
            buffer = event.buf,
            silent = true,
            desc = "Quit buffer",
        })
    end)
end,
})

