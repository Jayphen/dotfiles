-- opts = {} is equivalent to require(thing).setup() !

local plugins = {
	{ lazy = true, "nvim-lua/plenary.nvim" },
	{
		-- https://github.com/crusj/bookmarks.nvim
		"crusj/bookmarks.nvim",
		keys = {
			{ "<tab><tab>", mode = { "n" } },
		},
		branch = "main",
		dependencies = { "nvim-web-devicons" },
		config = function()
			require("bookmarks").setup({
				keymap = {
					toggle = "<tab><tab>", -- Toggle bookmarks(global keymap)
					add = "<leader>ba", -- Add bookmarks(global keymap)
					show_desc = "<leader>bd", -- show bookmark desc(global keymap)
				},
			})
			require("telescope").load_extension("bookmarks")
		end,
	},

	{
		"smjonas/inc-rename.nvim",
		opts = {
			input_buffer_type = "dressing",
		},
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"<leader>rn",
				function()
					return ":IncRename " .. vim.fn.expand("<cword>")
				end,
				mode = "n",
				desc = "Rename",
			},
		},
	},

	{
		"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight]])
		end,
	},

	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				-- Add any configuration options here
			})
		end,
	},
	-- nicer popups and ting
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
		},
		opts = {
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = false, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},
		},
	},

	{
		"projekt0n/github-nvim-theme",
	},

	-- make pretty ui
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
	"sindrets/diffview.nvim",
	{
		"almo7aya/openingh.nvim",
		keys = {
			{
				"<leader>gy",
				":OpenInGHFileLines<CR>",
				mode = "",
				desc = "Open line in Github",
			},
		},
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
			"virchau13/tree-sitter-astro",
			"windwp/nvim-ts-autotag",
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		build = ":TSUpdate",
		config = function()
			require("ts_context_commentstring").setup({})
			vim.g.skip_ts_context_commentstring_module = true
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"typescript",
					"javascript",
					"tsx",
					"html",
					"css",
					"json",
					"astro",
					"lua",
					"regex",
					"bash",
					-- Add any other languages you frequently use
				},
				fold = {
					enable = true,
				},
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
				autotag = { enable = true },
			})
		end,
	},

	-- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
	{
		"numToStr/Comment.nvim",
		opts = {},
		lazy = false,
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
			{
				"supermaven-inc/supermaven-nvim",
				opts = {
					disable_inline_completion = true,
					disable_keymaps = true,
				},
			},
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
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		-- Everything in opts will be passed to setup()
		opts = {
			-- Define your formatters
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "biome", "prettierd", "prettier" },
				typescript = { "biome", "prettierd", "prettier" },
				typescriptreact = { "biome", "prettierd", "prettier" },
				javascriptreact = { "biome", "prettierd", "prettier" },
				json = { "biome", "prettierd", "prettier" },
				jsonc = { "biome", "prettierd", "prettier" },
				css = { "prettierd", "prettier" },
				astro = { "prettier" },
				-- Add more file types as needed
			},
			-- Set up format-on-save
			format_on_save = { timeout_ms = 500, lsp_fallback = true },
			-- Customize formatters
			formatters = {
				shfmt = {
					prepend_args = { "-i", "2" },
				},
				prettier = {
					-- Prettier-specific configuration
					prepend_args = { "--config-precedence", "prefer-file" },
				},
			},
		},

		stop_after_first = {
			javascript = true,
			typescript = true,
			typescriptreact = true,
			javascriptreact = true,
			json = true,
			jsonc = true,
		},
		init = function()
			-- If you want the formatexpr, here is the place to set it
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},

	-- tsserver replacement
	{
		"yioneko/nvim-vtsls",
		dependencies = { "nvim-lspconfig" },
		config = function()
			require("plugin-conf.vtsls")
		end,
	},

	-- go!
	{
		"fatih/vim-go",
		ft = { "go" },
		build = ":GoUpdateBinaries",
		config = function()
			-- Configuration for vim-go
			vim.g.go_fmt_command = "goimports"
			-- Add other vim-go configuration here
		end,
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
	-- {
	-- 	"vimwiki/vimwiki",
	-- 	init = function()
	-- 		vim.g.vimwiki_list = {
	-- 			{
	-- 				path = "~/docs/vimwiki",
	-- 				syntax = "markdown",
	-- 				ext = ".md",
	-- 			},
	-- 		}
	-- 	end,
	-- },

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

	require("plugin-conf.ufo"),
	require("plugin-conf.statuscol"),
}

require("lazy").setup(plugins, require("plugin-conf.lazy"))
