vim.cmd("language en_US")
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set clipboard=unnamedplus") -- copy to system clipboard
vim.wo.relativenumber = true

-- Package manager
require("config.lazy")

-- Colorscheme
-- require("catppuccin").setup()
-- vim.cmd.colorscheme "catppuccin"
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

-- Keymaps
vim.keymap.set("n", "<leader>n", ":Neotree filesystem reveal right<CR>")
vim.cmd('nnoremap d "_d') -- remap to use d as delete and not overwrite clipboard
vim.cmd('vnoremap d "_d')
vim.cmd('onoremap d "_d')

vim.cmd('nnoremap p "0p') -- ensure that p works normally (paste underneath)

vim.keymap.set("n", "<leader>gt", function()
	local file_dir = vim.fn.expand("%:p:h")
	vim.cmd("belowright split | terminal")
  print(file_dir)
	vim.cmd("resize 15")
	vim.cmd("startinsert")
end, { desc = "Open terminal below in file's directory" })
