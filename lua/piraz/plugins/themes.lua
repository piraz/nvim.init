return {
    -- Themes
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false,
        priority = 1000,
        dependencies = {
            { "EdenEast/nightfox.nvim" },
        },
        config = function()
            -- for more color schemes, see: https://vimcolorschemes.com/
            -- See:
            -- :help hi
            -- :so $VIMRUNTIME/syntax/hitest.vim
            -- DiffAdd           DiffAdd TelescopeResultsDiffAdd diffAdded GitSignsAddLn
            --     GitSignsUntrackedLn GitSignsAddPreview
            -- DiffChange        DiffChange TelescopeResultsDiffChange diffChanged
            --     netrwLib netrwMakefile GitSignsChangeLn GitSignsChangedeleteLn
            -- DiffDelete        DiffDelete TelescopeResultsDiffDelete diffRemoved
            --     GitSignsDeletePreview GitSignsDeleteVirtLn
            -- DiffText          DiffText

            function ColorMyPencils(color)
                -- color = color or "rose-pine"
                color = color or "nightfox"
                vim.cmd.colorscheme(color)

                vim.api.nvim_set_hl(0, "GitSignsAdd", { bg = "none", fg = "#9ccfd8" })
                vim.api.nvim_set_hl(0, "GitSignsChange", { bg = "none", fg = "#ebbcba" })
                vim.api.nvim_set_hl(0, "GitSignsDelete", { bg = "none", fg = "#eb6f92" })
                vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
                -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
                vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
                vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
                vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "none" })
                vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
                -- Fix Gitsign black SignColumn
                vim.api.nvim_set_hl(0, "SignColumn", {bg = "none"})
                vim.api.nvim_set_hl(0, "ColorColumn", {bg = "#403d52"})
            end

            vim.keymap.set("n", "<leader>sht", "<Cmd>:so $VIMRUNTIME/syntax/hitest.vim<CR>")

            ColorMyPencils("rose-pine")
        end,
    },
}
