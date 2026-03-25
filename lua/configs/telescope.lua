local previewers = require "telescope.previewers"

require("telescope").setup {
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
      keymaps = {
        copy_commit_patch = "<C-x>",
      },
    },
  },
}