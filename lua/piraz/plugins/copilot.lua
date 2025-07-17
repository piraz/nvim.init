if vim.fn.has("mac") == 0 then
    return {
        {
            "zbirenbaum/copilot.lua",
            cmd = "Copilot",
            event = "InsertEnter",
            config = function()
                require("copilot").setup({
                    suggestion = { enabled = false },
                    panel = { enabled = false },
                    filetypes = {
                        gitcommit = true,
                        go = true,
                        python = true,
                        sql = true,
                        html = true,
                        yaml = true,
                        xml = true,
                        ["requirements.txt"] = true,
                        ["package.json"] = true,
                        ["pyproject.toml"] = true,
                    },
                })
            end,
        },
        {
            "AndreM222/copilot-lualine"
        },
        {
            "zbirenbaum/copilot-cmp",
            config = function ()
                require("copilot_cmp").setup()
            end
        }
    }
end
return {}
