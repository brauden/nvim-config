-- ruff is installed globally via `uv tool install ruff`; uv links executables into ~/.local/bin.
-- Point at it explicitly rather than using bare "ruff" so this can't resolve to a Mason copy --
-- NvChad prepends Mason's bin dir to vim.env.PATH.
local uv_ruff = vim.fn.expand "~/.local/bin/ruff"

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
    css = { "prettier" },
    html = { "prettier" },
  },

  -- Reuse conform's built-in ruff formatters and override only the binary. They already pass
  -- --exit-zero (so remaining unfixable lints don't abort the chain), --force-exclude, --no-cache,
  -- and resolve cwd to the nearest pyproject.toml/ruff.toml so per-project ruff config applies.
  formatters = {
    ruff_fix = { command = uv_ruff },
    ruff_organize_imports = { command = uv_ruff },
    ruff_format = { command = uv_ruff },
  },

  format_on_save = { timeout_ms = 2000, lsp_format = "fallback" },
}

require("conform").setup(options)
