---@type ChadrcConfig
local M = {}

M.base46 = {
  changed_themes = {
    onedark = {
      base_16 = {
        base0B = "#60778a",
        base0C = "#dbc202",
        base0A = "#dbc202",
        base08 = "#c8ccd4",
        base00 = "#282936",
      },
      polish_hl = {
        treesitter = {
          ["@function.builtin"] = { bold = true },
          ["@function.call"] = { bold = true },
          ["@function.method.call"] = { bold = true },
        },
      },
    },
  },
}

M.ui = {
  statusline = {
    theme = "vscode_colored",
  },
}

M.term = {
  float = {
    row = 0.2,
    col = 0.2,
    width = 0.6,
    height = 0.5,
    border = "single",
  },
}

return M
