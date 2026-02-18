return {
    {
        "nvim-mini/mini.nvim",
        event = "VeryLazy",
        keys = {
            { "<LEADER>F", function() MiniFiles.open() end, desc = "Mini files" },
            { "<LEADER>s", "", desc = "Surrounding/Jump" },
            { "<LEADER>S", "", desc = "Sessions" },
            { "<LEADER>Ss", function() MiniSessions.select() end, desc = "Session select" },
            { "<LEADER>Sl", function() MiniSessions.get_latest() end, desc = "Session lastest" },
            { "<LEADER>Sw", function() MiniSessions.write() end, desc = "Session write" },
            { "<LEADER>Sr", function() MiniSessions.read() end, desc = "Session read" },
            { "<LEADER>Sd", function() MiniSessions.delete() end, desc = "Session delete" },
        },
        config = function()
            require("mini.ai").setup({})
            require("mini.align").setup({})
            require('mini.bufremove').setup({})
            require("mini.comment").setup({})
            require("mini.files").setup({})
            require("mini.hipatterns").setup({
                highlighters = {
                    -- Highlight standalone 'FIXME', 'XXX', 'TODO'
                    -- XXX
                    fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
                    xxx   = { pattern = '%f[%w]()XXX()%f[%W]',   group = 'MiniHipatternsHack' },
                    -- hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
                    todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
                    -- note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

                    -- Highlight hex color strings (`#rrggbb`) using that color
                    hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
                },
            })
            require("mini.jump").setup({})
            require("mini.jump2d").setup({
                view = {
                    dim = true,
                },
                mappings = {
                    start_jumping = "<LEADER>ss",
                },
            })
            -- require("mini.map").setup({
            --     symbols = {
            --         -- encode = require("mini.map").gen_encode_symbols.block("3x2"),
            --         encode = require("mini.map").gen_encode_symbols.dot("4x2"),
            --         -- encode = require("mini.map").gen_encode_symbols.shade("2x1"),
            --     },
            --     integrations = {
            --         require("mini.map").gen_integration.builtin_search(),
            --         require("mini.map").gen_integration.diff(),
            --         require("mini.map").gen_integration.diagnostic(),
            --         require("mini.map").gen_integration.gitsigns(),
            --     },
            --     window = {
            --         winblend = 20,
            --         zindex = 100,
            --     },
            -- })
            require("mini.move").setup({})
            -- require("mini.notify").setup({
            --     lsp_progress = {
            --         enable = false,
            --     },
            --     window = {
            --         winblend = 50,
            --     },
            -- })
            -- require("mini.pairs").setup({})
            require("mini.splitjoin").setup({})
            require("mini.snippets").setup({
                snippets = {
                    -- Load custom file with global snippets first (adjust for Windows)
                    require("mini.snippets").gen_loader.from_file("~/.config/nvim/snippets/global.json"),

                    require("mini.snippets").gen_loader.from_file("~/.config/nvim/snippets/local.json"),

                    -- Load snippets based on current language by reading files from
                    -- "snippets/" subdirectories from 'runtimepath' directories.
                    require("mini.snippets").gen_loader.from_lang(),
                },
                mappings = {
                    -- Expand snippet at cursor position. Created globally in Insert mode.
                    expand = "<C-s>",
                },
            })
            require("mini.sessions").setup({
            })
            require("mini.surround").setup({
                -- Module mappings. Use `""` (empty string) to disable one.
                mappings = {
                    add            = "<LEADER>sa", -- Add surrounding in Normal and Visual modes
                    delete         = "<LEADER>sd", -- Delete surrounding
                    find           = "<LEADER>sf", -- Find surrounding (to the right)
                    find_left      = "<LEADER>sF", -- Find surrounding (to the left)
                    highlight      = "<LEADER>sh", -- Highlight surrounding
                    replace        = "<LEADER>sr", -- Replace surrounding
                    update_n_lines = "<LEADER>sn", -- Update `n_lines`
                },
            })
            require("mini.trailspace").setup({})

            vim.api.nvim_set_hl(0, "MiniJump", { bold = true, underline = true })
            vim.api.nvim_set_hl(0, "MiniJump2dSpot", { bold = true, underline = true })
            vim.api.nvim_set_hl(0, "MiniCursorword", { bold = true })
            vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { bold = true })

            -- mini.files
            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesWindowUpdate",
                callback = function(ev)
                    local state = MiniFiles.get_explorer_state() or {}

                    local win_ids = vim.tbl_map(function(t)
                        return t.win_id
                    end, state.windows or {})

                    local function idx(win_id)
                        for i, id in ipairs(win_ids) do
                            if id == win_id then return i end
                        end
                    end

                    local this_win_idx = idx(ev.data.win_id)
                    local focused_win_idx = idx(vim.api.nvim_get_current_win())

                    -- this_win_idx can be nil sometimes when opening fresh minifiles
                    if this_win_idx and focused_win_idx then
                        -- idx_offset is 0 for the currently focused window
                        local idx_offset = this_win_idx - focused_win_idx

                        -- the width of windows based on their distance from the center
                        -- i.e. center window is 60, then next over is 20, then the rest are 10.
                        -- Can use more resolution if you want like { 60, 30, 20, 15, 10, 5 }
                        local widths = { 60, 20, 10 }

                        local i = math.abs(idx_offset) + 1 -- because lua is 1-based lol
                        local win_config = vim.api.nvim_win_get_config(ev.data.win_id)
                        win_config.width = i <= #widths and widths[i] or widths[#widths]

                        local offset = 0
                        for j = 1, math.abs(idx_offset) do
                            local w = widths[j] or widths[#widths]
                            -- and an extra +2 each step to account for the border width
                            local _offset = 0.5*(w + win_config.width) + 2
                            if idx_offset > 0 then
                                offset = offset + _offset
                            elseif idx_offset < 0 then
                                offset = offset - _offset
                            end
                        end

                        win_config.height = idx_offset == 0 and 25 or 20
                        win_config.row = math.floor(0.5*(vim.o.lines - win_config.height))
                        win_config.col = math.floor(0.5*(vim.o.columns - win_config.width) + offset)
                        vim.api.nvim_win_set_config(ev.data.win_id, win_config)
                    end
                end
            })
        end
    },
}
