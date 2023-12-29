-- This file can be loaded by calling `lua require("plugins")` from your
-- init.vim
local Dev = require("piraz.dev")

-- lazy.setup(
local plugins = {
    -- Themes
    { "EdenEast/nightfox.nvim" },
    { "rose-pine/neovim", name = "rose-pine" },

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

    -- Telescope
    {
        "nvim-telescope/telescope.nvim", tag = "0.1.5",
        dependencies = { "nvim-lua/plenary.nvim" }
    },

    -- Treesitter plugins
    { "nvim-tree/nvim-web-devicons" },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "nvim-treesitter/playground" },
    { "nvim-treesitter/nvim-treesitter-textobjects" },

    -- Dap plugins
    -- From https://youtu.be/0moS8UHupGc?t=316
    { "mfussenegger/nvim-dap" },
    { "rcarriga/nvim-dap-ui" },
    { "leoluz/nvim-dap-go" },
    { "thehamsta/nvim-dap-virtual-text" },
    { "nvim-telescope/telescope-dap.nvim" },
    { "folke/neodev.nvim" },
    { "fatih/vim-go" },

    -- Lsp plugins
    { "VonHeikemen/lsp-zero.nvim", branch = "v2.x" },
    { "neovim/nvim-lspconfig" },
    -- Mason plugins
    { "williamboman/mason.nvim" },           -- Optional
    { "williamboman/mason-lspconfig.nvim" }, -- Optional
    -- Lsp Autocompletion
    { "hrsh7th/nvim-cmp" },                  -- Required
    { "hrsh7th/cmp-nvim-lsp" },              -- Required
    { "hrsh7th/cmp-buffer" },                -- Optional
    { "hrsh7th/cmp-path" },                  -- Optional
    { "saadparwaiz1/cmp_luasnip" },          -- Optional
    { "hrsh7th/cmp-nvim-lua" },              -- Optional
    -- Snippets
    { "L3MON4D3/LuaSnip" },                  -- Required
    { "rafamadriz/friendly-snippets" },

    { "theprimeagen/harpoon" },

    { "mbbill/undotree" },
    { "tpope/vim-fugitive" },
    { "lewis6991/gitsigns.nvim" },

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

local chase_source = table.concat({
    Dev.USER_HOME, "source", "candango", "chase"
}, Dev.sep)

if(Dev.path_exists(chase_source)) then
    plugins[#plugins + 1] = { chase_source }
else
    plugins[#plugins + 1] = { "candango/chase.nvim" }
end

if Dev.is_linux() or Dev.is_windows() then
    plugins[#plugins + 1] = { "github/copilot.vim" }
end

require("lazy").setup(plugins)
