return {
    {
        "nvim-lualine/lualine.nvim",
        config = function ()
            local theme = require("lualine.themes.onedark")

            require("lualine").setup {
                options = {
                    icons_enabled = true,
                    theme = theme,
                    component_separators = { left = "\\", right = "\\"},
                    section_separators = { left = "", right = ""},
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    }
                },
                sections = {
                    lualine_a = {"mode"},
                    lualine_b = {"branch", "diff", "diagnostics"},
                    lualine_c = {{"filename", path = 3}},
                    lualine_x = {"copilot", "encoding", "fileformat", "filetype"},
                    lualine_y = {"progress"},
                    lualine_z = {"location"}
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {"filename"},
                    lualine_x = {"location"},
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {}
            }
        end
    },
}
