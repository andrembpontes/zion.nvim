return {
	-- highlight context brakets e.g. {}
	{
		"utilyre/sentiment.nvim",
		version = "*",
		event = "VeryLazy", -- keep for lazy loading
		opts = {
			-- config
			pairs = {
				{ "(", ")" },
				{ "{", "}" },
				{ "[", "]" },
			},
		},
		init = function()
			-- `matchparen.vim` needs to be disabled manually in case of lazy loading
			vim.g.loaded_matchparen = 1
		end,
	},

	-- indent line
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},

	-- change surroundings with `e.g. cs"`
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = true,
	},

	-- color highligher + color picker
	{
		"uga-rosa/ccc.nvim",
		event = "VeryLazy",
		config = true,
	},
}
