return {
    { "lukas-reineke/indent-blankline.nvim" },
    {
        "kylechui/nvim-surround",
        version = "*",
    },
    {
        "numToStr/Comment.nvim",
        opts = {
            -- add any options here
        },
        lazy = false,
    },
    { "nvim-lualine/lualine.nvim" },
    {
        "theprimeagen/harpoon",  branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    { "mbbill/undotree" },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
    { "raimon49/requirements.txt.vim" },
}
