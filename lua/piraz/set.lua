vim.o.guicursor = ""
vim.o.mouse = ""

vim.o.number = true
vim.o.relativenumber = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.smartindent = true
vim.o.wrap = false

vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true
local undo_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "undodir")
vim.fn.mkdir(undo_dir, "p")
vim.o.undodir = undo_dir

-- vim.opt.hlsearch = false
vim.o.incsearch = true

vim.o.termguicolors = true
vim.o.winborder = "single"

vim.o.scrolloff = 8

-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.o.signcolumn = "yes"

vim.o.updatetime = 50
vim.o.colorcolumn = "80"
vim.o.cursorcolumn = true
-- vim.opt.cursorline= false

vim.o.splitright = true

vim.g.mapleader = " "

-- SEE: https://stackoverflow.com/a/34533448
vim.g.netrw_banner=0
