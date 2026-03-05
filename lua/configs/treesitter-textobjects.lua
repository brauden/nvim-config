local ts_select = require "nvim-treesitter-textobjects.select"
local ts_swap = require "nvim-treesitter-textobjects.swap"
local ts_move = require "nvim-treesitter-textobjects.move"

require("nvim-treesitter-textobjects").setup {
  select = {
    lookahead = true,
    selection_modes = {
      ["@parameter.outer"] = "v",
      ["@function.outer"] = "V",
      ["@class.outer"] = "V",
    },
    include_surrounding_whitespace = true,
  },
  move = {
    set_jumps = true,
  },
}

local map = vim.keymap.set

-- Select keymaps
map({ "x", "o" }, "af", function()
  ts_select.select_textobject("@function.outer", "textobjects")
end, { desc = "Select outer part of a function" })

map({ "x", "o" }, "if", function()
  ts_select.select_textobject("@function.inner", "textobjects")
end, { desc = "Select inner part of a function" })

map({ "x", "o" }, "ac", function()
  ts_select.select_textobject("@class.outer", "textobjects")
end, { desc = "Select outer part of a class" })

map({ "x", "o" }, "ic", function()
  ts_select.select_textobject("@class.inner", "textobjects")
end, { desc = "Select inner part of a class region" })

map({ "x", "o" }, "as", function()
  ts_select.select_textobject("@local.scope", "locals")
end, { desc = "Select language scope" })

map({ "x", "o" }, "l=", function()
  ts_select.select_textobject("@assignment.lhs", "textobjects")
end, { desc = "Select left hand side of an assignment" })

map({ "x", "o" }, "r=", function()
  ts_select.select_textobject("@assignment.rhs", "textobjects")
end, { desc = "Select right hand side of an assignment" })

-- Swap keymaps
map("n", "<leader>nf", function()
  ts_swap.swap_next("@function.outer")
end, { desc = "Swap next function" })

map("n", "<leader>nc", function()
  ts_swap.swap_next("@class.outer")
end, { desc = "Swap next class" })

map("n", "<leader>pf", function()
  ts_swap.swap_previous("@function.outer")
end, { desc = "Swap previous function" })

map("n", "<leader>pc", function()
  ts_swap.swap_previous("@class.outer")
end, { desc = "Swap previous class" })

-- Move keymaps: goto_next_start
map({ "n", "x", "o" }, "]f", function()
  ts_move.goto_next_start("@function.outer", "textobjects")
end, { desc = "Next function start" })

map({ "n", "x", "o" }, "]]", function()
  ts_move.goto_next_start("@class.outer", "textobjects")
end, { desc = "Next class start" })

map({ "n", "x", "o" }, "<leader>pn", function()
  ts_move.goto_next_start("@parameter.inner", "textobjects")
end, { desc = "Next parameter" })

map({ "n", "x", "o" }, "]r", function()
  ts_move.goto_next_start("@return.outer", "textobjects")
end, { desc = "Next return start" })

map({ "n", "x", "o" }, "]w", function()
  ts_move.goto_next_start("@call.outer", "textobjects")
end, { desc = "Next call start" })

-- Move keymaps: goto_next_end
map({ "n", "x", "o" }, "]m", function()
  ts_move.goto_next_end("@function.outer", "textobjects")
end, { desc = "Next function end" })

map({ "n", "x", "o" }, "][", function()
  ts_move.goto_next_end("@class.outer", "textobjects")
end, { desc = "Next class end" })

map({ "n", "x", "o" }, "]a", function()
  ts_move.goto_next_end("@assignment.lhs", "textobjects")
end, { desc = "Next assignment end" })

-- Move keymaps: goto_previous_start
map({ "n", "x", "o" }, "[f", function()
  ts_move.goto_previous_start("@function.outer", "textobjects")
end, { desc = "Previous function start" })

map({ "n", "x", "o" }, "[[", function()
  ts_move.goto_previous_start("@class.outer", "textobjects")
end, { desc = "Previous class start" })

map({ "n", "x", "o" }, "<leader>pp", function()
  ts_move.goto_previous_start("@parameter.inner", "textobjects")
end, { desc = "Previous parameter" })

map({ "n", "x", "o" }, "[r", function()
  ts_move.goto_previous_start("@return.outer", "textobjects")
end, { desc = "Previous return start" })

map({ "n", "x", "o" }, "[w", function()
  ts_move.goto_previous_start("@call.outer", "textobjects")
end, { desc = "Previous call start" })

-- Move keymaps: goto_previous_end
map({ "n", "x", "o" }, "[m", function()
  ts_move.goto_previous_end("@function.outer", "textobjects")
end, { desc = "Previous function end" })

map({ "n", "x", "o" }, "[]", function()
  ts_move.goto_previous_end("@class.outer", "textobjects")
end, { desc = "Previous class end" })

map({ "n", "x", "o" }, "[a", function()
  ts_move.goto_previous_end("@assignment.lhs", "textobjects")
end, { desc = "Previous assignment end" })