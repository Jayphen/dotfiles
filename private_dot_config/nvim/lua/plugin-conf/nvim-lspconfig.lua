local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { "clangd", "rust_analyzer", "vtsls", "lua_ls", "gopls", "templ" }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

lspconfig.html.setup({
	capabilities = capabilities,
	filetypes = { "html", "templ" },
})
lspconfig.htmx.setup({
	capabilities = capabilities,
	filetypes = { "html", "templ" },
})

local legendary = require("legendary")
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }

		legendary.keymaps({
			-- Diagnostic mappings with common options
			{ "<space>K", vim.diagnostic.open_float, description = "Open diagnostic float", opts = opts },
			{ "[d", vim.diagnostic.goto_prev, description = "Go to previous diagnostic", opts = opts },
			{ "]d", vim.diagnostic.goto_next, description = "Go to next diagnostic", opts = opts },
			{ "<space>d", vim.diagnostic.setloclist, description = "Open diagnostic loclist", opts = opts },

			-- LSP related mappings with common options
			{ "gD", vim.lsp.buf.declaration, description = "Go to declaration", opts = opts },
			{ "gd", vim.lsp.buf.definition, description = "Go to definition", opts = opts },
			{ "K", vim.lsp.buf.hover, description = "Show hover information", opts = opts },
			{ "gi", vim.lsp.buf.implementation, description = "Go to implementation", opts = opts },
			{ "<space>wa", vim.lsp.buf.add_workspace_folder, description = "Add workspace folder", opts = opts },
			{ "<space>wr", vim.lsp.buf.remove_workspace_folder, description = "Remove workspace folder", opts = opts },
			{
				"<space>wl",
				function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end,
				description = "List workspace folders",
				opts = opts,
			},
			{ "<space>D", vim.lsp.buf.type_definition, description = "Go to type definition", opts = opts },
			{ "<space>rn", vim.lsp.buf.rename, description = "Rename symbol", opts = opts },
			{
				"<space>ca",
				vim.lsp.buf.code_action,
				description = "Code action",
				mode = { "n", "v" }, -- Valid for normal and visual mode
				opts = opts,
			},
			{ "gr", vim.lsp.buf.references, description = "Find references", opts = opts },
			{
				"<space>f",
				function()
					vim.lsp.buf.format({ async = true })
				end,
				description = "Format document",
				opts = opts,
			},
		})
	end,
})
