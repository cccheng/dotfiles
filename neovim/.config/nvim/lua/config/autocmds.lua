
-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Show cursor line only in active window
vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
    callback = function(event)
        if vim.bo[event.buf].buftype == '' then
            vim.opt_local.cursorline = true
        end
    end,
})
vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
    callback = function()
        vim.opt_local.cursorline = false
    end,
})


-- relative line numbers in normal mode
-- absolute line numbers in insert/command mode
local numbertoggle = vim.api.nvim_create_augroup("numbertoggle", {})
vim.api.nvim_create_autocmd(
{
    "BufEnter", "FocusGained", "InsertLeave", "WinEnter", "CmdlineLeave"
},
{
    group = numbertoggle,
    callback = function()
        if vim.opt.number and vim.api.nvim_get_mode() ~= "i" then
            vim.opt.relativenumber = true
        end
    end,
}
)

vim.api.nvim_create_autocmd(
{
    "BufLeave", "FocusLost", "InsertEnter", "WinLeave", "CmdlineEnter"
},
{
    group = numbertoggle,
    callback = function()
        if vim.opt.number then
            vim.opt.relativenumber = false
            vim.cmd("redraw")
        end
    end,
}
)
