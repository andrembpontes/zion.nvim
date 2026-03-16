return {
	{
		"williamboman/mason.nvim",
		lazy = false, --Lazy loading NOT recommended by the authors
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        },
		config = function(_, opts)
			require("mason").setup(opts)
		end,
	},
}
