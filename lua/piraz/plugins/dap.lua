return {
    -- Dap plugins
    -- From https://youtu.be/0moS8UHupGc?t=316
    { "mfussenegger/nvim-dap" },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" }
    },
    { "leoluz/nvim-dap-go" },
    { "thehamsta/nvim-dap-virtual-text" },
    { "nvim-telescope/telescope-dap.nvim" },
    { "folke/neodev.nvim" },
    { "fatih/vim-go" },
}
