local M = {}

---@param name string
function M.get_opts(name)
    local plugin = require("lazy.core.config").plugins[name]
    if not plugin then
        return {}
    end
    local Plugin = require("lazy.core.plugin")
    return Plugin.values(plugin, "opts", false)
end

---@param plugin string
function M.has(plugin)
    return require("lazy.core.config").plugins[plugin] ~= nil
end

---@param plugin string
function M.get_plugin_root_dir(plugin)
    return vim.fn.stdpath("data") .. "/lazy/" .. plugin
end

return M
