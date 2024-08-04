vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Enable break indent
vim.o.breakindent = true

vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.showtabline = 2 -- always show the tabline
vim.o.shiftwidth = 2

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"
-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

vim.o.number = true
vim.o.termguicolors = true
vim.o.title = false

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.filetype.add({ extension = { templ = "templ", mdx = "markdown.mdx" } })

require("plugins")
require("autocmd")
require("mappings")
require("lsp")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
-- local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
-- vim.api.nvim_create_autocmd("TextYankPost", {
-- 	callback = function()
-- 		vim.highlight.on_yank()
-- 	end,
-- 	group = highlight_group,
-- 	pattern = "*",
-- })
--

vim.opt.foldmethod = "expr" -- treesiter time
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- treesiter
