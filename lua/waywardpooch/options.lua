local set = vim.opt
local let = vim.g

set.background = "dark"
set.backup = false
set.cmdheight = 1
set.expandtab = true
set.hlsearch = false
set.incsearch = true
set.nu = true
set.relativenumber = true
set.shiftwidth = 4
set.showmode = false
set.signcolumn = "yes"
set.smartindent = true
set.softtabstop = 4
set.swapfile = false
set.tabstop = 4
set.termguicolors = true
set.undodir = os.getenv("HOME") .. "/.vim/undodir"
set.undofile = true
set.updatetime = 50
set.colorcolumn = "80"
set.shortmess:append("c")
set.errorbells = false

let.mapleader = " "
let.netrw_localmovecmd = "mv"
