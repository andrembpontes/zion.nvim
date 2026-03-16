return {
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            { import = "zion.plugins.coding.by-language" },
        },

        config = function()
            -- Global defaults applied to every server
            vim.lsp.config('*', {
                capabilities = require('cmp_nvim_lsp').default_capabilities(
                    vim.lsp.protocol.make_client_capabilities()
                ),
                root_markers = { '.lsp_root', '.git' },
            })

            require("mason").setup()

            require("mason-lspconfig").setup({
                ensure_installed = {
                    'vtsls', 'eslint',
                    'lua_ls',
                    'pyright', 'ruff',
                    'rust_analyzer',
                    'elixirls',
                    'yamlls',
                    'jsonls',
                    'solargraph',
                    'terraformls',
                    'cssls',
                    'html',
                    'omnisharp',
                },
                automatic_enable = true,
            })
        end,
    },

    -- LSP hover signature
    {
        "ray-x/lsp_signature.nvim",
        event = "LspAttach",
        opts = {},
    },
}
