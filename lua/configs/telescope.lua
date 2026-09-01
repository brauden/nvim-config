local previewers = require "telescope.previewers"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

-- <CR> opens every <Tab>-selected entry, falling back to the default action
-- when nothing is multi-selected.
local function open_multi(prompt_bufnr)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local selection = picker:get_multi_selection()

  if vim.tbl_isempty(selection) then
    actions.select_default(prompt_bufnr)
    return
  end

  actions.close(prompt_bufnr)

  for _, entry in ipairs(selection) do
    local filename = entry.path or entry.filename or entry.value
    if type(filename) == "string" then
      vim.cmd.edit(vim.fn.fnameescape(filename))
      if entry.lnum then
        pcall(vim.api.nvim_win_set_cursor, 0, { entry.lnum, (entry.col or 1) - 1 })
      end
    end
  end
end

require("telescope").setup {
  defaults = {
    mappings = {
      i = { ["<CR>"] = open_multi },
      n = { ["<CR>"] = open_multi },
    },
  },
  pickers = {
    git_commits = {
      previewer = previewers.new_termopen_previewer {
        get_command = function(entry)
          return { "git", "show", "--stat", "--color", entry.value }
        end,
      },
    },
  },
  extensions = {
    advanced_git_search = {
      diff_plugin = "diffview",
      git_diff_flags = { "--stat" },
      keymaps = {
        copy_commit_patch = "<C-x>",
      },
    },
  },
}

