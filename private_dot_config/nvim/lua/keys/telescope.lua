return {
	{ "<leader>ff", ":Telescope find_files<Cr>", mode = { "n" }, desc = "Find files" },
	{ "<leader>fo", ":Telescope oldfiles<Cr>", mode = { "n" }, desc = "Old files" },
	{ "<leader>fs", ":Telescope live_grep<Cr>", mode = { "n" }, desc = "Live grep" },
	{ "<leader>fb", ":Telescope buffers<Cr>", mode = { "n" }, desc = "Buffers" },
	{ "<leader>fg", ":Telescope git_status<Cr>", mode = { "n" }, desc = "Git status" },
	{ "<leader>fw", ":Telescope grep_string<Cr>", mode = { "n" }, desc = "Grep string under cursor" },
	{ "<leader>fo", ":Telescope neovim-project discover<Cr>", mode = { "n" }, desc = "Project discover" },
}
