return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false, -- upstream: this plugin does not support lazy-loading
        build = ":TSUpdate",
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-context", config = true },
        },
        opts = {
            -- tiers ("stable", "unstable", "unmaintained") and/or explicit languages,
            -- auto-installed on startup; "stable" alone is only a handful of parsers
            parsers = { "stable", "unstable" },

            -- tree-sitter-cli is managed through mason: Debian's package is older
            -- than the minimum nvim-treesitter requires
            cli = { auto_update = true },

            -- highlighting/indentation are Neovim core features since 0.12,
            -- nvim-treesitter only ships the queries now
            highlight = true,
            indent = true,
        },
        config = function(_, opts)
            local ts = require("nvim-treesitter")

            -- parsers/queries are installed into stdpath("data") .. "/site"
            -- (prepended to runtimepath, so it wins over plugin dirs)
            ts.setup({ install_dir = opts.install_dir })

            -- parser installs shell out to tree-sitter-cli, so make sure it exists first
            -- (no-op for parsers that are already installed)
            require("zion.utils.treesitter_cli").ensure(opts.cli, function(ok)
                if ok then
                    ts.install(opts.parsers)
                end
            end)

            if not (opts.highlight or opts.indent) then
                return
            end

            -- core only starts treesitter for the filetypes it ships parsers for
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("ZionTreesitter", { clear = true }),
                callback = function()
                    local buf = vim.api.nvim_get_current_buf()
                    local ok, parser = pcall(vim.treesitter.get_parser, buf)
                    if not (ok and parser) then
                        return -- no parser installed for this filetype
                    end
                    if opts.highlight and not vim.treesitter.highlighter.active[buf] then
                        pcall(vim.treesitter.start, buf)
                    end
                    if opts.indent then
                        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })
        end,
    },
}
