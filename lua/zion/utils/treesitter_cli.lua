local M = {}

M.PACKAGE = "tree-sitter-cli"
M.MIN_VERSION = "0.26.1"
M.BIN_DIR = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin")

--- `mason.setup()` also prepends its bin dir, but plugin load order is not guaranteed
function M.prepend_path()
    local bin = M.BIN_DIR
    if not (vim.env.PATH or ""):find(bin, 1, true) then
        vim.env.PATH = bin .. ":" .. (vim.env.PATH or "")
    end
end

---@return string
function M.executable()
    return vim.fs.joinpath(M.BIN_DIR, "tree-sitter")
end

---@return table? # parsed from `tree-sitter --version`
function M.installed_version()
    local bin = M.executable()
    if vim.fn.executable(bin) == 0 then
        return nil
    end
    return vim.version.parse(vim.fn.system({ bin, "--version" }))
end

---@param min_version string
---@return boolean satisfied
---@return table? installed
local function is_satisfied(min_version)
    local installed = M.installed_version()
    if not installed then
        return false, nil
    end
    return not vim.version.lt(installed, vim.version.parse(min_version)), installed
end

--- mason registers its registry sources (and prepends its bin dir) in `setup()`
---@return boolean
local function ensure_mason()
    local ok, mason = pcall(require, "mason")
    if not ok then
        return false
    end
    if not mason.has_setup then
        pcall(mason.setup)
    end
    return true
end

--- Ensures `tree-sitter-cli` is installed and, optionally, up to date, using mason.
--- Runs asynchronously; `callback(ok)` fires once a usable CLI is on PATH.
---@param opts? { auto_update?: boolean, min_version?: string }
---@param callback fun(ok: boolean)
function M.ensure(opts, callback)
    opts = opts or {}
    local min_version = opts.min_version or M.MIN_VERSION

    M.prepend_path()

    if not ensure_mason() then
        vim.notify("treesitter: mason.nvim not available, leaving tree-sitter-cli untouched", vim.log.levels.WARN)
        return callback(is_satisfied(min_version))
    end

    local ok, registry = pcall(require, "mason-registry")
    if not ok then
        vim.notify("treesitter: mason-registry not available, leaving tree-sitter-cli untouched", vim.log.levels.WARN)
        return callback(is_satisfied(min_version))
    end

    local satisfied = is_satisfied(min_version)
    if satisfied and not opts.auto_update then
        return callback(true)
    end

    -- a no-op while mason's registry cache is fresh (24h by default)
    registry.refresh(function()
        local package_ok, package = pcall(registry.get_package, M.PACKAGE)
        if not package_ok then
            vim.notify(("treesitter: %s is missing from the mason registry"):format(M.PACKAGE), vim.log.levels.ERROR)
            return callback(satisfied)
        end

        local satisfied_now, installed = is_satisfied(min_version)
        local latest = vim.version.parse(package:get_latest_version())
        if satisfied_now and (not opts.auto_update or not vim.version.lt(installed, latest)) then
            return callback(true)
        end
        if package:is_installing() then
            return callback(satisfied_now)
        end

        vim.notify(("treesitter: installing %s %s with mason"):format(M.PACKAGE, tostring(latest)))
        package:install({ force = true }, function(success, err)
            vim.schedule(function()
                M.prepend_path()
                if success then
                    vim.notify(
                        ("treesitter: %s %s ready"):format(M.PACKAGE, tostring(M.installed_version()))
                    )
                    return callback(true)
                end
                vim.notify(
                    ("treesitter: %s installation failed: %s"):format(M.PACKAGE, tostring(err)),
                    vim.log.levels.ERROR
                )
                callback(false)
            end)
        end)
    end)
end

return M
