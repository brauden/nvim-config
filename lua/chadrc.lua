---@type ChadrcConfig
local M = {}

M.base46 = {
  changed_themes = {
    onedark = {
      base_16 = {
        base0B = "#60778a", -- strings
        base0C = "#dbc202",
        base0A = "#dbc202", -- classes
        base08 = "#c8ccd4",
        base00 = "#282936",
        base0D = "#C678DD", -- purple for functions/methods
        base0E = "#D19A66", -- keywords
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
