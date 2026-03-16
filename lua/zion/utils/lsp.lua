local plugin_utils = require('zion.utils.plugins')

local M = {}

function M.get_default_config(lsp)
    local path = plugin_utils.get_plugin_root_dir('nvim-lspconfig')
    local config = dofile(path .. '/lsp/' .. lsp .. '.lua')
    return config
end

return M
