vim.g.mapleader = ","
vim.g.mapllocaleader = " "

vim.opt.laststatus = 0
vim.opt.iskeyword:append('-')

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.clipboard = "unnamed"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.termguicolors = true
vim.opt.wrap = false

vim.opt.wildmode = "longest:full,full" -- command line completion mode

vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"

vim.opt.tags = "./tags,./TAGS,tags;~,TAGS:~"

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false

