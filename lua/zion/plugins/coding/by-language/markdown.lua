return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },
    {

        'jakewvincent/mkdnflow.nvim',
        ft = {
            'markdown',
        },
        opts = {
            mappings = {
                MkdnEnter = { { 'i', 'n', 'v' }, '<CR>' }
                -- This monolithic command has the aforementioned
                -- insert-mode-specific behavior and also will trigger row jumping in tables. Outside
                -- of lists and tables, it behaves as <CR> normally does.
                -- MkdnNewListItem = {'i', '<CR>'} -- Use this command instead if you only want <CR> in
                -- insert mode to add a new list item (and behave as usual outside of lists).
            },

            to_do = {
                statuses = {
                    not_started = { marker = ' ' },
                    in_progress = { marker = '-' },
                    complete = { marker = { 'X', 'x' } },
                },
                status_order = { 'not_started', 'in_progress', 'complete' },
                status_propagation = { up = true, down = true },
            },

        },
        config = true,
    },
}
