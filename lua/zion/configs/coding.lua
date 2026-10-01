local diagnostics_icons = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
}

local dap_icons = {
    Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
    Breakpoint = " ",
    BreakpointCondition = " ",
    BreakpointRejected = { " ", "DiagnosticError" },
    LogPoint = ".>",
}

-- Dap signs are defined here (before nvim-dap is loaded) so breakpoints and the
-- stopped line use these icons. nvim-dap only defines a sign when it is not
-- already defined, so pre-defining them is the supported way to override them.
vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
for name, sign in pairs(dap_icons) do
    sign = type(sign) == "table" and sign or { sign }
    vim.fn.sign_define(
        "Dap" .. name,
        { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
    )
end

vim.diagnostic.config({
    -- more info: https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.config()
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = diagnostics_icons.Error,
            [vim.diagnostic.severity.WARN] = diagnostics_icons.Warn,
            [vim.diagnostic.severity.HINT] = diagnostics_icons.Hint,
            [vim.diagnostic.severity.INFO] = diagnostics_icons.Info,
        },
    },
    underline = true, --underlines diagnostic messages
    update_in_insert = false,
    virtual_text = { spacing = 4, prefix = "●" },
    severity_sort = true,
})
