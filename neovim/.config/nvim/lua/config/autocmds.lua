
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd({"WinEnter", "BufEnter"}, {
    desc = "Show cursor line only in active window",
    group = vim.api.nvim_create_augroup("ActiveWinCursor", { clear = false }),
    callback = function(event)
        if vim.bo[event.buf].buftype == "" then
            vim.opt_local.cursorline = true
        end
    end,
})
vim.api.nvim_create_autocmd({"WinLeave", "BufLeave"}, {
    desc = "Show cursor line only in active window",
    group = vim.api.nvim_create_augroup("ActiveWinCursor", { clear = false }),
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

vim.api.nvim_create_autocmd("BufNewFile", {
    desc = "If one exists, use a template when opening a new file",
    group = vim.api.nvim_create_augroup("NewFileTemplate", { clear = true }),
    callback = function()
        local template_dir = vim.env.XDG_TEMPLATE_DIR or (vim.env.XDG_DATA_HOME .. "/templates")
        local ext = vim.fn.expand("%:e")
        local template = template_dir .. "/skeleton." .. ext
        if vim.fn.filereadable(template) == 1 then
            vim.cmd("0r " .. template)
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
        "gitsigns-blame",
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

