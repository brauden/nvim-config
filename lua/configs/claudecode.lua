local toggle_key = "<C-]>"

local M = {}

M.keys = {
  { "<leader>a", nil, desc = "AI/Claude Code" },
  { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
  { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
  { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
  { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
  { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
  { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
  { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
  {
    "<leader>as",
    "<cmd>ClaudeCodeTreeAdd<cr>",
    desc = "Add file",
    ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
  },
  { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
  { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
  { toggle_key, "<cmd>ClaudeCodeFocus<cr>", desc = "Claude Code", mode = { "n", "x" } },
}

M.opts = {
  terminal = {
    ---@module "snacks"
    ---@type snacks.win.Config|{}
    snacks_win_opts = {
      position = "float",
      width = 0.9,
      height = 0.9,
      keys = {
        claude_hide = {
          toggle_key,
          function(self)
            local buf = self.buf
            if buf and vim.api.nvim_buf_is_valid(buf) then
              local chan = vim.bo[buf].channel
              if chan and chan > 0 then
                vim.api.nvim_chan_send(chan, "\x15") -- Ctrl-U: clear current input line
              end
            end
            self:hide()
          end,
          mode = "t",
          desc = "Hide",
        },
      },
    },
  },
}

return M
