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
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<leader>ss", -- set to `false` to disable one of the mappings
      node_incremental = "<leader>si",
      scope_incremental = "<leader>sc",
      node_decremental = "<leader>sd",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
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
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]]"] = { query = "@class.outer", desc = "Next class start" },
        ["]l"] = "@loop.outer",
        ["]p"] = "@parameter.inner",
        ["]b"] = "@block.inner",
        ["]r"] = "@return.outer",
        ["]w"] = "@call.outer",
        ["]s"] = "@assignment.rhs",
      },
      goto_next_end = {
        ["]m"] = "@function.outer",
        ["]["] = "@class.outer",
        ["]a"] = "@assignment.lhs",
        ["]B"] = "@block.inner",
        ["]z"] = "@loop.inner",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[["] = "@class.outer",
        ["[p"] = "@parameter.inner",
        ["[l"] = "@loop.outer",
        ["[b"] = "@block.inner",
        ["[r"] = "@return.outer",
        ["[w"] = "@call.outer",
        ["[s"] = "@assignment.rhs",
      },
      goto_previous_end = {
        ["[m"] = "@function.outer",
        ["[]"] = "@class.outer",
        ["[a"] = "@assignment.lhs",
        ["[B"] = "@block.inner",
        ["[z"] = "@loop.inner",
      },
      goto_next = {},
      goto_previous = {},
    },
  },
}

return M
