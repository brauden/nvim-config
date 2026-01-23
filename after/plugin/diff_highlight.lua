-- ensure diff groups don't override syntax foreground
vim.cmd([[
  hi! DiffAdd    guifg=NONE ctermfg=NONE
  hi! DiffChange guifg=NONE ctermfg=NONE
  hi! DiffDelete guifg=NONE ctermfg=NONE
]])
