vim.cmd.colorscheme("wildcharm")
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", vim.cmd.write, { desc = "Write" })
vim.keymap.set("n", "<leader>W", vim.cmd('wall'), { desc = "Write" })
vim.keymap.set("n", "<leader>q", vim.cmd.quit, { desc = "Quit" })

vim.keymap.set("n", "<leader>j", ':bn<cr>', { desc = "Buffer Next" })
vim.keymap.set("n", "<leader>k", ':bpcr>', { desc = "Buffer Prev" })
vim.keymap.set("n", "<leader>l", ':bl<cr>', { desc = "Buffer Last" })
vim.keymap.set("n", "<leader>d", ':bd<r>', { desc = "Buffer Delete" })

vim.keymap.set("n", "<leader>i", function()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd('normal! ggVG=')
  vim.api.nvim_win_set_cursor(0, pos)
end, { desc = "Buffer Indent" })

vim.keymap.set("n", "<leader>t", ':terminal<cr>', { desc = "Terminal" })

vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.undofile = true

vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/mikavilpas/yazi.nvim" },
  { src = "https://github.com/kdheepak/lazygit.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/github/copilot.vim" },
  { src = "https://github.com/CopilotC-Nvim/CopilotChat.nvim" },
  { src = "https://github.com/ibhagwan/fzf-lua" },
  { src = "https://github.com/tpope/vim-surround" },
})

require('fzf-lua').setup{}
require('which-key').setup{}

vim.keymap.set("n", "<leader>f", "<cmd>FzfLua files<cr>", { desc = "Files Project" })
vim.keymap.set("n", "<leader>x", "<cmd>FzfLua commands<cr>", { desc = "Execute" })
vim.keymap.set("n", "<leader>c", ":CopilotChat<cr>", { desc = "Copilot" })
vim.keymap.set("n", "<leader>r", "<cmd>FzfLua oldfiles<cr>", { desc = "Recent" })
vim.keymap.set("n", "<leader>b", "<cmd>FzfLua buffers<cr>", { desc = "Buffers" })
vim.keymap.set("n", "<leader>h", "<cmd>FzfLua helptags<cr>", { desc = "Help" })
vim.keymap.set("n", "<leader>m", "<cmd>FzfLua manpages<cr>", { desc = "Man" })
vim.keymap.set("n", "<leader>s", "<cmd>FzfLua grep_project<cr>", { desc = "Search" })
vim.keymap.set("n", "<leader> ", "<cmd>FzfLua global<cr>", { desc = "FZF" })
vim.keymap.set('n', '<leader>g', ':LazyGit<CR>', { desc = "Git", noremap = true, silent = true })
vim.keymap.set('n', '<leader>e', ':Yazi<CR>', { desc = "Explorer", noremap = true, silent = true })
