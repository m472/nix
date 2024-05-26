local set = vim.opt

pcall(vim.cmd('colorscheme gruvbox'))

-- tabstop settings
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = true
set.smarttab = true

-- linenumbers
set.number = true
set.relativenumber = true

-- ignore case as long as everything typed is lowercase
set.smartcase = true
set.ignorecase = true

-- persistent undo history
set.undodir = '/home/matz/.vim/undodir'
set.undofile = true
set.swapfile = false

-- open splits bottom and left by default
set.splitbelow = true
set.splitright = true

set.scrolloff = 8

set.signcolumn = "yes"
