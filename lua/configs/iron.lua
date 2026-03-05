local iron = require "iron.core"

iron.setup {
  config = {
    repl_open_cmd = require("iron.view").split.horizontal.botright(15),
    repl_definition = {
      python = {
        command = { "ipython", "--no-autoindent" },
        format = require("iron.fts.common").bracketed_paste,
      },
    },
  },

  keymaps = {
    toggle_repl = "<space>rr",
    send_motion = "<leader>sc",
    visual_send = "<leader>sc",
    send_file = "<leader>sf",
    send_line = "<leader>sl",
    send_until_cursor = "<leader>su",
    cr = "<leader>s<cr>",
    interrupt = "<leader>s<leader>",
    exit = "<leader>sq",
    clear = "<leader>cl",
  },

  ignore_blank_lines = true,
}
