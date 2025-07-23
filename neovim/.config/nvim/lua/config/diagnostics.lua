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
vim.keymap.set("n", "<LEADER>lD", function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, { desc = "Toggle diagnostics" })

vim.api.nvim_create_autocmd({"CursorHold"}, {
	group = vim.api.nvim_create_augroup("FloatDiagnostic", { clear = true }),
	callback = function()
		local wins = vim.api.nvim_list_wins()
		for _, i in ipairs(wins) do
			local win = vim.api.nvim_win_get_config(i)
			if win.zindex then
				return
			end
		end
		vim.schedule(function()
			vim.diagnostic.open_float(nil, { focus = false })
		end)
	end,
})

