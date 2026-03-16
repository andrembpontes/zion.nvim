return {
    filetypes = { "elixir", "eex", "heex", "surface" },
    root_markers = { ".lsp_root", "mix.exs", ".git" },
    settings = {
        elixirLS = {
            dialyzerEnabled = true,
            enableTestLenses = true,
            fetchDeps = true,
            suggestSpecs = true,
            autoBuild = true,
        },
    },
    on_attach = function()
        vim.keymap.set("i", ";;", "|>", { buffer = true, noremap = true })
    end,
}
