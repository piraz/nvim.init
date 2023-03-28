-- This file can be loaded by calling `lua require("plugins")` from your
-- init.vim

-- Only required if you have packer configured as `opt`
vim.cmd ([[packadd packer.nvim]])

return require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    -- use("ahmedkhalf/project.nvim")


    use("github/copilot.vim")

    use ("nvim-lualine/lualine.nvim")

    use({
        "kylechui/nvim-surround",
        version = "*",
     })
    use("nvim-tree/nvim-web-devicons")
    use("nvim-treesitter/nvim-treesitter", {run = ":TSUpdate"})
    use("nvim-treesitter/playground")
    use("nvim-treesitter/nvim-treesitter-textobjects")

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use("lukas-reineke/indent-blankline.nvim")

   -- From https://youtu.be/0moS8UHupGc?t=316
    use("mfussenegger/nvim-dap")
    use("rcarriga/nvim-dap-ui")
    use("leoluz/nvim-dap-go")
    use("thehamsta/nvim-dap-virtual-text")
    use("nvim-telescope/telescope-dap.nvim")
    use("folke/neodev.nvim")
    use("fatih/vim-go")

    use({
        "EdenEast/nightfox.nvim",
        as = "nightfox",
        config = function()
            require("nightfox").setup()
            -- vim.cmd("colorscheme nightfox")
        end
    })

    use({
        "rose-pine/neovim",
        as = "rose-pine",
        config = function()
            require("rose-pine").setup()
            -- vim.cmd("colorscheme rose-pine")
        end
    })

    -- use("nvim-lua/plenary.nvim")
    use("theprimeagen/harpoon")

    use("mbbill/undotree")
    use("tpope/vim-fugitive")
    -- use("airblade/vim-gitgutter")
    -- From: https://youtu.be/yMs97o_TdBU?t=218
    use("lewis6991/gitsigns.nvim")

    -- FROM: https://youtu.be/lpQMeFph1RE?t=161
    --[[ use {
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    } ]]

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},         -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            {'hrsh7th/cmp-buffer'},       -- Optional
            {'hrsh7th/cmp-path'},         -- Optional
            {'saadparwaiz1/cmp_luasnip'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'},     -- Optional

            -- Snippets
            {'L3MON4D3/LuaSnip'},             -- Required
            {'rafamadriz/friendly-snippets'}, -- Optional
        }
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- TODO: Test todo
    use({
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup()
        end
    })

    use {
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
    }

end)

