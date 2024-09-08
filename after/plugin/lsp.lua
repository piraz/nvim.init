local Dev = require("piraz.dev")
local log = Dev.log

local loaded, lsp = pcall(require, "lsp-zero")

if loaded then
    local neodev = require("neodev")
    -- local lspconfig = require("lspconfig")
    local lspconfig_util = require("lspconfig.util")
    -- local dev = require("piraz.dev")
    -- local log = dev.log

    -- See: https://github.com/folke/neodev.nvim
    -- Als: https://github.com/rcarriga/nvim-dap-ui
    neodev.setup({
        library = { plugins = { "nvim-dap-ui", types = true } }
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
        "ltex",
        "ruff_lsp",
        "yamlls",
        "tsserver",
    })

    local cmp = require("cmp")
    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    local cmp_mappings = lsp.defaults.cmp_mappings({
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    })

    cmp_mappings["<Tab>"] = nil
    cmp_mappings["<S-Tab>"] = nil
    lsp.defaults.cmp_snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end
    }

    lsp.defaults.cmp_sources({
        { name = "nvim_lsp"},
        { name = "luasnip"},
    },{
        { name = "buffer"},
    })

    -- kind of based on https://jdhao.github.io/2021/08/12/nvim_sumneko_lua_conf/
    -- but on the diagnostics we need use also and the workspace.library is not
    -- needed
    lsp.configure("lua_ls",{
        settings = {
            Lua = {
                runtime = { version = "Lua 5.1" },
                -- diagnostics = {
                --     -- Get the language server to recognize the `vim` global
                --     -- globals = { "bit", "vim", "it", "use", "describe",
                --     --     "after_each", "before_each" },
                -- },
                workspace = {
                    library = {
                        "${3rd}/busted/library",
                        "${3rd}/luassert/library",
                    },
                },
            },
        }
    })

    local intelephense_includes_file = vim.fs.joinpath(
        vim.fn.expand("~"),
        ".intelephense_extra_includes"
    )
    local include_paths = {
        ".",
        vim.fn.getcwd(),
        "/usr/share/pear",
        "/usr/share/php",
    }
    if vim.fn.filereadable(intelephense_includes_file) == 1 then
        local lines = vim.fn.readfile(intelephense_includes_file)
        for _, line in ipairs(lines) do
            include_paths[#include_paths+1] = line
        end
    end
    lsp.configure("intelephense", {
        settings = {
            intelephense = {
                environment = {
                    documentRoot = vim.fn.getcwd(),
                    includePaths = include_paths,
                },
                files = {
                    associations = {
                        "*.php",
                        "*.phtml",
                        "*.inc", -- <=== BOOOOOiiii that was distrubing....
                    }
                },
                -- maxMemory = 4000,
                -- trace = {
                --     server = "verbose",
                -- },
            },
        },
    })

    lsp.configure("yamlls", {
        settings = {
            yaml = {
                keyOrdering = false,
            },
        },
    })

    lsp.configure("gopls", {
        settings = {
            gopls = {
                env = {
                    GOFLAGS = "-tags=integration,end2end,live,unit",
                },
            },
        },
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
    lsp.configure("ruff_lsp", {
        settings = {
        },
        root_dir = function() return vim.fn.getcwd() end,
    })

    lsp.configure("pylsp", {
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
        local opts = { buffer = bufnr, remap = false }
        -- if client.name == "ruff_lsp" then
        --     print(vim.inspect(client))
        -- end

        -- Buffer actions
        vim.keymap.set("n", "<C-k>",
            "<Cmd>lua vim.lsp.buf.signatre_help()<CR>", opts)
        vim.keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>",
            opts)
        vim.keymap.set("n", "<leader>vim",
            "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        -- vim.keymap.set("n", "<F4>",
        --    "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
        vim.keymap.set("n", "<leader>vca",
            "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
        vim.keymap.set("n", "<leader>vdc",
            "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
        vim.keymap.set("n", "<leader>vdf",
            "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
        -- vim.keymap.set("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>",
        --     opts)
        vim.keymap.del("n", "gr", opts)
        vim.keymap.set("n", "<leader>vrf",
            "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
        -- vim.keymap.set("n", "<F2>", "<Cmd>lua vim.lsp.buf.rename()<CR>",
        --     opts)
        vim.keymap.set("n", "<leader>vrn",
            "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
        vim.keymap.set("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
        vim.keymap.set("n", "<leader>vws",
            "<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>", opts)

        vim.keymap.set("n", "<leader>vdo",
            "<Cmd>lua vim.diagnostic.open_float()<CR>", opts)
        vim.keymap.set("n", "[d", "<Cmd>lua vim.diagnostic.goto_next()<CR>",
            opts)
        vim.keymap.set("n", "]d", "<Cmd>lua vim.diagnostic.goto_prev()<CR>",
            opts)
        vim.keymap.set("n", "<leader>vdh",
            "<Cmd>lua vim.diagnostic.hide()<CR>", opts)
        vim.keymap.set("n", "<leader>vds",
            "<Cmd>lua vim.diagnostic.show()<CR>", opts)
        vim.keymap.set("n", "<leader>vth",
            "<Cmd>lua vim.diagnostic.config({virtual_text = false})<CR>", opts)
        vim.keymap.set("n", "<leader>vts",
            "<Cmd>lua vim.diagnostic.config({virtual_text = true})<CR>", opts)
    end)

    lsp.setup()

    vim.diagnostic.config({
        virtual_text = false,
        severity_sort = true
    })

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
else
    if log then
        log.debug("lsp-zero not found")
    end
end
