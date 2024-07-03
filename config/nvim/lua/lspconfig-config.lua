local cmp = require("cmp")

if vim.env.HOME_MANAGER_MANAGES_NVIM == nil then
	require("mason").setup()
	require("mason-lspconfig").setup({
		ensure_installed = {
			"jedi_language_server",
			"julials",
			"dockerls",
			"csharp_ls",
			"esbonio",
			"taplo",
			"yamlls",
			"ltex",
			"bashls",
		},
	})
end

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "vsnip" }, -- For vsnip users.
		-- { name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = "buffer" },
	}),
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = "buffer" },
	}),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
require("lspconfig")["pylsp"].setup({ capabilities = capabilities })
require("lspconfig")["ruff_lsp"].setup({ capabilities = capabilities })
require("lspconfig")["csharp_ls"].setup({ capabilities = capabilities })
require("lspconfig")["hls"].setup({
	capabilities = capabilities,
	settings = {
		haskell = { formattingProvider = "fourmolu" },
	},
})
require("lspconfig")["rust_analyzer"].setup({ capabilities = capabilities })
require("lspconfig")["lua_ls"].setup({ capabilities = capabilities })
require("lspconfig")["nil_ls"].setup({ capabilities = capabilities })
require("lspconfig")["jqls"].setup({ capabilities = capabilities })
require("lspconfig")["gopls"].setup({ capabilities = capabilities })
require("lspconfig")["r_language_server"].setup({ capabilities = capabilities })
require("lspconfig")["clangd"].setup({ capabilities = capabilities })
require("lspconfig")["dockerls"].setup({ capabilities = capabilities })
require("lspconfig")["texlab"].setup({ capabilities = capabilities })
require("lspconfig")["fortls"].setup({ capabilities = capabilities })
require("lspconfig")["csharp_ls"].setup({ capabilities = capabilities })
require("lspconfig")["gleam"].setup({ capabilities = capabilities })
require("lspconfig")["openscad_lsp"].setup({ capabilities = capabilities })

-- Setup none-ls
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.code_actions.refactoring,

		-- nix
		null_ls.builtins.diagnostics.deadnix,
		null_ls.builtins.formatting.nixfmt,
		null_ls.builtins.diagnostics.statix,

		-- python
		null_ls.builtins.diagnostics.mypy,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.isort,

		-- fish
		null_ls.builtins.diagnostics.fish,
		null_ls.builtins.formatting.fish_indent,

		-- docker
		null_ls.builtins.diagnostics.hadolint,

		-- markdown
		null_ls.builtins.diagnostics.markdownlint,
		null_ls.builtins.diagnostics.rstcheck,

		-- css
		null_ls.builtins.diagnostics.stylelint,

		-- R
		null_ls.builtins.formatting.format_r,

		-- lua
		null_ls.builtins.formatting.stylua,

		-- just
		null_ls.builtins.formatting.just,

		--yaml
		null_ls.builtins.formatting.yamlfmt,

		-- misc
		null_ls.builtins.diagnostics.todo_comments,
	},
	capabilities = capabilities,
})
