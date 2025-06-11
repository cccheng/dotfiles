--- Add CodeCompanion header
local function add_codecompanion_header()
    local bufnr = vim.api.nvim_get_current_buf()
    if vim.api.nvim_buf_line_count(bufnr) <= 3 then
        local first_line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ''
        if first_line == '' or not first_line:match('# Copilot') then
            vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, { '# Copilot', '' })
            vim.api.nvim_win_set_cursor(0, { vim.api.nvim_buf_line_count(0), 0 })
        end
    end
end

-- Create an autocmd to add a header when entering the buffer for the first time.
-- This ensures that the `foldexpr` for markdown works correctly.
vim.api.nvim_create_autocmd('BufEnter', {
    buffer = 0,
    once = true,
    callback = function()
        -- Defer adding the header to allow CodeCompanion to set up the buffer after its creation,
        -- preventing the header from being overwritten.
        vim.defer_fn(add_codecompanion_header, 250)
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end,
})

