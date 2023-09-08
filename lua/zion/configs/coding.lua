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

for name, icon in pairs(diagnostics_icons) do
    name = "DiagnosticSign" .. name
    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
end

vim.diagnostic.config({
    -- more info: https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.config()
    underline = true, --underlines diagnostic messages
    update_in_insert = false,
    virtual_text = { spacing = 4, prefix = "●" },
    severity_sort = true,
})
