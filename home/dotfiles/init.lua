vim.cmd.colorscheme("wildcharm")
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", vim.cmd.write, { desc = "Write" })
vim.keymap.set("n", "<leader>q", vim.cmd.quit, { desc = "Quit" })
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2

vim.pack.add({
  { src = "https://github.com/kdheepak/lazygit.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/github/copilot.vim" },
  { src = "https://github.com/ibhagwan/fzf-lua" },
})

require('fzf-lua').setup{}
vim.keymap.set("n", "<leader>f", "<cmd>FzfLua files<cr>", { desc = "Files" })
vim.keymap.set("n", "<leader>o", "<cmd>FzfLua files cwd=~<cr>", { desc = "Open" })
vim.keymap.set("n", "<leader>c", "<cmd>FzfLua commands<cr>", { desc = "Commands" })
vim.keymap.set("n", "<leader>r", "<cmd>FzfLua oldfiles<cr>", { desc = "Recent" })
vim.keymap.set("n", "<leader>b", "<cmd>FzfLua buffers<cr>", { desc = "Buffers" })
vim.keymap.set("n", "<leader>h", "<cmd>FzfLua helptags<cr>", { desc = "Help" })
vim.keymap.set("n", "<leader>m", "<cmd>FzfLua manpages<cr>", { desc = "Man" })
vim.keymap.set("n", "<leader>s", "<cmd>FzfLua grep_project<cr>", { desc = "Grep Project" })
vim.keymap.set("n", "<leader> ", "<cmd>FzfLua global<cr>", { desc = "FZF" })
require('which-key').setup{}
vim.keymap.set('n', '<leader>g', ':LazyGit<CR>', { noremap = true, silent = true })
