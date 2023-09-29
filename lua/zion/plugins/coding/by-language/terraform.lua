print('TerraformLS set')

return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                ["terraformls"] = function(_, opts)
                    local util = require("lspconfig").util
                    return {
                        filetypes = { "terraform", "hcl", "terraform-vars" },
                    }
                end,
            },
        },
    },
}
