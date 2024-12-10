return {
    -- Lsp plugins
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
    {
        "L3MON4D3/LuaSnip",
        build="make install_jsregexp"
    }, -- Required
    { "rafamadriz/friendly-snippets" },
}
