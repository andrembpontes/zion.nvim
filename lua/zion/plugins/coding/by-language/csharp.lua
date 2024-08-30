return {
	-- {
	--     "Shougo/deoplete.nvim",
	--     build = {
	--         vim.cmd("UpdateRemotePlugins")
	--     },
	-- },
	-- {
	--     "beeender/Comrade",
	-- },
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				["omnisharp"] = {
					-- Enables support for roslyn analyzers, code fixes and rulesets.
					enable_roslyn_analyzers = false,

					-- Specifies whether 'using' directives should be grouped and sorted during
					-- document formatting.
					organize_imports_on_format = false,

					-- Enables support for showing unimported types and unimported extension
					-- methods in completion lists. When committed, the appropriate using
					-- directive will be added at the top of the current file. This option can
					-- have a negative impact on initial completion responsiveness,
					-- particularly for the first few completion sessions after opening a
					-- solution.
					enable_import_completion = true,

					-- Specifies whether to include preview versions of the .NET SDK when
					-- determining which version to use for project loading.
					sdk_include_prereleases = true,

					-- Only run analyzers against open files when 'enableRoslynAnalyzers' is
					-- true
					analyze_open_documents_only = false,
				},
			},
		},
	},
}
