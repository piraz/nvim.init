local keymap = require("piraz.keymap")

local nnoremap = keymap.nnoremap
local vnoremap = keymap.vnoremap


vim.g.mapleader = " "
-- nnoremap("<leader>bls", "<cmd>ls<CR><cmd>b ")
nnoremap("<leader>ee", "<cmd>Ex<CR>")
nnoremap("<leader>ls", "<cmd>ls<CR>")
nnoremap("<leader>so", "<cmd>so<CR>")
nnoremap("<leader>pks", "<cmd>PackerSync<CR>")


-- see: https://stackoverflow.com/a/73354675/2887989
vnoremap("<leader>y", [["+y<Esc>]])
vnoremap("<leader>Y", [["+Y<Esc>]])

-- From: https://superuser.com/a/310424
-- TODO: See if this good: nnoremap()
