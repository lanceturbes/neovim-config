local Remap = require("waywardpooch.keymap")
local nnoremap = Remap.nnoremap

-- helper for creating vim global variables
-- local let = vim.g

-- maps the <leader> key to space bar, if wanted
-- uncommenting this will conflict with current keymaps at the moment
-- let.mapleader = " "

nnoremap("<leader>e", ":Ex<enter>")
