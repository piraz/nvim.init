if vim.fn.has("mac") == 0 then
    return {
        {
            "zbirenbaum/copilot.lua",
            cmd = "Copilot",
            event = "InsertEnter",
            config = function()
                require("copilot").setup({
                    filetypes = {
                        gitcommit = true,
                        go = true,
                        python = true,
                        sql = true,
                        html = true,
                        yaml = true,
                        xml = true,
                        javascript = true,
                        typescript = true,
                        netrw = false,
                        ["requirements.txt"] = true,
                        ["package.json"] = true,
                        ["pyproject.toml"] = true,
                    },
                    logger = {
                        print_log_level = vim.log.levels.OFF,
                    },
                    auto_trigger = true,
                    -- panel = { enabled = false },
                    suggestion = {
                        eanbled = true,
                        keymap = {
                             accept = "<M-a>"
                        },
                    },
                })
                -- vim.cmd([[Copilot disable]])
                -- vim.defer_fn( function ()
                --     vim.cmd([[Copilot enable]])
                -- end, 100)
            end,
            dependencies = {
                "AndreM222/copilot-lualine",
            },
        },
        {
            "zbirenbaum/copilot-cmp",
            config = function ()
                require("copilot_cmp").setup()
            end
        },
    }
end
return {}
