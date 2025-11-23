local fzf = require "fzf-lua"

fzf.setup {
  git = {
    commits = {
      prompt = "Commits❯ ",
      cmd = [[git log --color --pretty=format:"%C(yellow)%h%Creset ]]
        .. [[%Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset"]],
      preview = "git show --stat --color {1}",
      preview_pager = false,
      actions = {
        ["enter"] = fzf.actions.git_checkout,
        -- remove `exec_silent` or set to `false` to exit after yank
        ["ctrl-y"] = { fn = fzf.actions.git_yank_commit, exec_silent = true },
      },
    },
  },
}
