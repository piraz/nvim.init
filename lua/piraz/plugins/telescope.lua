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

            vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
            vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})
            vim.keymap.set("n", "<leader>fc", builtin.colorscheme, {})
            vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
            vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})
            vim.keymap.set("n", "<leader>fq", builtin.quickfix, {})
            vim.keymap.set("n", "<leader>gr", builtin.lsp_references, {})
            vim.keymap.set("n", "<leader>fs", builtin.grep_string, {})

            vim.keymap.set("n", "<leader>gb", builtin.git_bcommits, {})
            vim.keymap.set("n", "<leader>gh", builtin.git_commits, {})
            vim.keymap.set("n", "<leader>gs", builtin.git_status, {})
        end
    },
}
