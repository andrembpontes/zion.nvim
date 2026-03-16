-- Ignore
-- REMOVE THIS WHEN USING AS TEMPLATE
if true then
	return {}
end

-- To configure an LSP server, create a file at:
--   lsp/<server_name>.lua
--
-- The file should return a plain table with server options:
--
--   return {
--       filetypes = { "foo", "bar" },
--       root_markers = { "foo.config", ".git" },
--       settings = {
--           -- server-specific settings
--       },
--       on_attach = function(client, bufnr)
--           -- per-buffer setup
--       end,
--   }
--
-- Neovim 0.11+ auto-loads lsp/<name>.lua from the runtimepath.
-- Then ensure the server is listed in mason-lspconfig's ensure_installed
-- in lua/zion/plugins/coding/lsp.lua.

return {}
