-- Neovim's builtin terminal doesn't inherit kitty's palette, and NvChad
-- overrides it with the editor theme (onedark). Mirror ~/.config/kitty/dracula.conf
-- here so :terminal / the float term look like a normal kitty pane.

local M = {}

-- ANSI 0-15, same order and values as kitty's dracula.conf
local ansi = {
  "#21222c", -- black
  "#ff5555", -- red
  "#50fa7b", -- green
  "#f1fa8c", -- yellow
  "#bd93f9", -- blue
  "#ff79c6", -- magenta
  "#8be9fd", -- cyan
  "#f8f8f2", -- white
  "#6272a4", -- bright black
  "#ff6e6e", -- bright red
  "#69ff94", -- bright green
  "#ffffa5", -- bright yellow
  "#d6acff", -- bright blue
  "#ff92df", -- bright magenta
  "#a4ffff", -- bright cyan
  "#ffffff", -- bright white
}

local bg = "#282a36"
local fg = "#f8f8f2"
local border = "#6272a4"

local function set_highlights()
  vim.api.nvim_set_hl(0, "TermNormal", { fg = fg, bg = bg })
  vim.api.nvim_set_hl(0, "TermBorder", { fg = border, bg = bg })
  vim.api.nvim_set_hl(0, "TermVisual", { fg = "#ffffff", bg = "#44475a" })
end

M.setup = function()
  for i, color in ipairs(ansi) do
    vim.g["terminal_color_" .. (i - 1)] = color
  end

  set_highlights()
  -- base46 reapplies highlights on theme switch / transparency toggle
  vim.api.nvim_create_autocmd("ColorScheme", { callback = set_highlights })
end

return M
