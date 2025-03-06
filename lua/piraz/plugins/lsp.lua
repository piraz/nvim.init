return {
    -- Lsp plugins
    -- {
    --     "nvim-java/nvim-java",
    --     config = function()
    --         require("java").setup()
    --     end,
    -- },
    {
        "neovim/nvim-lspconfig",
        config = function ()
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(event)
                    local opts = { buffer = event.buf }
                    -- Buffer actions
                    vim.keymap.set("n", "<C-k>","<Cmd>lua vim.lsp.buf.signatre_help()<CR>", opts)
                    vim.keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
                    vim.keymap.set("n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts)
                    -- vim.keymap.set("n", "<F4>", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
                    vim.keymap.set("n", "<leader>vca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
                    vim.keymap.set("n", "<leader>vdc", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
                    -- vim.keymap.set("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
                    -- vim.keymap.del("n", "gr", opts)
                    vim.keymap.set("n", "<leader>vrf", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
                    -- vim.keymap.set("n", "<F2>", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
                    vim.keymap.set("n", "<leader>vrn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
                    vim.keymap.set("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
                    vim.keymap.set("n", "<leader>vws", "<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>", opts)

                    vim.keymap.set("n", "<leader>vdo", "<Cmd>lua vim.diagnostic.open_float()<CR>", opts)
                    vim.keymap.set("n", "[d", "<Cmd>lua vim.diagnostic.goto_next()<CR>", opts)
                    vim.keymap.set("n", "]d", "<Cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
                    vim.keymap.set("n", "<leader>vdh", "<Cmd>lua vim.diagnostic.hide()<CR>", opts)
                    vim.keymap.set("n", "<leader>vds", "<Cmd>lua vim.diagnostic.show()<CR>", opts)
                    vim.keymap.set("n", "<leader>vth", "<Cmd>lua vim.diagnostic.config({virtual_text = false})<CR>", opts)
                    vim.keymap.set("n", "<leader>vts", "<Cmd>lua vim.diagnostic.config({virtual_text = true})<CR>", opts)
                end
            })

            -- Add cmp_nvim_lsp capabilities settings to lspconfig
            -- This should be executed before you configure any language server
            local lspconfig_defaults = require("lspconfig").util.default_config
            lspconfig_defaults.capabilities = vim.tbl_deep_extend(
                "force",
                lspconfig_defaults.capabilities,
                require("cmp_nvim_lsp").default_capabilities()
            )

            vim.api.nvim_create_autocmd("VimEnter", {
                callback = function ()
                    local lspconfig = require("lspconfig")
                    -- kind of based on https://jdhao.github.io/2021/08/12/nvim_sumneko_lua_conf/
                    -- but on the diagnostics we need use also and the workspace.library is not
                    -- needed
                    lspconfig.lua_ls.setup {
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
                    }

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
                    lspconfig.intelephense.setup {
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
                    }

                    lspconfig.yamlls.setup {
                        settings = {
                            yaml = {
                                keyOrdering = false,
                            },
                        },
                    }

                    lspconfig.gopls.setup {
                        settings = {
                            gopls = {
                                env = {
                                    GOFLAGS = "-tags=integration,end2end,live,unit",
                                },
                            },
                        },
                    }

                    -- From https://stackoverflow.com/a/68998531/2887989
                    -- vim.api.nvim_set_current_dir(vim.fn.getcwd())
                    -- local project_dir = Dev.get_path(vim.fn.expand("%:p"))
                    -- log.debug(Dev.get_path(vim.fn.expand("%:p")))

                    -- log.debug(lspconfig_util.root_pattern("setup.py")() or vim.cmd("pwd"))

                    -- see :h lspconfig-root-detection
                    lspconfig.ruff.setup {
                        settings = {
                        },
                        root_dir = function() return vim.fn.getcwd() end,
                    }

                    lspconfig.rust_analyzer.setup {}

                    lspconfig.pylsp.setup {
                        settings = {
                        },
                        root_dir = function() return vim.fn.getcwd() end,
                    }

                    lspconfig.ts_ls.setup {
                        settings = {
                        },
                        root_dir = function() return vim.fn.getcwd() end,
                    }
                end,
            })
        end
    },
    -- Mason plugins
    {
        "williamboman/mason.nvim",
        dependencies = {
             { "williamboman/mason-lspconfig.nvim" },
        },
        config = function ()
            -- Servers are located at:
            --
            -- ~/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim/lua/
            -- mason-lspconfig/mappings/server.lua
            -- local lua_lsp = "lua_ls"
            require("mason").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "bashls", -- shell check should be installed manually
                    "buf_ls",
                    "gopls",
                    "intelephense",
                    "jsonls",
                    "lemminx",
                    "prosemd_lsp", -- proselint should be installed manually
                    "pylsp",
                    "lua_ls",
                    "ltex",
                    "ruff",
                    "rust_analyzer",
                    "yamlls",
                    "ts_ls",
                },
                handers = {
                    -- this first function is the "default handler"
                    -- it applies to every language server without a "custom handler"
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,
                },
            })
        end
    },
    -- Lsp Autocompletion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },     -- Required
            { "hrsh7th/cmp-buffer" },       -- Optional
            { "hrsh7th/cmp-path" },         -- Optional
            { "saadparwaiz1/cmp_luasnip" }, -- Optional
            { "hrsh7th/cmp-nvim-lua" },     -- Optional
        },
        config = function ()
            local cmp = require("cmp")
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            local cmp_mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<Tab>"] = nil,
                ["<S-Tab>"] = nil,
            })

            cmp.setup({
                completion = {
                    completeopt = "menu,menuone,preview,noselect",
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp"},
                    { name = "luasnip"},
                },{
                    { name = "buffer"},
                    { name = "path"},
                }),
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end
                },
                mapping = cmp_mapping,
            })

            vim.diagnostic.config({
                severity_sort = true
            })
        end
    },
    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        build="make install_jsregexp",
    }, -- Required
    { "rafamadriz/friendly-snippets" },
}
