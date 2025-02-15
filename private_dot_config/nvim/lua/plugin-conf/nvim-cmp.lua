local luasnip = require("luasnip")
local lspkind = require("lspkind") -- Optional: for standard icons if you want to include LSP kinds

local common_sources = {
	{ name = "buffer", max_item_count = 10 },
	{ name = "calc" },
	{ name = "path" },
}

-- nvim-cmp setup
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Up
		["<C-d>"] = cmp.mapping.scroll_docs(4), -- Down
		-- C-b (back) C-f (forward) for snippet placeholder navigation.
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text",
			max_width = 50,
			symbol_map = { Copilot = "", Codeium = " " },
		}),
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp", priority = 1000, max_item_count = 10 },
		{ name = "luasnip", priority = 750, max_item_count = 10 },
		{ name = "nvim_lsp_signature_help" },
		{ name = "copilot", group_index = 2 },
		{ name = "codeium", group_index = 2, priority = 800 },
		-- { name = "supermaven", group_index = 2, priority = 500 },
	}, common_sources),
})
