local M = {}

function M.setup(opts)
    require("zion.configs").init(opts)
    require("zion.configs").setup(opts)
end

return M
