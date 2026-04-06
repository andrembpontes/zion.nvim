# AGENTS.md

Guidance for agentic coding tools working in this repository.

## 1) Project Context

- This is a NeoVim configuration module (`zion.nvim`), primarily Lua.
- It is intended to be consumed by a starter/user config, not run directly as-is.
- `init.lua` at repo root intentionally warns and exits when used directly.
- Main code lives under `lua/zion/**` and server-specific LSP overrides under `lsp/*.lua`.

## 2) Rules Files (Cursor / Copilot)

Checked locations at time of writing:

- `.cursor/rules/` -> not present
- `.cursorrules` -> not present
- `.github/copilot-instructions.md` -> not present

If any of these files are added later, treat them as higher-priority instructions and update this file.

## 3) Repository Layout

- `lua/zion/init.lua`: module entrypoint (`setup(opts)`).
- `lua/zion/configs/*.lua`: options, globals, autocmds, UI-level config.
- `lua/zion/plugins/*.lua`: plugin specs for Lazy-style plugin loading.
- `lua/zion/plugins/coding/**`: LSP, formatting, tests, snippets, DAP, etc.
- `lua/zion/plugins/coding/by-language/**`: language-specific plugin additions.
- `lsp/*.lua`: per-server LSP settings, auto-loaded by Neovim 0.11+ style config.
- `README.md`: minimal project-level readme.

## 4) Build / Lint / Test Commands

There is no single formal CI script in this repo (no `Makefile`, `justfile`, `package.json`, etc.).
Use the commands below depending on what is installed in the environment.

### 4.1 Formatting / Linting

- Format Lua (common):
  - `stylua .`
- Check Lua formatting without writing:
  - `stylua --check .`

Notes:

- No committed `stylua.toml` is present; follow existing file-local style when formatting.
- `-- stylua: ignore` appears in some files; preserve it where list/table layout is intentional.

### 4.2 Runtime Smoke Check

- Basic headless startup check (if your environment has a proper consumer config/runtime):
  - `nvim --headless "+qa"`

Important:

- Running this repo directly may show the intentional root `init.lua` warning and quit.
- Prefer smoke-checking through the starter/consumer setup that imports `zion`.

### 4.3 Tests

This repo does not include a standalone Lua unit test suite.
Test execution here is mostly editor-integrated (`neotest`) and project-language specific.

- NeoVim integrated tests: configured via `nvim-neotest/neotest`.
- Elixir adapter configured: `jfpedroza/neotest-elixir`.

If validating Elixir test flows in an Elixir project:

- Run all tests:
  - `mix test`
- Run one file:
  - `mix test test/path/to/file_test.exs`
- Run a single test by line (most important single-test command):
  - `mix test test/path/to/file_test.exs:123`

### 4.4 Single Test (Editor Workflow)

With `neotest` configured:

- Nearest test under cursor: `require("neotest").run.run()`
- Current file: `require("neotest").run.run(vim.fn.expand("%"))`
- Entire suite: `require("neotest").run.run(vim.loop.cwd())`

Use these when validating test plugin behavior or keymap integrations.

## 5) Code Style Guidelines

## 5.1 General Principles

- Keep changes minimal and local; avoid broad rewrites.
- Match the style already used in the target file.
- Prefer small, composable functions over large procedural blocks.
- Avoid introducing new dependencies unless required.

## 5.2 Lua Module Patterns

- Module helpers typically use:
  - `local M = {}`
  - function definitions on `M`
  - `return M`
- Plugin spec files typically return a table directly:
  - `return { { "author/plugin", opts = { ... } } }`
- Use `local` for all internal functions/variables.
- Do not create implicit globals.

## 5.3 Imports (`require`) and File Organization

- Keep `require` statements near first use unless used across many functions.
- For optional modules/integrations, use protected loading:
  - `local ok, mod = pcall(require, "module")`
  - early return or fallback when `ok == false`
- Group related setup logic together (opts, config, autocmds, keymaps).

## 5.4 Formatting Conventions

- Follow existing indentation in each file (many files use 4 spaces; some use tabs).
- Preserve trailing commas in multiline tables.
- Prefer readable multiline tables for plugin specs and mappings.
- Keep alignment only where already used; do not realign entire files gratuitously.
- Preserve intentional comments and `stylua: ignore` directives.

## 5.5 Types and Annotations

- LuaLS annotations are acceptable and already used (for example, `---@param`).
- Add annotations when they improve non-obvious APIs/utilities.
- Keep annotations accurate and concise; do not add noise everywhere.

## 5.6 Naming

- Use `snake_case` for local variables/functions.
- Use descriptive names for plugin config helpers (`configure_*`, `formatBuffer`, etc.).
- Keep names consistent with NeoVim/LSP vocabulary (`on_attach`, `opts`, `capabilities`).
- Use PascalCase only when mirroring established command/global names.

## 5.7 Error Handling and Resilience

- Prefer non-fatal behavior for optional integrations.
- Use `pcall` around dynamic `require` or risky callbacks.
- Fail soft where possible (print/log helpful context, avoid hard crashes).
- Use early returns to reduce nesting.
- For autocmd callbacks, keep side effects scoped and predictable.

## 5.8 Plugin Specification Conventions

- Common fields seen here: `event`, `cmd`, `keys`, `dependencies`, `opts`, `config`.
- Keep lazy-loading semantics intact unless explicitly changing load strategy.
- Add new plugin specs in the most relevant domain file (`coding`, `ui`, `git`, etc.).
- Put language-specific behavior under `by-language/` or `lsp/*.lua` where appropriate.

## 5.9 LSP-Specific Conventions

- Global defaults are configured in `lua/zion/plugins/coding/lsp.lua`.
- Per-server overrides belong in `lsp/<server>.lua` and should return a plain table.
- Typical keys: `filetypes`, `root_markers`, `settings`, `on_attach`.
- Respect root markers precedence (`.lsp_root`, then project markers like `.git`, `mix.exs`).

## 6) Agent Workflow Expectations

- Before editing, scan nearby files for local style and conventions.
- Prefer focused diffs; do not mass-format unrelated files.
- Do not remove disabled/experimental files unless requested (for example `_lsp.lua`).
- When changing behavior, include a brief rationale in commit/PR text.
- If test execution is not possible locally, state what was not validated and how to validate it.

## 7) Practical Verification Checklist

After code changes, run what applies:

- `stylua --check .` (or `stylua .` then re-check)
- A smoke startup check in a proper consumer environment
- Relevant language test command (for Elixir integrations, at least one `mix test ...:line`)

If a command cannot run due to missing tools/environment, report that explicitly.
