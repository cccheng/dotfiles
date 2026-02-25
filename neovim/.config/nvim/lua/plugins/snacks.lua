local telescope_ivy = {
    preset = "telescope_ivy",
    layout = {
        box = "vertical",
        backdrop = false,
        row = -1,
        width = 0,
        height = 0.4,
        border = "top",
        title = " {title} {live} {flags}",
        title_pos = "left",
        {
            box = "horizontal",
            { win = "list", border = "none" },
            { win = "preview", title = "{preview}", width = 0.6, border = true },
        },
        { win = "input", height = 1 },
    },
}

return {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        bigfile = {
            enabled = true,
        },
        explorer = {
            enabled = true,
        },
        indent = {
            enabled = true,
            animate = {
                style = "out",
                easing = "linear",
                duration = {
                    step = 20, -- ms per step
                    total = 250, -- maximum duration
                },
            },
            chunk = {
                enabled = true,
                char = {
                    corner_top = "╭",
                    corner_bottom = "╰",
                    arrow = "󰼛",    -- "󰐊"
                },
            },
            filter = function(buf)
                local no_indent_fts = {
                    "gitcommit",
                }
                return vim.g.snacks_indent ~= false
                    and vim.b[buf].snacks_indent ~= false
                    and vim.bo[buf].buftype == ""
                    and not vim.tbl_contains(no_indent_fts, vim.bo[buf].filetype)
            end,
        },
        input = {
            enabled = true,
            prompt_pos = "left",
      },
        notifier = {
            enabled = true,
        },
        picker = {
            layouts = {
                telescope_ivy = telescope_ivy,
            },
            layout = {
                preset = "telescope_ivy",
            },
        },
        quickfile = {
            enabled = true,
        },
        scope = {
            enabled = true,
        },
        scroll = {
            enabled = true,
        },
        styles = {
            input = {
                backdrop = true,
            },
            notification = {
                border = "top",
                wo = {
                    winblend = 20,
                },
            },
            scratch = {
                width = 120,
                height = math.floor(vim.o.lines * 0.85),
                border = "none",
            },
        },
        words = {
            enabled = true,
            modes = { "n" },
        },
    },
    keys = {
        { "<LEADER><TAB>", function() Snacks.scratch({ ft = "markdown", file = vim.fn.stdpath("data") .. "/scratch.md" }) end, desc = "Scratch" },
        { "<LEADER>t", "", desc = "Toggle" },
        { "<LEADER>p", "", desc = "Picker" },
        -- files
        { "<LEADER>f", function() Snacks.explorer({ auto_close = true, layout = { preset = "telescope_ivy", preview = true } }) end, desc = "File Explorer" },
        { "<LEADER>pf", function() Snacks.picker.files() end, desc = "Find Files" },
        { "<LEADER>ps", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
        { "<LEADER>pp", function() Snacks.picker.projects() end, desc = "Recent Projects" },
        { "<LEADER>pr", function() Snacks.picker.recent() end, desc = "Recent Files" },
        -- grep
        { "<LEADER>pg", function() Snacks.picker.grep({ hidden = true }) end, desc = "Live grep" },
        { "<LEADER>pw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
        { "<LEADER>pW", function() Snacks.picker.grep_word({ args = {} }) end, desc = "Matched word", mode = { "n", "x" } },
        -- git
        { "<LEADER>gB", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
        { "<LEADER>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
        { "<LEADER>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
        { "<LEADER>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
        { "<LEADER>gD", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
        { "<LEADER>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
        -- search
        { "<LEADER>pa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
        { "<LEADER>pb", function() Snacks.picker.buffers() end, desc = "Buffers" },
        { "<LEADER>pn", function() Snacks.picker.notifications() end, desc = "Notifications History" },
        { "<LEADER>p:", function() Snacks.picker.command_history() end, desc = "Command History" },
        { "<LEADER>ph", function() Snacks.picker.help() end, desc = "Help Pages" },
        { "<LEADER>pH", function() Snacks.picker.highlights() end, desc = "Highlights" },
        { "<LEADER>pi", function() Snacks.picker.icons({ layout = { preset = "ivy" } }) end, desc = "Icons" },
        { "<LEADER>pk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
        { "<LEADER>pd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
        { "<LEADER>pj", function() Snacks.picker.jumps() end, desc = "Jumps" },
        { "<LEADER>pq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
        { "<LEADER>pR", function() Snacks.picker.registers() end, desc = "Registers" },
        { "<LEADER>pt", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
        { "<LEADER>pm", function() Snacks.picker.marks() end, desc = "Marks" },
        { "<LEADER>pM", function() Snacks.picker.man() end, desc = "Man Pages" },
        { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference" },
        { "[[",         function() Snacks.words.jump(-vim.v.count1) end,  desc = "Prev Reference" },
    },
    config = function(_, opts)
        require("snacks").setup(opts)

        vim.api.nvim_create_autocmd("User", {
            pattern = "MiniFilesActionRename",
            callback = function(event)
                Snacks.rename.on_rename_file(event.data.from, event.data.to)
            end,
        })

        vim.api.nvim_set_hl(0, "SnacksIndentScope", { link = "IblScope" })
        vim.api.nvim_set_hl(0, "SnacksPicker", { link = "Normal" })
        vim.api.nvim_set_hl(0, "SnacksPicker", { bg = vim.g.terminal_color_0 })
        vim.api.nvim_set_hl(0, "SnacksPickerBorder", { link = "FoldColumn" })
        vim.api.nvim_set_hl(0, "SnacksPickerMatch", { link = "TelescopeMatching" })
        vim.api.nvim_set_hl(0, "SnacksPickerPrompt", { link = "TelescopePromptPrefix" })
        vim.api.nvim_set_hl(0, "SnacksPickerDir", { link = "Comment" })
        vim.api.nvim_set_hl(0, "SnacksPickerTotals", { link = "Comment" })
        vim.api.nvim_set_hl(0, "SnacksPickerBufFlags", { link = "Comment" })
        vim.api.nvim_set_hl(0, "SnacksPickerKeymapRhs", { link = "Comment" })
        vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { link = "Comment" })
        vim.api.nvim_set_hl(0, "SnacksPickerUnselected", { link = "Comment" })
        vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored", { link = "Comment" })
        vim.api.nvim_set_hl(0, "SnacksPickerGitStatusIgnored", { link = "Comment" })
        vim.api.nvim_set_hl(0, "SnacksPickerGitStatusUntracked", { link = "Comment" })
    end,
}
