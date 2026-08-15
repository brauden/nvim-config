-- Add the runtime/ subdirectory to rtp (main branch stores queries there)
local ts_path = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/runtime"
if not vim.list_contains(vim.opt.rtp:get(), ts_path) then
  vim.opt.rtp:prepend(ts_path)
end

-- Re-prepend config dir so local query overrides in queries/ take priority
local config_path = vim.fn.stdpath("config")
vim.opt.rtp:prepend(config_path)

-- The main branch has no `ensure_installed` option -- parsers are only ever installed by an
-- explicit install() call, so without this block nothing is installed and every treesitter
-- feature silently no-ops. Requires the `tree-sitter` CLI (brew install tree-sitter-cli).
local ensure_installed = {
  "bash",
  "c",
  "cpp",
  "css",
  "diff",
  "gitcommit",
  "go",
  "html",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "regex",
  "rust",
  "toml",
  "vim",
  "vimdoc",
  "yaml",
}

local installed = require("nvim-treesitter").get_installed()
local missing = vim.tbl_filter(function(lang)
  return not vim.tbl_contains(installed, lang)
end, ensure_installed)

if #missing > 0 then
  -- async; deliberately not waited on so startup isn't blocked
  require("nvim-treesitter").install(missing, { summary = true })
end

-- Enable treesitter highlighting and indentation for all filetypes with a parser
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    if pcall(vim.treesitter.start) then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})