local M = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "toml",
    "yaml",
    "json",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
    "vim",
    "vimdoc",
    "query",
    "python",
    "sql",
  },
  indent = {
    enable = true,
  },
  highlight = {
    enable = true,
  },
  injections = {
    enable = true,
  },
  -- incremental_selection = {
  --   enable = true,
  --   keymaps = {
  --     init_selection = "<leader>ss", -- set to `false` to disable one of the mappings
  --     node_incremental = "<leader>si",
  --     scope_incremental = "<leader>sc",
  --     node_decremental = "<leader>sd",
  --   },
  -- },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = { query = "@function.outer", desc = "Select outer part of a function" },
        ["if"] = { query = "@function.inner", desc = "Select inner part of a function" },
        ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
        ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
        ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },
      },
      selection_modes = {
        ["@parameter.outer"] = "v", -- charwise
        ["@function.outer"] = "V", -- linewise
        ["@class.outer"] = "V", -- blockwise
      },
      include_surrounding_whitespace = true,
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>np"] = "@parameter.inner",
        ["<leader>nf"] = "@function.outer",
      },
      swap_previous = {
        ["<leader>pp"] = "@parameter.inner",
        ["<leader>pf"] = "@function.outer",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]]"] = "@class.outer",
        ["<leader>pn"] = "@parameter.inner",
        ["]r"] = "@return.outer",
        ["]w"] = "@call.outer",
      },
      goto_next_end = {
        ["]m"] = "@function.outer",
        ["]["] = "@class.outer",
        ["]a"] = "@assignment.lhs",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[["] = "@class.outer",
        ["<leader>pp"] = "@parameter.inner",
        ["[r"] = "@return.outer",
        ["[w"] = "@call.outer",
      },
      goto_previous_end = {
        ["[m"] = "@function.outer",
        ["[]"] = "@class.outer",
        ["[a"] = "@assignment.lhs",
      },
      goto_next = {},
      goto_previous = {},
    },
  },
}

return M
