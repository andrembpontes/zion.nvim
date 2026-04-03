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
            local ok, mod = pcall(require, "nvim-treesitter.config")
            if not ok then
                ok, mod = pcall(require, "nvim-treesitter.configs")
            end
            if ok and mod and type(mod.setup) == "function" then
                mod.setup(opts)
            end
        end,
    },
}
