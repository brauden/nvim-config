return {
  "s1n7ax/nvim-window-picker",
  name = "window-picker",
  version = "2.*",
  event = "VeryLazy",
  opts = {
    hint = "floating-big-letter",
    -- home row keys, so picking never needs a hand move
    selection_chars = "FJDKSLA;CMRUEIWOQP",
    show_prompt = false,
    filter_rules = {
      autoselect_one = true,
      include_current_win = false,
      bo = {
        filetype = { "NvimTree", "neo-tree", "notify", "snacks_notif", "noice" },
        buftype = { "terminal", "quickfix" },
      },
    },
  },
  config = function(_, opts)
    require("window-picker").setup(opts)
  end,
  keys = {
    {
      "<leader>wp",
      function()
        local win = require("window-picker").pick_window()
        if win then
          vim.api.nvim_set_current_win(win)
        end
      end,
      desc = "Pick window",
    },
    {
      "<leader>ws",
      function()
        local target = require("window-picker").pick_window { include_current_win = true }
        if not target then
          return
        end
        local current = vim.api.nvim_get_current_win()
        if target == current then
          return
        end
        local current_buf, target_buf = vim.api.nvim_win_get_buf(current), vim.api.nvim_win_get_buf(target)
        vim.api.nvim_win_set_buf(current, target_buf)
        vim.api.nvim_win_set_buf(target, current_buf)
        vim.api.nvim_set_current_win(target)
      end,
      desc = "Swap window with picked",
    },
  },
}
