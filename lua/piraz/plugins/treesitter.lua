return {
    -- Treesitter plugins
    { "nvim-tree/nvim-web-devicons" },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function ()
            local treesitter = require("nvim-treesitter")

            treesitter.setup({
                install_dir = vim.fn.stdpath("data") .. "/site",
            })

            treesitter.install({
                "c",
                "go",
                -- "help",
                "java",
                "javascript",
                "jsdoc",
                "lua",
                "luadoc",
                "python",
                "php",
                "sql",
                "vim",
                "vimdoc",
                "typescript",
            })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "c",
                    "go",
                    "java",
                    "javascript",
                    "jsdoc",
                    "lua",
                    "markdown",
                    "php",
                    "python",
                    "sql",
                    "typescript",
                    "vim",
                    "vimdoc",
                },
                callback = function(args)
                    vim.treesitter.start(args.buf)
                end,
            })
        end
    },
}
