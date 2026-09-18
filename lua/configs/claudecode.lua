local M = {}

-- Claude runs in a tmux pane beside nvim rather than in an in-editor terminal, so
-- it survives nvim restarts and stays visible while a diff or a crit review is open.
-- The pane records its own id in a *window* option, which is what keeps two projects
-- in two tmux windows from stealing each other's Claude.
local function claude_pane()
  local id = vim.trim(vim.fn.system { "tmux", "show-option", "-wqv", "@claude_pane" })
  if id == "" then
    return nil
  end
  -- `tmux display-message -pt <id>` exits 0 even for a pane that no longer exists,
  -- so liveness has to be membership in the live pane list.
  local panes = vim.fn.systemlist { "tmux", "list-panes", "-a", "-F", "#{pane_id}" }
  if vim.v.shell_error ~= 0 then
    return nil
  end
  for _, pane in ipairs(panes) do
    if vim.trim(pane) == id then
      return id
    end
  end
  return nil
end

local function focus_claude()
  local id = claude_pane()
  if not id then
    return false
  end
  vim.fn.system { "tmux", "select-pane", "-t", id }
  return true
end

-- The external provider only tracks the `tmux` CLI process, which exits as soon as the
-- pane exists -- so its own toggle would spawn a second Claude every time. Focus first.
-- With args (--resume/--continue) we always spawn: a different session is the point.
local function open_or_focus(args)
  return function()
    if not args and focus_claude() then
      return
    end
    vim.cmd("ClaudeCode" .. (args and (" " .. args) or ""))
  end
end

M.keys = {
  { "<leader>a", nil, desc = "AI/Claude Code" },
  { "<leader>ac", open_or_focus(), desc = "Open/focus Claude" },
  { "<leader>af", open_or_focus(), desc = "Focus Claude" },
  { "<leader>ar", open_or_focus "--resume", desc = "Resume Claude" },
  { "<leader>aC", open_or_focus "--continue", desc = "Continue Claude" },
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
  { "<C-]>", open_or_focus(), desc = "Claude Code", mode = { "n", "x" } },
}

M.opts = {
  terminal = {
    provider = "external",
    provider_opts = {
      external_terminal_cmd = function(cmd, env)
        -- -fh splits the whole window, not the active pane: Claude gets a full-height
        -- right column even if the window is already split several ways.
        local args = { "tmux", "split-window", "-fh", "-l", "40%", "-c", vim.fn.getcwd() }
        -- A tmux pane inherits the server's environment, not this nvim's, so the port
        -- has to be passed explicitly -- otherwise Claude has to guess which nvim to
        -- attach to from the lockfiles in ~/.claude/ide/.
        for k, v in pairs(env) do
          vim.list_extend(args, { "-e", k .. "=" .. v })
        end
        vim.list_extend(args, { 'tmux set-option -w @claude_pane "$TMUX_PANE"; exec ' .. cmd })
        return args
      end,
    },
  },
}

-- focus_after_send is a no-op when Claude lives outside nvim; this event is the
-- documented substitute.
vim.api.nvim_create_autocmd("User", {
  pattern = "ClaudeCodeSendComplete",
  callback = focus_claude,
})

return M
