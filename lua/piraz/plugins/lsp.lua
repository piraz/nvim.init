return {
    -- Lsp plugins
    -- {
    --     "nvim-java/nvim-java",
    --     config = function()
    --         require("java").setup()
    --         vim.lsp.enable("jdtls")
    --     end,
    -- },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "mason-org/mason.nvim" },
            { "mason-org/mason-lspconfig.nvim" },
        },
        config = function ()
            -- Servers are located at:
            --
            -- ~/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim/lua/
            -- mason-lspconfig/mappings/server.lua
            -- local lua_lsp = "lua_ls"
            require("mason").setup()
            require("mason-lspconfig").setup({
                automatic_enable = false,
                ensure_installed = {
                    "bashls", -- shell check should be installed manually
                    "buf_ls",
                    "clangd",
                    "gopls",
                    "intelephense",
                    "jdtls",
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
                }
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(event)
                    -- Return a table with description and the event buffer
                    local get_opts = function (desc)
                        return {
                            desc = desc,
                            buffer = event.buf,
                        }
                    end
                    -- Buffer actions
                    vim.keymap.set("n", "<C-k>",function () vim.lsp.buf.signature_help() end, get_opts("Signature help"))
                    vim.keymap.set("n", "gd", function () vim.lsp.buf.definition() end, get_opts("Go to definition"))
                    vim.keymap.set("n", "gi", function () vim.lsp.buf.implementation() end, get_opts("Go to implementation"))
                    -- vim.keymap.set("n", "<F4>", function () vim.lsp.buf.code_action() end, opts)
                    vim.keymap.set("n", "<leader>vca", function () vim.lsp.buf.code_action() end, get_opts("Code action"))
                    vim.keymap.set("n", "<leader>vdc", function () vim.lsp.buf.declaration() end, get_opts("Go to declaration"))
                    -- vim.keymap.set("n", "gr", function () vim.lsp.buf.references() end, opts)
                    -- vim.keymap.del("n", "gr", opts)
                    vim.keymap.set("n", "<leader>vrf", function () vim.lsp.buf.references() end, get_opts("Find references"))
                    vim.keymap.set("n", "<leader>vrn", function () vim.lsp.buf.rename() end, get_opts("Rename symbol"))
                    vim.keymap.set("n", "K", function () vim.lsp.buf.hover() end, get_opts("Hover documentation"))
                    vim.keymap.set("n", "<leader>vws", function () vim.lsp.buf.workspace_symbol() end, get_opts("Search workspace symbols"))

                    vim.keymap.set("n", "<leader>vdo", function () vim.diagnostic.open_float() end, get_opts("Open diagnostics in float window"))
                    vim.keymap.set("n", "[d",function () vim.diagnostic.jump({ count = -1}) end, get_opts("Jump to previous diagnostic"))
                    vim.keymap.set("n", "]d",function () vim.diagnostic.jump({ count = 1}) end, get_opts("Jump to next diagnostic"))
                    vim.keymap.set("n", "<leader>vdh", function () vim.diagnostic.hide() end, get_opts("Hides diagnostics"))
                    vim.keymap.set("n", "<leader>vds", function () vim.diagnostic.show() end, get_opts("Shows diagnostics"))
                    vim.keymap.set("n", "<leader>vth", function () vim.diagnostic.config({virtual_text = false}) end, get_opts("Disable virtual text diagnostics"))
                    vim.keymap.set("n", "<leader>vts", function () vim.diagnostic.config({virtual_text = true}) end, get_opts("Enable virtual text diagnostics"))
                end
            })

            vim.api.nvim_create_autocmd("VimEnter", {
                callback = function ()
                    -- local lspconfig = require("lspconfig")
                    local capabilities = vim.tbl_deep_extend(
                        "force",
                        vim.lsp.protocol.make_client_capabilities(),
                        require("cmp_nvim_lsp").default_capabilities()
                    )
                    local installed_servers = require("mason-lspconfig").get_installed_servers()

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

                    local custom_configs = {
                        -- kind of based on https://jdhao.github.io/2021/08/12/nvim_sumneko_lua_conf/
                        -- but on the diagnostics we need use also and the workspace.library is not
                        -- needed
                        ltex = {
                            settings = {
                                ltex = {
                                    enabled = {
                                        "bibtex",
                                        "gitcommit",
                                        "markdown",
                                        "org",
                                        "tex",
                                        "restructuredtext",
                                        "rsweave",
                                        "latex",
                                        "quarto",
                                        "rmd",
                                        "context",
                                        "mail",
                                        "plaintext"
                                    }
                                }
                            }
                        },
                        lua_ls = {
                            settings = {
                                Lua = {
                                    runtime = { version = "Lua 5.1" },
                                    -- diagnostics = {
                                    --     -- Get the language server to recognize the `vim` global
                                        globals = { "bit", "vim", "it", "use", "describe",
                                            "after_each", "before_each" },
                                    -- },
                                    workspace = {
                                        library = {
                                            "${3rd}/busted/library",
                                            "${3rd}/luassert/library",
                                            vim.env.VIMRUNTIME,
                                            -- this unput is making things too slow...
                                            -- unpack(vim.api.nvim_get_runtime_file("", true)),
                                        },
                                    },
                                },
                            }
                        },
                        intelephense ={
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
                        },
                        jdtls = {
                            root_dir = vim.fn.getcwd(),
                            settings = {
                                java = {
                                    project = {
                                        sourcePaths = { "src" }
                                    }
                                }
                            },
                        },
                        yamlls = {
                            settings = {
                                yaml = {
                                    keyOrdering = false,
                                },
                            },
                        },
                        gopls = {
                            settings = {
                                gopls = {
                                    env = {
                                        GOFLAGS = "-tags=integration,end2end,live,unit",
                                    },
                                },
                            },
                        },
                        -- see :h lspconfig-root-detection
                        ruff = {
                            root_dir = function() return vim.fn.getcwd() end,
                        },
                    }


                    for _, server in ipairs(installed_servers) do
                        local config = custom_configs[server] or {}
                        config.capabilities = capabilities
                        vim.lsp.config(server, config)
                    end

                    vim.lsp.enable(installed_servers)
                    -- vim.api.nvim_set_current_dir(vim.fn.getcwd())
                    -- local project_dir = Dev.get_path(vim.fn.expand("%:p"))
                    -- log.debug(Dev.get_path(vim.fn.expand("%:p")))
                    -- log.debug(lspconfig_util.root_pattern("setup.py")() or vim.cmd("pwd"))
                end,
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
                    { name = "nvim_lsp", group_index = 2},
                    { name = "luasnip", group_index = 2},
                    { name = "copilot", group_index = 2},
                },{
                    { name = "buffer", group_index = 2},
                    { name = "path", group_index = 2},
                }),
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end
                },
                mapping = cmp_mapping,
            })

            vim.diagnostic.config({
                severity_sort = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    source = true,
                },
            })
        end
    },
    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build="make install_jsregexp",
        config = function ()
            local ls = require("luasnip")

            vim.keymap.set("i", "<C-k>", function() ls.expand({}) end, {silent = true})
            vim.keymap.set({"i", "s"}, "<C-l>", function() ls.jump( 1) end,
            {silent = true})
            vim.keymap.set({"i", "s"}, "<C-j>", function() ls.jump(-1) end,
            { silent = true })

            vim.keymap.set({"i", "s"}, "<C-e>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, { desc = "Change choice in choice node", silent = true })
            -- See: https://github.com/rafamadriz/friendly-snippets#with-lazynvim
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
        dependencies = {
            "rafamadriz/friendly-snippets"
        },
    },
    -- Lazydev
    {
        "folke/lazydev.nvim",
        opts = {
            library = {
                -- See: https://github.com/rcarriga/nvim-dap-ui
                plugins = { "nvim-dap-ui" },
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
}
