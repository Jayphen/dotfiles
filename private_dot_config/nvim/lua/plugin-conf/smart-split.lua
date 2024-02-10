require("legendary").setup({
	extensions = {
		-- default settings shown below:
		smart_splits = {
			directions = { "h", "j", "k", "l" },
			mods = {
				-- for moving cursor between windows
				move = "<C>",
				-- for resizing windows
				resize = "<M>",
				-- for swapping window buffers
				swap = false, -- false disables creating a binding
			},
		},
		-- or, customize the mappings
		smart_splits = {
			mods = {
				-- any of the mods can also be a table of the following form
				swap = {
					-- this will create the mapping like
					-- <leader><C-h>
					-- <leader><C-j>
					-- <leader><C-k>
					-- <leader><C-l>
					mod = "<C>",
					prefix = "<leader>",
				},
			},
		},
	},
})
