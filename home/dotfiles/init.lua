vim.cmd.colorscheme("wildcharm")
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", vim.cmd.write, { desc = "Write" })
vim.keymap.set("n", "<leader>q", vim.cmd.quit, { desc = "Quit" })
vim.keymap.set("n", "<leader>i", vim.cmd"normal! gg=G", { desc = "Indent" })
vim.keymap.set("n", "<leader> ", ":", { desc = "Enter command-line mode" })
vim.opt.cursorline = true
vim.opt.number = true            
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/kdheepak/lazygit.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/mikavilpas/yazi.nvim" },
})
require('telescope').setup{}
vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
vim.keymap.set("n", "<leader>c", "<cmd>Telescope commands<cr>", { desc = "Commands" })
vim.keymap.set("n", "<leader>s", "<cmd>Telescope grep_string<cr>", { desc = "Grep String" })
vim.keymap.set("n", "<leader>h", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })
vim.keymap.set("n", "<leader>r", "<cmd>Telescope oldfiles<cr>", { desc = "Old Files" })
vim.keymap.set("n", "<leader>t", "<cmd>Telescope<cr>", { desc = "Telescope" })
vim.keymap.set("n", "<leader>.", "<cmd>Telescope find_files hidden=true<cr>", { desc = "Hidden Files" })
require('which-key').setup{}
require('yazi').setup{}
vim.keymap.set("n", "<leader>e", "<cmd>Yazi<cr>", { desc = "File Manager" })
vim.keymap.set('n', '<leader>g', ':LazyGit<CR>', { noremap = true, silent = true })
