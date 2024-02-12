-- opts = {} is equivalent to require(thing).setup() !

local plugins = {
	{ lazy = true, "nvim-lua/plenary.nvim" },

	{
		"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight]])
		end,
	},

	-- make sexy ui
	{
		"stevearc/dressing.nvim",
		opts = {},
	},

	{
		"mrjones2014/legendary.nvim",
		-- since legendary.nvim handles all your keymaps/commands,
		-- its recommended to load legendary.nvim before other plugins
		priority = 10000,
		lazy = false,
		-- sqlite is only needed if you want to use frecency sorting
		-- dependencies = { 'kkharji/sqlite.lua' }
		opts = {
			extensions = { lazy_nvim = { auto_register = true } },
		},
	},

	{
		"mrjones2014/smart-splits.nvim",
		-- lazy = true,
		build = "./kitty/install-kittens.bash",
		opts = { ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" }, ignored_buftypes = { "nofile" } },
		config = function()
			require("plugin-conf.smart-split")
		end,
	},

	-- Git related plugins
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	"kyazdani42/nvim-web-devicons",

	{
		"lewis6991/gitsigns.nvim",
	},

	-- Useful plugin to show you pending keybinds.
	{ "folke/which-key.nvim", opts = {} },

	-- Fuzzy Finder (files, lsp, etc)
	{
		"nvim-telescope/telescope.nvim",
		keys = function()
			return require("keys.telescope")
		end,
		dependencies = {
			-- Fuzzy Finder Algorithm which requires local dependencies to be built.
			-- Only load if `make` is available. Make sure you have the system
			-- requirements installed.
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
		opts = {
			extensions = {
				smart_open = {
					match_algorithm = "fzy",
					open_buffer_indicators = { previous = "👀", others = "🙈" },
				},
			},
		},
	},

	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
	},

	-- Enter to expand selection, bcksp to contract
	{
		"sustech-data/wildfire.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {},
	},

	-- Jump around
	{
		"ggandor/leap.nvim",
		dependencies = { "tpope/vim-repeat" },
		lazy = false,
		config = function()
			require("leap").create_default_mappings()
		end,
	},

	-- Autocomplete
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "Exafunction/codeium.nvim", opts = {} },
			"rafamadriz/friendly-snippets",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			-- snippets engine
			{
				"L3MON4D3/LuaSnip",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
			{
				"petertriho/cmp-git",
				config = true,
			},
		},
		config = function()
			require("plugin-conf.nvim-cmp")
		end,
	},

	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",

			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			"folke/neodev.nvim",
		},
		config = function()
			require("plugin-conf.nvim-lspconfig")
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {},
	},

	-- tsserver replacement
	{
		"yioneko/nvim-vtsls",
		ft = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
		},
		dependencies = { "nvim-lspconfig" },
	},

	-- neo-tree file tree
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		keys = function()
			return require("keys.neo-tree")
		end,
		config = function()
			require("plugin-conf.neo-tree")
		end,
	},

	-- lualine status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		config = function()
			require("plugin-conf.lualine")
		end,
	},

	-- Filebrowser and tree editor in a buffer
	{
		"stevearc/oil.nvim",
		opts = {
			default_file_explorer = true,
		},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- Surround text with quotes, brackets, etc
	{
		"kylechui/nvim-surround",
		opts = {},
	},

	-- zk-like wiki
	{
		"vimwiki/vimwiki",
		init = function()
			vim.g.vimwiki_list = {
				{
					path = "~/docs/vimwiki",
					syntax = "markdown",
					ext = ".wiki",
				},
			}
		end,
	},

	-- Term persistence
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		lazy = false,
		keys = {
			{ "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle terminal" },
		},
		config = function()
			require("toggleterm").setup()

			local Terminal = require("toggleterm.terminal").Terminal
			local lazygit = Terminal:new({
				cmd = "lazygit",
				dir = "git_dir",
				direction = "float",
				float_opts = {
					border = "double",
				},
				-- function to run on opening the terminal
				on_open = function(term)
					vim.cmd("startinsert!")
					vim.api.nvim_buf_set_keymap(
						term.bufnr,
						"n",
						"q",
						"<cmd>lua _lazygit_toggle()<CR>",
						{ noremap = true, silent = true }
					)
				end,
				-- function to run on closing the terminal
				on_close = function(term)
					vim.cmd("startinsert!")
				end,
			})

			function _lazygit_toggle()
				lazygit:toggle()
			end

			vim.api.nvim_set_keymap(
				"n",
				"<leader>gg",
				"<cmd>lua _lazygit_toggle()<CR>",
				{ noremap = true, silent = true }
			)
		end,
	},

	{
		"danielfalk/smart-open.nvim",
		branch = "0.2.x",
		config = function()
			require("telescope").load_extension("smart_open")
		end,
		dependencies = {
			"kkharji/sqlite.lua",
			{ "nvim-telescope/telescope-fzy-native.nvim" },
		},
		keys = {
			{
				"<leader><leader>",
				"<cmd>lua require('telescope').extensions.smart_open.smart_open()<cr>",
				desc = "Smart open",
			},
		},
	},

	{
		"ryanmsnyder/toggleterm-manager.nvim",
		dependencies = {
			"akinsho/nvim-toggleterm.lua",
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim", -- only needed because it's a dependency of telescope
		},
		config = true,
	},
}

require("lazy").setup(plugins, require("plugin-conf.lazy"))
