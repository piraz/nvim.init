return {
    -- Dap plugins
    -- From https://youtu.be/0moS8UHupGc?t=316
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            { "nvim-telescope/telescope-dap.nvim" },
            { "folke/lazydev.nvim" },
        },
        config = function ()
            local dap = require("dap")
            -- neodev is going AOL
            -- SEE: https://github.com/nvim-neotest/neotest/issues/417#issue-2334008121
            local lazydev = require("lazydev")

            -- See: https://github.com/folke/neodev.nvim
            -- Als: https://github.com/rcarriga/nvim-dap-ui
            lazydev.setup({
                library = { plugins = { "nvim-dap-ui" } }
            })

            -- From https://youtu.be/0moS8UHupGc?t=625
            vim.keymap.set("n", "<F5>", function() dap.continue() end, {})
            vim.keymap.set("n", "<F6>", function() dap.disconnect() end, {})
            vim.keymap.set("n", "<F7>", function() dap.step_into() end, {})
            vim.keymap.set("n", "<F8>", function() dap.step_over() end, {})
            vim.keymap.set("n", "<F9>", function() dap.step_out() end, {})

            vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end, {})
            vim.keymap.set("n", "<leader>B", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, {})
            vim.keymap.set("n", "<leader>lp", function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message:")) end, {})
            vim.keymap.set("n", "<leader>lp", function() dap.repl.open() end, {})
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        config = function ()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
            vim.keymap.set("n", "<leader>dc", function() dapui.close() end, {})
            vim.keymap.set("n", "<leader>de", function() dapui.eval() end, {})
            vim.keymap.set("n", "<leader>do", function() dapui.open() end, {})
        end
    },
    {
        "leoluz/nvim-dap-go",
        config = function ()
            local dapgo = require("dap-go")
            dapgo.setup {
                -- Additional dap configurations can be added.
                -- dap_configurations accepts a list of tables where each entry
                -- represents a dap configuration. For more details do:
                -- :help dap-configuration
                dap_configurations = {
                    {
                        -- Must be "go" or it will be ignored by the plugin
                        type = "go",
                        name = "Attach Remote",
                        mode = "remote",
                        request = "attach",
                    },
                },
                -- delve configurations
                delve = {
                    -- time to wait for delve to initialize the debug session.
                    -- default to 20 seconds
                    initialize_timeout_sec = 20,
                    -- a string that defines the port to start delve debugger.
                    -- default to string "${port}" which instructs nvim-dap
                    -- to start the process in a random available port
                    port = "${port}"
                },
            }
        end
    },
    {
        "thehamsta/nvim-dap-virtual-text",
        config = function ()
            require("nvim-dap-virtual-text").setup()
        end
    },
}
