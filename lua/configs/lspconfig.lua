-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

vim.lsp.config("*", { on_attach = on_attach, capabilities = capabilities, on_init = on_init })

vim.lsp.enable "lua_ls"
vim.lsp.enable "pyright"

vim.diagnostic.config {
  virtual_text = false,
}
vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { fg = "#ffffff", bg = "#5f87af", bold = true })
