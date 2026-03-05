vim.diagnostic.config({
    virtual_text = {
        virt_text_pos = "eol_right_align",  -- 'eol'|'eol_right_align'|'inline'|'overlay'|'right_align'
        hl_mode = "combine",                -- 'replace'|'combine'|'blend'
    },
    virtual_lines = false,
    -- virtual_lines = {
    --     severity = {
    --         min = vim.diagnostic.severity.ERROR,
    --     }
    -- },
    underline = false,
    update_in_insert = false,
    severity_sort = true,
    float = {
        scope = "cursor",                   -- 'line'|'buffer'|'cursor'|'c'|'l'|'b'
        border = "rounded",
        source = true,
        style = "minimal",
        focusable = false,
    },
    signs = {
        priority = 100,
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚",  --  , 󰅚
            [vim.diagnostic.severity.WARN] = "",    --  , 󰀪
            [vim.diagnostic.severity.INFO] = "",    --  , 󰋽
            [vim.diagnostic.severity.HINT] = "",    -- 󰠠 , 󰌶
        },
        -- linehl = {
        --     [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
        --     [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
        --     [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
        --     [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
        -- },
        -- numhl = {
        --     [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
        --     [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
        --     [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
        --     [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
        -- },
    }
})

vim.keymap.set("n", "[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity["ERROR"] }) end, { desc = "Previous error" })
vim.keymap.set("n", "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity["ERROR"] }) end, { desc = "Next error" })
vim.keymap.set("n", "[w", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity["WARN"] }) end, { desc = "Previous warning" })
vim.keymap.set("n", "]w", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity["WARN"] }) end, { desc = "Next warning" })
vim.keymap.set("n", "<LEADER>lf", function() vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
end, { desc = "Show diagnostics" })

-- vim.api.nvim_create_autocmd({"CursorHold"}, {
-- 	group = vim.api.nvim_create_augroup("FloatDiagnostic", { clear = true }),
-- 	callback = function()
--         -- ignore special buffers
--         if vim.bo.buftype ~= "" then return end
--
--         -- don't open if any floating window already exists
--         for _, w in ipairs(vim.api.nvim_list_wins()) do
--             local cfg = vim.api.nvim_win_get_config(w)
--             if cfg and (cfg.relative ~= "" and cfg.relative ~= nil or cfg.zindex) then
--                 return
--             end
--         end
--
--         -- schedule to avoid race conditions with other handlers
--         vim.schedule(function()
--             if not vim.api.nvim_buf_is_valid(0) then return end
--             -- open diagnostics at cursor without stealing focus
--             vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
--         end)
-- 	end,
-- })

