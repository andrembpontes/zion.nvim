return {
    {
        "andrembpontes/project.nvim",

        -- TODO replace with original repo once PR gets merged
        -- https://github.com/ahmedkhalf/project.nvim/pull/136
        --"ahmedkhalf/project.nvim",

        dir = '~/development/project.nvim',
        opts = {
            detection_methods = { "lsp", "pattern" },
            patterns = { ".git" },
            -- Table of lsp clients to ignore by name
            -- eg: { "efm", ... }
            ignore_lsp = { "efm" },

            datapath = vim.fn.stdpath("data"),

            -- What scope to change the directory, valid options are
            -- * global (default)
            -- * tab
            -- * win
            scope_chdir = 'global',
        },

        main = 'project_nvim',
        config = true,
    },
}
