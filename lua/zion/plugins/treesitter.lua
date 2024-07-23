return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			{ "JoosepAlviste/nvim-ts-context-commentstring" },
			{ "nvim-treesitter/nvim-treesitter-context", config = true },
			{
				"nvim-navic",
				opts = {
					icons = {
						File = "󰈙 ",
						Module = " ",
						Namespace = " ",
						Package = " ",
						Class = "󰌗 ",
						Method = "󰆧 ",
						Property = " ",
						Field = " ",
						Constructor = " ",
						Enum = "󰕘",
						Interface = " ",
						Function = "󰊕 ",
						Variable = "󰆧 ",
						Constant = "󰏿 ",
						String = "󰀬 ",
						Number = "󰎠 ",
						Boolean = "◩ ",
						Array = "󰅪 ",
						Object = "󰅩 ",
						Key = "󰌋 ",
						Null = "󰟢 ",
						EnumMember = " ",
						Struct = "󰌗 ",
						Event = " ",
						Operator = " ",
						TypeParameter = " ",
					},
				},
			},
		},
		opts = {
			ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
			ignore_install = {
				"phpdoc",
			},

			highlight = { enable = true },
			indent = { enable = true },
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
			},
			matchup = {
				enable = true,
			},
		},
		config = function(_, opts)
			local context_commentstring_opts = opts.context_commentstring
			opts.context_commentstring = nil

			require("nvim-treesitter.configs").setup(opts)
			require("ts_context_commentstring").setup(context_commentstring_opts)
		end,
	},
}
