local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd({ "BufWritePost" }, { pattern = { "/Users/jayphen/.config/nvim/init.lua" }, command = "so <afile>" })

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.templ",
	callback = function()
		vim.cmd("TSBufEnable highlight")
	end,
})

function _G.set_terminal_keymaps()
	-- buffer = 0 means that this mapping is global
	local opts = { noremap = true, silent = true }
	vim.api.nvim_set_keymap("t", "<C-h>", "<Cmd>wincmd h<CR>", opts)
	vim.api.nvim_set_keymap("t", "<C-j>", "<Cmd>wincmd j<CR>", opts)
	vim.api.nvim_set_keymap("t", "<C-k>", "<Cmd>wincmd k<CR>", opts)
	vim.api.nvim_set_keymap("t", "<C-l>", "<Cmd>wincmd l<CR>", opts)
	vim.api.nvim_set_keymap("t", "<C-w>", "<C-\\><C-n><C-w>", opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	desc = "Check if buffers changed on editor focus",
	group = augroup("checktime", { clear = true }),
	command = "checktime",
})
