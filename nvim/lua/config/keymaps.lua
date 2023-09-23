-- kj to escape insert mode 
vim.keymap.set('i', 'kj', '<Esc>')
vim.keymap.set('v', 'kj', '<Esc>')

-- display line up/down
vim.keymap.set('n', 'gj', 'j')
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'gk', 'k')
vim.keymap.set('n', 'k', 'gk')

-- navigation in insert mode
vim.keymap.set('i', '<Up>', '<C-o>gk')
vim.keymap.set('i', '<Down>', '<C-o>gj')
vim.keymap.set('i', '<C-f>', '<Right>')
vim.keymap.set('i', '<C-b>', '<Left>')
vim.keymap.set('i', '<A-f>', '<C-o>w')
vim.keymap.set('i', '<A-b>', '<C-o>b')

-- move lines
vim.keymap.set('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = "Move down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- leader maps
vim.keymap.set('n', '<leader>bb', '<cmd>e#<CR>', { desc = "Edit alternate file" })

-- toggle options
local function toggle_opt(option)
  vim.opt[option] = not vim.opt[option]:get()
end
vim.keymap.set('n', '<leader>gc', function() toggle_opt("cursorline") end)
vim.keymap.set('n', '<leader>gl', function() toggle_opt("list") end)
vim.keymap.set('n', '<leader>gn', function() toggle_opt("number") end)
vim.keymap.set('n', '<leader>gr', function() toggle_opt("relativenumber") end)
vim.keymap.set('n', '<leader>gs', function() toggle_opt("spell") end)
vim.keymap.set('n', '<leader>gw', function() toggle_opt("wrap") end)

-- navigation anywhere
--vim.keymap.set('n', '<leader>l', '<cmd>HopLine<CR>')
--vim.keymap.set('n', '<leader>w', '<cmd>HopWord<CR>')
--vim.keymap.set('n', '<leader>t', "<cmd>HopChar2<CR>")

