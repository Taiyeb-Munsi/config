local opts = { noremap = true, silent = true }
local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

map("i", "<C-c>", "<Esc>")
map("n", "<C-c>", ":nohl<CR>", { desc = "Clear search hl", silent = true })

map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)   
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)    
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)      
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts) 

map("n", "<leader>n", ":bn<CR>", { desc = "Next buffer" })
map("n", "<leader>p", ":bp<CR>", { desc = "Previous buffer" })
map("n", "<leader>c", ":bd<CR>", { desc = "Close buffer" })
map("n", "<leader><leader>", "<C-^>")
