return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                ["yamlls"] = {
                    filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
                },
            },
        },
    },
}
