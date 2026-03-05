-- Add the runtime/ subdirectory to rtp (main branch stores queries there)
local ts_path = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/runtime"
if not vim.list_contains(vim.opt.rtp:get(), ts_path) then
  vim.opt.rtp:prepend(ts_path)
end

-- Enable treesitter highlighting and indentation for all filetypes with a parser
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    if pcall(vim.treesitter.start) then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})