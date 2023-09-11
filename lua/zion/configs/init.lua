local M = {}

function M.setup(_opts)
    local function _load_all()
        -- load zion configs
        M.load("zion.configs.autocmds")
        M.load("zion.configs.coding")
        M.load("zion.configs.globals")
        M.load("zion.configs.neovide")
        M.load("zion.configs.winbar")

        -- load user configs
        local maybe_user_configs = M.load("configs")
        if (maybe_user_configs ~= nil) then
            pcall(maybe_user_configs.setup);
        end
    end

    if true or vim.fn.argc(-1) == 0 then
        -- autocmds and keymaps can wait to load
        vim.api.nvim_create_autocmd("User", {
            group = vim.api.nvim_create_augroup("LazyVim", { clear = true }),
            pattern = "VeryLazy",
            callback = function()
                _load_all()
            end,
        })
    else
        -- load them now so they affect the opened buffers
        _load_all()
    end
end

function M.load(name)
    local ok, result_or_error = pcall(require, name)
    if ok then
        print(name .. " successfully loaded")
        return result_or_error;
    else
        print("Error loading: " .. name)
        print(result_or_error)
    end
end

M.did_init = false
function M.init(_opts)
    if not M.did_init then
        M.did_init = true

        -- load options here, before lazy init while sourcing plugin modules
        -- this is needed to make sure options will be correctly applied
        -- after installing missing plugins
        M.load("zion.configs.options")

        local maybe_user_configs = M.load("configs")
        if (maybe_user_configs ~= nil) then
            pcall(maybe_user_configs.init);
        end
    end
end

return M
