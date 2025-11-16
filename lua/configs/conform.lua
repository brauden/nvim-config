local uv_ruff = "/Users/db393/.local/bin/ruff"
local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "uv_ruff_fix", "uv_ruff_format", "uv_isort" },
    css = { "prettier" },
    html = { "prettier" },
  },

  formatters = {
    uv_ruff_fix = {
      command = uv_ruff,
      args = { "check", "--fix", "--stdin-filename", "$FILENAME" },
      stdin = true,
    },

    uv_ruff_format = {
      command = uv_ruff,
      args = { "format", "-", "--stdin-filename", "$FILENAME" },
      stdin = true,
    },

    uv_isort = {
      command = uv_ruff,
      args = { "check", "--fix", "--select", "I", "--stdin-filename", "$FILENAME" },
      stdin = true,
    },
  },

  format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
}
require("conform").setup(options)
