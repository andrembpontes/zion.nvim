return {
	{
		"tpope/vim-fugitive",
		dependencies = {
			{ "tpope/vim-rhubarb" }, -- GitHub GBrowse support
			{ "cedarbaum/fugitive-azure-devops.vim" }, -- Az DevOps GBrowser support
		},
		event = "VeryLazy",
	}, -- git integration
	{ "f-person/git-blame.nvim", event = "VeryLazy" },
	{
		"lewis6991/gitsigns.nvim",
		config = function(_, opts)
			require("gitsigns").setup(opts)
			require("scrollbar.handlers.gitsigns").setup()
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		cmd = "LazyGit",
		keys = {
			{ "<leader>gg", [[:LazyGitCurrentFile<CR>]], desc = "LazyGit" },
		},
		config = function(_, opts)
			vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
			vim.g.lazygit_floating_window_scaling_factor = 0.95 -- scaling factor for floating window
			vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } -- customize lazygit popup window border characters
			vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
			vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed

			vim.g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
			vim.g.lazygit_config_file_path = "" -- custom config file path
		end,
	},
	{
		"esmuellert/codediff.nvim",
		cmd = "CodeDiff",
		opts = {
			highlights = {
				line_insert = "DiffAdd",
				line_delete = "DiffDelete",
				char_insert = nil,
				char_delete = nil,
				char_brightness = nil,
				conflict_sign = nil,
				conflict_sign_resolved = nil,
				conflict_sign_accepted = nil,
				conflict_sign_rejected = nil,
			},
			diff = {
				layout = "side-by-side",
				disable_inlay_hints = true,
				max_computation_time_ms = 5000,
				ignore_trim_whitespace = false,
				hide_merge_artifacts = false,
				original_position = "left",
				conflict_ours_position = "right",
				conflict_result_position = "bottom",
				conflict_result_height = 30,
				conflict_result_width_ratio = { 1, 1, 1 },
				cycle_next_hunk = true,
				cycle_next_file = true,
				cycle_hunks_across_files = true,
				jump_to_first_change = true,
				highlight_priority = 100,
				compute_moves = false,
				compact_context_lines = 3,
				compact_sync_folds = true,
			},
			explorer = {
				position = "left",
				hidden = false,
				width = 40,
				height = 15,
				auto_refresh = true,
				indent_markers = true,
				initial_focus = "modified",
				icons = {
					folder_closed = "",
					folder_open = "",
				},
				view_mode = "tree",
				flatten_dirs = true,
				file_filter = {
					ignore = { ".git/**", ".jj/**" },
				},
				focus_on_select = true,
				auto_open_on_cursor = true,
				status_right_margin = 1,
				visible_groups = {
					staged = true,
					unstaged = true,
					conflicts = true,
				},
			},
			history = {
				position = "bottom",
				width = 40,
				height = 15,
				initial_focus = "history",
				view_mode = "list",
			},
			keymaps = {
				view = {
					quit = "q",
					toggle_explorer = "<leader>b",
					focus_explorer = "<leader>e",
					-- Disabled: let global iterator handle these so ]] repeats them
					next_hunk = false,
					prev_hunk = false,
					next_file = false,
					prev_file = false,
					diff_get = "do",
					diff_put = "dp",
					open_in_prev_tab = "gf",
					close_on_open_in_prev_tab = false,
					toggle_stage = "-",
					stage_hunk = "<leader>hs",
					unstage_hunk = "<leader>hu",
					discard_hunk = "<leader>hr",
					hunk_textobject = "ih",
					show_help = "g?",
					align_move = "gm",
					toggle_layout = "t",
					toggle_compact = "gc",
				},
				explorer = {
					select = "<CR>",
					hover = "K",
					refresh = "R",
					toggle_view_mode = "i",
					stage_all = "S",
					unstage_all = "U",
					restore = "X",
					toggle_changes = "gu",
					toggle_staged = "gs",
					fold_open = "zo",
					fold_open_recursive = "zO",
					fold_close = "zc",
					fold_close_recursive = "zC",
					fold_toggle = "za",
					fold_toggle_recursive = "zA",
					fold_open_all = "zR",
					fold_close_all = "zM",
				},
				history = {
					select = "<CR>",
					toggle_view_mode = "i",
					refresh = "R",
					fold_open = "zo",
					fold_open_recursive = "zO",
					fold_close = "zc",
					fold_close_recursive = "zC",
					fold_toggle = "za",
					fold_toggle_recursive = "zA",
					fold_open_all = "zR",
					fold_close_all = "zM",
				},
				conflict = {
					accept_incoming = "<leader>ct",
					accept_current = "<leader>co",
					accept_both = "<leader>cb",
					discard = "<leader>cx",
					accept_all_incoming = "<leader>cT",
					accept_all_current = "<leader>cO",
					accept_all_both = "<leader>cB",
					discard_all = "<leader>cX",
					next_conflict = "]x",
					prev_conflict = "[x",
					diffget_incoming = "2do",
					diffget_current = "3do",
				},
			},
		},
	},
	{
		"NeogitOrg/neogit",
		enabled = false, -- still WIP require dev version of NeoVim
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"nvim-telescope/telescope.nvim", -- optional
			"esmuellert/codediff.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
		},
		config = true,
	},
}
