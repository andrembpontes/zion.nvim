return {
    {
        "neovim/nvim-lspconfig",

        dependencies = {
            { "artemave/workspace-diagnostics.nvim" },
        },

        opts = {
            servers = {
                -- ["ts_ls"] = {
                --     filetypes = {
                --         "typescript",
                --         "typescriptreact",
                --         "typescript.tsx",
                --         "javascript",
                --         "javascriptreact",
                --     },
                --
                --     cmd = { "typescript-language-server", "--stdio" },
                --
                --     install = function()
                --         return "tsserver"
                --     end,
                --
                --     -- on_attach = function(_client, bfnr)
                --     -- end,
                -- },
                ["vtsls"] = {
                    filetypes = {
                        "javascript",
                        "javascriptreact",
                        "javascript.jsx",
                        "typescript",
                        "typescriptreact",
                        "typescript.tsx",
                    },
                    settings = {
                        complete_function_calls = true,
                        vtsls = {
                            enableMoveToFileCodeAction = true,
                            autoUseWorkspaceTsdk = true,
                            experimental = {
                                completion = {
                                    enableServerSideFuzzyMatch = true,
                                },
                            },
                        },
                        typescript = {
                            updateImportsOnFileMove = { enabled = "always" },
                            suggest = {
                                completeFunctionCalls = true,
                            },
                            inlayHints = {
                                enumMemberValues = { enabled = true },
                                functionLikeReturnTypes = { enabled = true },
                                parameterNames = { enabled = "literals" },
                                parameterTypes = { enabled = true },
                                propertyDeclarationTypes = { enabled = true },
                                variableTypes = { enabled = false },
                            },
                        },
                    },

                    on_attach = function(client, bufnr)
                        require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
                    end,
                },
                ["eslint"] = {
                    on_attach = function(_, bufnr)
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            command = "EslintFixAll",
                        })
                    end,

                    install = function()
                        return "eslint_d"
                    end,

                    settings = {
                        codeAction = {
                            disableRuleComment = {
                                enable = true,
                                location = "separateLine"
                            },
                            showDocumentation = {
                                enable = true
                            }
                        },
                        codeActionOnSave = {
                            enable = false,
                            mode = "all"
                        },
                        experimental = {
                            useFlatConfig = false
                        },
                        format = true,
                        nodePath = "",
                        onIgnoredFiles = "off",
                        problems = {
                            shortenToSingleLine = false
                        },
                        quiet = false,
                        rulesCustomizations = {},
                        run = "onSave", -- "onType" | "onSave"
                        useESLintClass = false,
                        validate = "on",
                        workingDirectory = {
                            mode = "location"
                        }
                    },
                },
            },
        },
    },
}
