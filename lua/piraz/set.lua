local Dev = require("piraz.dev")
-- vim.opt.swapfile = false
-- vim.opt.backup = false
vim.opt.guicursor = ""

vim.opt.mouse = ""

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.listchars = "tab:> ,trail:-,nbsp:+"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. table.concat({
    "", "undodir"
}, Dev.sep)
vim.opt.undofile = true

-- vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.opt.cursorcolumn = true
-- vim.opt.cursorline= false

vim.opt.splitright = true

vim.g.mapleader = " "

-- SEE: https://stackoverflow.com/a/34533448
vim.g.netrw_banner=0
