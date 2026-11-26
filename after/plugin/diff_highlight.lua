-- Muted diff colors tuned for the #282936 background.
-- Only backgrounds are set (fg = NONE) so syntax highlighting stays visible.
local function set_diff_hl()
  local hl = vim.api.nvim_set_hl
  hl(0, "DiffAdd", { bg = "#2a3a35" }) -- added lines: faint green
  hl(0, "DiffChange", { bg = "#2e3144" }) -- changed lines: faint blue-grey
  hl(0, "DiffText", { bg = "#3d4866" }) -- changed text within a line: stronger blue
  hl(0, "DiffTextAdd", { bg = "#30483d" }) -- new text inside a changed block: green, like DiffAdd
  hl(0, "DiffDelete", { bg = "#352a35", fg = "#4a3a48" }) -- deleted / filler lines: faint red
  hl(0, "DiffviewDiffAddAsDelete", { bg = "#3a2a33" })
  hl(0, "DiffviewDiffDeleteDim", { fg = "#3e4152" })
end

set_diff_hl()

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("MutedDiffColors", { clear = true }),
  callback = set_diff_hl,
})

-- Draw filler lines (where the other side has extra lines) as subtle diagonals.
vim.opt.fillchars:append { diff = "╱" }
