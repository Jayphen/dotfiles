vim.api.nvim_create_autocmd(
	{ "BufWritePost" },
	{ pattern = { "/Users/jayphen/.config/nvim/init.lua" }, command = "so <afile>" }
)
