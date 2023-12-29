local Dev = require("piraz.dev")
local log = Dev.log


local loaded, dap = pcall(require, "dap")
if loaded then
    local dapgo = require("dap-go")
    local dapui = require("dapui")

    -- From https://youtu.be/0moS8UHupGc?t=625
    vim.keymap.set("n", "<F5>", function() dap.continue() end, {})
    vim.keymap.set("n", "<F6>", function() dap.disconnect() end, {})
    vim.keymap.set("n", "<F7>", function() dap.step_into() end, {})
    vim.keymap.set("n", "<F8>", function() dap.step_over() end, {})
    vim.keymap.set("n", "<F9>", function() dap.step_out() end, {})

    vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end,
        {})
    vim.keymap.set("n", "<leader>B", function()
        dap.set_breakpoint(
            vim.fn.input("Breakpoint condition: ")
        )
    end, {})
    vim.keymap.set("n", "<leader>lp", function()
        dap.set_breakpoint(
            nil,
            nil,
            vim.fn.input("Log point message: :")
        )
    end, {})
    vim.keymap.set("n", "<leader>lp", function() dap.repl.open() end, {})

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
else
    if log then
        log.debug("dap not found")
    end
end
