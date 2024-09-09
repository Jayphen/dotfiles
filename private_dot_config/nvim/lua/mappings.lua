local legendary = require("legendary")

legendary.setup({
	keymaps = {
		-- Save file
		{ "<leader>w", "<cmd>w<cr>", description = "Save file", mode = "n" },

		-- Quit file
		{ "<leader>q", "<cmd>confirm q<cr>", description = "Quit file", mode = "n" },

		-- Quit all the files
		{ "<leader>Q", "<cmd>confirm qall<cr>", description = "Quit all the files", mode = "n" },

		-- Force save file
		{ "<C-s>", "<cmd>w!<cr>", mode = "n" },

		-- Quit all without saving
		{ "<C-q>", "<cmd>qa!<cr>", mode = "n" },

		-- Split window vertically
		{ "|", "<cmd>vsplit<cr>", mode = "n" },

		-- Split window horizontally
		{ "\\", "<cmd>split<cr>", mode = "n" },

		{ ";", ":", mode = "n" },

		{
			"<leader>x",
			"<Cmd>Bdelete<CR>",
			description = "Close current buffer",
			mode = "n", -- Normal mode
		},

		{
			"<leader>X",
			"<Cmd>%bd|e#|bd#<CR>",
			description = "Close all buffers except current",
			mode = "n", -- Normal mode
		},

		-- open legendary
		{ "<leader>p", "<cmd>Legendary<cr>", mode = "n", description = "Open legendary" },

		-- format line
		{ "<leader>f", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", mode = "n" },

		-- Go to next buffer
		{ "]b", "<Cmd>bnext<CR>", description = "Go to next buffer", mode = "n" },
		-- Go to previous buffer
		{ "[b", "<Cmd>bprevious<CR>", description = "Go to previous buffer", mode = "n" },

		-- Go to previous diagnostic message
		{ "[d", vim.diagnostic.goto_prev, description = "Go to previous diagnostic message", mode = "n" },

		-- Go to next diagnostic message
		{ "]d", vim.diagnostic.goto_next, description = "Go to next diagnostic message", mode = "n" },

		-- Open diagnostics list
		-- { '<leader>q', vim.diagnostic.setloclist, description = 'Open diagnostics list', mode = 'n' },

		{ "<leader>y", '"+y', description = "Copy to sys clipboard", mode = "n" },
		{ "<leader>y", '"+y', description = "Copy to sys clipboard", mode = "v" },
		{ "<leader>ya", 'gg"+yG', description = "Copy doc to sys clipboard", mode = "n" },
	},
})
