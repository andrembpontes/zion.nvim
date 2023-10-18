vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = { "*.tf", "*.tfvars" },
    group = vim.api.nvim_create_augroup('TerraformFiletypeOverride', {}),
    callback = function()
        vim.cmd('set filetype=terraform')
    end
})

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
