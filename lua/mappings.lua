require "nvchad.mappings"

local live_grep_args_shortcuts = require "telescope-live-grep-args.shortcuts"

local map = vim.keymap.set

vim.api.nvim_create_user_command("Gcfir", require("fugitive-difftool").git_cfir, {})
-- To the last
vim.api.nvim_create_user_command("Gcla", require("fugitive-difftool").git_cla, {})
-- To the next
vim.api.nvim_create_user_command("Gcn", require("fugitive-difftool").git_cn, {})
-- To the previous
vim.api.nvim_create_user_command("Gcp", require("fugitive-difftool").git_cp, {})
-- To the currently selected
vim.api.nvim_create_user_command("Gcc", require("fugitive-difftool").git_cc, {})

-- gitsigns
map("n", "<leader>ghs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
map("n", "<leader>gbl", "<cmd>Gitsigns blame<CR>", { desc = "Gitsign blame" })
map("n", "<leader>ghr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
map("n", "<leader>gS", "<cmd>Gitsigns stage_buffer<CR>", { desc = "Stage buffer" })
map("n", "<leader>gR", "<cmd>Gitsigns reset_buffer<CR>", { desc = "Reset buffer" })
map("n", "]g", "<cmd>Gitsigns next_hunk<CR>", { desc = "Next Hunk" })
map("n", "[g", "<cmd>Gitsigns prev_hunk<CR>", { desc = "Previous Hunk" })

-- fugitive
map("n", "<leader>gg", "<cmd>Git<CR>", { desc = "Git status" })
map("n", "<leader>gd", "<cmd>Gvdiffsplit<CR>", { desc = "Git vsplit" })
map("n", "<leader>gvd", "<cmd>Gvdiffsplit!<CR>", { desc = "Git three vsplit" })
map("n", "<leader>gld", "<cmd>DiffviewFileHistory %<CR>", { desc = "Git history of a file" })

-- telescope
map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Git commits" })
map("n", "<leader>gs", "<cmd>Telescope git_stash<CR>", { desc = "Git stash" })
map("n", "<leader>gbb", "<cmd>Telescope git_branches<CR>", { desc = "Git branches" })
map(
  "n",
  "<leader>gll",
  "<cmd>Telescope advanced_git_search search_log_content<CR>",
  { desc = "Search git log content" }
)
map("n", "<leader>glf", "<cmd>Telescope advanced_git_search diff_commit_file<CR>", { desc = "Diff commit file" })
map("n", "<leader>glb", "<cmd>Telescope advanced_git_search diff_branch_file<CR>", { desc = "Diff branch file" })
map("n", "<leader>fs", live_grep_args_shortcuts.grep_word_under_cursor, { desc = "Search word under cursor" })
map("n", "<leader>fu", "<cmd>Telescope zoxide list<CR>", { desc = "Zoxide directories" })
map("n", "<leader>fh", "<cmd>Telescope command_history <CR>", { desc = "Command history" })
map("n", "<leader>fj", "<cmd>Telescope jumplist <CR>", { desc = "Jumplist" })
map("n", "<leader>fd", "<cmd>Telescope diagnostics <CR>", { desc = "Diagnostics" })
map("n", "<leader>fw", "<cmd>Telescope live_grep_args<CR>", { desc = "Live grep with args" })

-- zenmode
map("n", "<leader>z", "<cmd>ZenMode<CR>", { desc = "Toggle Zen Mode" })

-- dignostics
map("n", "<leader>ldi", "<cmd> lua vim.diagnostic.config{virtual_text = true}<CR>", { desc = "Turn on diagnostic" })
map("n", "<leader>ldo", "<cmd> lua vim.diagnostic.config{virtual_text = false}<CR>", { desc = "Turn off diagnostic" })

-- spell
map("n", "<leader>ts", "<cmd>set invspell<cr>", { desc = "Toggle spell" })

-- pandoc
map("v", "<leader>mt", "!pandoc -t markdown-simple_tables<CR>", { desc = "Format MD table" })

-- TSContext
map("n", "<leader>tc", "<cmd>TSContext toggle <CR>", { desc = "Toggle TSContext" })
map(
  "n",
  "<leader>th",
  "<cmd>source ~/.config/nvim/after/plugin/diff_highlight.lua <CR>",
  { desc = "Turn on diff syntax" }
)

local nomap = vim.keymap.del

-- remove default keymaps
nomap("n", "<leader>h")
nomap("n", "<leader>v")
nomap("n", "<leader>cm")
nomap("n", "<leader>fm")
map("n", "<leader>fm", "<cmd>Telescope marks <CR>", { desc = "Find marks" })
nomap("n", "<leader>gt")
nomap("n", "<leader>pt")
nomap("i", "<C-h>")
nomap("i", "<C-j>")
nomap("i", "<C-l>")
nomap("i", "<C-k>")
nomap("n", "<leader>n")
nomap("n", "<Tab>")

-- switch languages
map("n", "<leader>rr", "<cmd>set keymap=russian-jcukenwin<CR>", { desc = "Russian Keyboard" })
map("n", "<leader>rk", "<cmd>set keymap=kazakh-jcuken<CR>", { desc = "Kazakh Keyboard" })
map("n", "<leader>re", '<cmd>set keymap=""<CR>', { desc = "English Keyboard" })

-- tmux-mapping
map("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", { silent = true })
map("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", { silent = true })
map("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", { silent = true })
map("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", { silent = true })
map("n", "<C-\\>", "<Cmd>TmuxNavigatePrevious<CR>", { silent = true })

map("t", "<C-j>", [[<C-\><C-n>]])
map("t", "<C-h>", [[<Cmd>wincmd h<CR>]])
map("t", "<C-l>", [[<Cmd>wincmd l<CR>]])

map("n", "<leader>nn", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>np", "<cmd>bprev<CR>", { desc = "Previous buffer" })
