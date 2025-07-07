return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        build = ":TSUpdate",
        dependencies = {
            -- { "JoosepAlviste/nvim-ts-context-commentstring" },
            { "nvim-treesitter/nvim-treesitter-context", config = true },
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
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}
