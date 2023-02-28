local lsp = require("lsp-zero")
local neodev = require("neodev")
-- local lspconfig = require("lspconfig")
local lspconfig_util = require("lspconfig.util")
-- local dev = require("piraz.dev")
-- local log = dev.log

-- See: https://github.com/folke/neodev.nvim
-- Als: https://github.com/rcarriga/nvim-dap-ui
neodev.setup({
    library = { plugins = {"nvim-dap-ui", types = true}}
})

lsp.preset("recommended")

-- Servers are located at:
--
-- ~/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim/lua/
-- mason-lspconfig/mappings/server.lua
-- local lua_lsp = "lua_ls"

lsp.ensure_installed({
    "bashls", -- shell check should be installed manually
    "gopls",
    "intelephense",
    "jsonls",
    "lemminx",
    "prosemd_lsp", -- proselint should be installed manually 
    "pylsp",
    "lua_ls",
    "ruff_lsp",
    "tsserver",
})

local cmp = require("cmp")
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

-- kind of based on https://jdhao.github.io/2021/08/12/nvim_sumneko_lua_conf/
-- but on the diagnostics we need use also and the workspace.library is not
-- needed
-- lsp.configure("lua_ls",{
--     settings = {
--         Lua = {
--             -- runtime = {
--             --     -- Tell the language server which version of Lua you're using
--             --     -- (most likely LuaJIT in the case of Neovim)
--             --     version = "LuaJIT",
--             -- },
--             diagnostics = {
--                 -- Get the language server to recognize the `vim` global
--                 globals = {"vim", "use" },
--             },
--             -- workspace = {
--             --     -- Make the server aware of Neovim runtime files
--             --     library = vim.api.nvim_get_runtime_file("", true),
--             --
--             --     workspace = {
--             --         checkThirdParty = false,
--             --     },
--             -- },
--             -- Do not send telemetry data containing a randomized but unique
--             -- identifier
--             telemetry = {
--                 enable = false,
--             },
--         },
--         -- root_dir = lspconfig_util.root_pattern(
--         -- ".luarc.json", ".luarc.jsonc", ".luacheckrc",
--         -- ".stylua.toml", "stylua.toml", "selene.toml",
--         -- "selene.yml", ".git"
--         -- )
--     }
-- })
lsp.nvim_workspace()

lsp.configure("intelephense", {
    settings = {
        intelephense = {
            environment = {
                includePaths = {
                    ".",
                    "/usr/share/pear",
                    "/usr/share/php",
                    "/home/fpiraz/source/candango",
                },
            }
        }
    }
})

-- From https://stackoverflow.com/a/68998531/2887989
-- vim.api.nvim_set_current_dir(vim.fn.getcwd())
-- local project_dir = Dev.get_path(vim.fn.expand("%:p"))
-- log.debug(Dev.get_path(vim.fn.expand("%:p")))

-- lsp.ruff_lsp.setup {
--     root_dir = lspconfig_util.root_pattern(".git")
-- }

-- log.debug(lspconfig_util.root_pattern("setup.py")() or vim.cmd("pwd"))

-- see :h lspconfig-root-detection
lsp.configure("ruff_lsp",{
    settings = {
    },
    root_dir = function() return vim.fn.getcwd() end,
})

lsp.configure("pylsp",{
    settings = {
    },
    root_dir = function() return vim.fn.getcwd() end,
})

lsp.set_preferences({
    sign_icons = {}
})

lsp.setup_nvim_cmp({
   mapping = cmp_mappings
})

-- lsp.on_lsp_ready(function(client, bufnr)
-- end)


lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}
    -- if client.name == "ruff_lsp" then
    --     print(vim.inspect(client))
    -- end

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws",
    function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd",
    function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca",
    function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr",
    function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn",
    function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<C-h>",
    function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

-- vim.diagnostic.config({
--     virtual_text = true
-- })

-- lspconfig.ruff_lsp.setup{
--     on_attach = function(client, bufnr)
--         client.config.single_file_support = false
--         client.root_dir = "/home/fpiraz/source/candango/etcdpy"
--         --  client.root_dir = lspconfig.root_pattern(
--         --      "pyproject.toml", ".git"
--         --  )
--         log.warn(vim.inspect(client))
--     end,
-- }

--[[ require("mason").setup()
local mason_lspconfig = require("mason-lspconfig")

local lspconfig = require("lspconfig")

-- From:
-- https://bit.ly/3lKGICj
lspconfig.sumneko_lua.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = {"vim", "use"},
            },
        },
    },
})

mason_lspconfig.setup ({
    "ruff", "sumneko_lua"
}) ]]

