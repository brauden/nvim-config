-- Step through trouble's items when it's open (covers telescope results that never
-- reach the quickfix list), otherwise fall back to plain :cnext/:cprev.
local function step(direction)
  return function()
    local trouble = require "trouble"
    if trouble.is_open() then
      trouble[direction] { skip_groups = true, jump = true }
      return
    end
    local cmd = direction == "next" and vim.cmd.cnext or vim.cmd.cprev
    local ok, err = pcall(cmd, { count = vim.v.count1 })
    if not ok then
      vim.notify(err:gsub("^Vim:", ""), vim.log.levels.WARN)
    end
  end
end

return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  -- <leader>x is NvChad's buffer close, so trouble's usual <leader>x* keys live under <leader>q
  keys = {
    { "<leader>qq", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble workspace diagnostics" },
    { "<leader>qb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Trouble buffer diagnostics" },
    { "<leader>qs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Trouble symbols" },
    -- replaces nvim's built-in grr (vim.lsp.buf.references)
    { "grr", "<cmd>Trouble lsp toggle focus=false<cr>", desc = "Trouble LSP refs/defs" },
    { "<leader>qf", "<cmd>Trouble qflist toggle<cr>", desc = "Trouble quickfix list" },
    { "<leader>qL", "<cmd>Trouble loclist toggle<cr>", desc = "Trouble location list" },
    { "<leader>qc", "<cmd>Trouble close<cr>", desc = "Trouble close" },
    { "]q", step "next", desc = "Next trouble/quickfix item" },
    { "[q", step "prev", desc = "Prev trouble/quickfix item" },
  },
  opts = {
    modes = {
      -- outline of the whole file: a third of the screen on the left fits far more
      -- entries than trouble's default 10-line bottom split
      symbols = {
        win = { position = "left", size = 0.33 },
      },
      lsp = {
        win = { position = "left", size = 0.33 },
      },
    },
  },
}
