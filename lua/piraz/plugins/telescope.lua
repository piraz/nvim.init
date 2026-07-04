return {
    -- Telescope
    {
        "nvim-telescope/telescope.nvim", tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },
        config = function ()
            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Open Buffers" })
            vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find LSP diagnostics" })
            vim.keymap.set("n", "<leader>fc", builtin.colorscheme, { desc = "Find Color Schemes" })
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Project Files" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help Tags" })
            vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find Keymaps" })
            vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "Quickfix List" })
            vim.keymap.set("n", "<leader>gr", builtin.lsp_references, {})
            vim.keymap.set("n", "<leader>fs", builtin.grep_string, { desc = "Grep String" })

            -- Filtered diagnostics keymaps
            vim.keymap.set("n", "<leader>fe", function()
                builtin.diagnostics({
                    severity = vim.diagnostic.severity.ERROR,
                })
            end, { desc = "Find LSP errors" })

            vim.keymap.set("n", "<leader>fw", function()
                builtin.diagnostics({
                    severity = vim.diagnostic.severity.WARN,
                })
            end, { desc = "Find LSP warnings" })

            vim.keymap.set("n", "<leader>fi", function()
                builtin.diagnostics({
                    severity = {
                        vim.diagnostic.severity.INFO,
                        vim.diagnostic.severity.HINT,
                    },
                })
            end, { desc = "Find LSP info and hints" })

            -- List only unsaved buffers
            vim.keymap.set("n", "<leader>fm", function()
                local pickers = require("telescope.pickers")
                local finders = require("telescope.finders")
                local conf = require("telescope.config").values
                local actions = require("telescope.actions")
                local action_state = require("telescope.actions.state")

                local bufs = vim.tbl_filter(function(buf)
                    return vim.bo[buf].buflisted and vim.bo[buf].modified
                end, vim.api.nvim_list_bufs())

                pickers.new({}, {
                    prompt_title = "Modified buffers",
                    finder = finders.new_table({
                        results = bufs,
                        entry_maker = function(buf)
                            local name = vim.api.nvim_buf_get_name(buf)
                            local display = vim.fn.fnamemodify(name, ":~:.")
                            return {
                                value = buf,
                                display = display,
                                ordinal = display,
                            }
                        end,
                    }),
                    sorter = conf.generic_sorter({}),
                    attach_mappings = function(prompt_bufnr)
                        actions.select_default:replace(function()
                            local entry = action_state.get_selected_entry()
                            actions.close(prompt_bufnr)
                            vim.api.nvim_set_current_buf(entry.value)
                        end)
                        return true
                    end,
                }):find()
            end, {})

            vim.keymap.set("n", "<leader>gb", builtin.git_bcommits, {})
            vim.keymap.set("n", "<leader>gh", builtin.git_commits, {})
            vim.keymap.set("n", "<leader>gs", builtin.git_status, {})
        end
    },
}
