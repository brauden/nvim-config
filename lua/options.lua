require "nvchad.options"

vim.wo.relativenumber = true
vim.opt.colorcolumn = "80"
vim.g.doge_doc_standard_python = "google"
vim.o.shell = "zsh"
vim.opt.conceallevel = 1
vim.opt.spelllang = { "en_us" }
vim.opt.langmap =
  "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"
vim.opt.foldmethod = "syntax"
vim.opt.wildignore = { "__pycache__" }
