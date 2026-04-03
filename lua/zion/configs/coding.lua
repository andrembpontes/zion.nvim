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
