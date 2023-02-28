-- for more color schemes, see: https://vimcolorschemes.com/

function ColorMyPencils(color)
    -- color = color or "rose-pine"
    color = color or "nightfox"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    -- Fix Gitsign black SignColumn
    vim.api.nvim_set_hl(0, "SignColumn", {bg = "none"})
end

ColorMyPencils("rose-pine")
