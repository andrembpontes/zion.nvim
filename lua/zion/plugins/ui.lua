return {

    { "mhinz/vim-startify" }, -- start screen

    { "petertriho/nvim-scrollbar" },

    {
        "nvim-lualine/lualine.nvim", -- statusline
        event = "VeryLazy",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            options = {
                --theme = "dracula",
                --theme = "gruvbox",
                theme = "auto",
            },
        },
    },

    -- colorscheme
    {
        "Mofiqul/dracula.nvim",
        cond = false,
        lazy = false,
        priority = 9999, -- Lazy recommeds high value for colorschemes
        setup = true,
        init = function()
            --print("setting colorscheme dracula")
            vim.cmd.colorscheme("dracula")
        end,
    },

    {
        "folke/tokyonight.nvim",
        cond = false,
        lazy = false,
        priority = 9999, -- Lazy recommeds high value for colorschemes
        setup = true,
        init = function()
            --print("setting colorscheme tokyonight")
            vim.cmd.colorscheme("tokyonight")
        end,
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = false,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
            })
            vim.cmd.colorscheme("catppuccin")
        end,
    },

    {
        "ellisonleao/gruvbox.nvim",
        cond = false,
        lazy = false,
        priority = 9999, -- Lazy recommeds high value for colorschemes
        opts = {
            undercurl = true,
            underline = true,
            bold = true,
            italic = {
                strings = true,
                comments = true,
                operators = false,
                folds = true,
            },
            strikethrough = true,
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            invert_intend_guides = false,
            inverse = true, -- invert background for search, diffs, statuslines and errors
            contrast = "",  -- can be "hard", "soft" or empty string
            palette_overrides = {},
            overrides = {},
            dim_inactive = false,
            transparent_mode = false,
        },
        init = function()
            --print("setting colorscheme gruvbox")
            vim.cmd.colorscheme("gruvbox")
        end,
    },

    -- delete buffers without affecting layout
    -- use :Bdelete and :Bwipewout
    -- instead of :bdelete and :bwipeout
    {
        "famiu/bufdelete.nvim",
        cmd = { "Bdelete", "Bwipeout" },
    },

    -- auto toggle relative line numbers
    -- normal: relative; else: absolute
    {
        "sitiom/nvim-numbertoggle",
        event = "VeryLazy",
    },

    -- auto jump plugin
    {
        url = "https://codeberg.org/andyg/leap.nvim",
        enabled = true,
        config = function()
            local leap = require("leap")

            leap.setup({})

            local function set_if_unmapped(modes, lhs, rhs, desc)
                for _, mode in ipairs(modes) do
                    if vim.fn.mapcheck(lhs, mode) == "" and vim.fn.hasmapto(rhs, mode) == 0 then
                        vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
                    end
                end
            end

            set_if_unmapped({ "n", "x", "o" }, "s", "<Plug>(leap-forward)", "Leap forward")
            set_if_unmapped({ "n", "x", "o" }, "S", "<Plug>(leap-backward)", "Leap backward")
            set_if_unmapped({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)", "Leap from window")
            set_if_unmapped({ "x", "o" }, "x", "<Plug>(leap-forward-till)", "Leap forward till")
            set_if_unmapped({ "x", "o" }, "X", "<Plug>(leap-backward-till)", "Leap backward till")

            -- Searching in all windows (including the current one) on the tab page:
            function LeapAllWindows()
                require("leap").leap({
                    ["target-windows"] = vim.tbl_filter(function(win)
                        return vim.api.nvim_win_get_config(win).focusable
                    end, vim.api.nvim_tabpage_list_wins(0)),
                })
            end

            -- Bidirectional search in the current window is just a specific case of the
            -- multi-window mode - set `target-windows` to a table containing the current
            -- window as the only element:
            function LeapAllWindowBidirectional()
                require("leap").leap({ ["target-windows"] = { vim.api.nvim_get_current_win() } })
            end

            -- Map them to your preferred key, like:
            vim.keymap.set("n", "<leader>s", LeapAllWindows, { silent = true })
        end,
    },

    -- tmux replacement
    {
        event = "VeryLazy",
        "nikvdp/neomux",
        dependencies = {
            "mhinz/neovim-remote",
        },
    },
}
