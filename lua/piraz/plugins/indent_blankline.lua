return {
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function ()
            require("ibl").setup()
            vim.keymap.set("n", "<leader>ii", "<cmd>IBLToggle<CR>")
            vim.api.nvim_create_autocmd("VimEnter", {
                callback = function ()
                    vim.cmd("IBLDisable")
                end,
            })
        end
    },
}
