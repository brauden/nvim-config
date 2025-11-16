---@type ChadrcConfig
local M = {}

M.base46 = {
  changed_themes = {
    onedark = {
      base_16 = {
        base00 = "#282936",
        base0B = "#60778a", -- strings
        base08 = "#c8ccd4",
        base0E = "#d45004", -- keywords
      },
      polish_hl = {
        treesitter = {
          ["@function.builtin"] = { bold = true },
          ["@function.call"] = { bold = true },
          ["@function.method.call"] = { bold = true },
          -- Make all keywords the same color
          ["@keyword"] = { fg = "#d45004" },
          ["@keyword.function"] = { fg = "#d45004" },
          ["@keyword.operator"] = { fg = "#d45004" },
          ["@keyword.return"] = { fg = "#d45004" },
          ["@keyword.repeat"] = { fg = "#d45004" },
          ["@keyword.conditional"] = { fg = "#d45004" },
          ["@keyword.import"] = { fg = "#d45004" },
          ["@keyword.import.python"] = { fg = "#d45004" },
          ["@include"] = { fg = "#d45004" },
          ["Include"] = { fg = "#d45004" },
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
