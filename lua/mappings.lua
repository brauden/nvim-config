require "nvchad.mappings"

local map = vim.keymap.set

-- gitsigns
map("n", "<leader>gsh", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
map("n", "<leader>gb", "<cmd>Gitsigns blame<CR>", { desc = "Gitsign blame" })
map("n", "<leader>grh", "<cmd>Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
map("n", "<leader>gS", "<cmd>Gitsigns stage_buffer<CR>", { desc = "Stage buffer" })
map("n", "<leader>gR", "<cmd>Gitsigns reset_buffer<CR>", { desc = "Reset buffer" })
map("n", "]g", "<cmd>Gitsigns next_hunk<CR>", { desc = "Next Hunk" })
map("n", "[g", "<cmd>Gitsigns prev_hunk<CR>", { desc = "Previous Hunk" })

-- fugitive
map("n", "<leader>gg", "<cmd>Git<CR>", { desc = "Git status" })
map("n", "<leader>gd", "<cmd>Gvdiffsplit<CR>", { desc = "Git vsplit" })
map("n", "<leader>gvd", "<cmd>Gvdiffsplit!<CR>", { desc = "Git three vsplit" })
map("n", "<leader>gl", "<cmd>0Gllog<CR>", { desc = "Git history of a file" })

-- telescope
map("n", "<leader>fs", "<cmd>Telescope spell_suggest<CR>", { desc = "Spell suggest" })
map("n", "<leader>fgc", "<cmd>FzfLua git_commits<CR>", { desc = "Git commits" })
map("n", "<leader>fgt", "<cmd>FzfLua git_status <CR>", { desc = "Git status" })
map("n", "<leader>fgs", "<cmd>Telescope git_stash <CR>", { desc = "Git stash" })
map("n", "<leader>fgb", "<cmd>Telescope git_branches <CR>", { desc = "Git branches" })
map("n", "<leader>fm", "<cmd>Telescope marks <CR>", { desc = "Find marks" })
map("n", "<leader>fh", "<cmd>Telescope command_history <CR>", { desc = "Command history" })
map("n", "<leader>fj", "<cmd>Telescope jumplist <CR>", { desc = "Jumplist" })
map("n", "<leader>fd", "<cmd>Telescope diagnostics <CR>", { desc = "Diagnostics" })
map("n", "<leader>fq", function()
  local dirs_input = vim.fn.input "Directories (space-separated): "
  local filetypes_input = vim.fn.input "Filetypes/extensions (comma-separated, e.g. py,js,lua): "

  local dirs = vim.split(dirs_input, " ")
  local filetypes = vim.split(filetypes_input, ",")

  require("telescope.builtin").live_grep {
    search_dirs = dirs,
    additional_args = function(opts)
      local args = {}
      for _, ft in ipairs(filetypes) do
        ft = vim.trim(ft)
        if ft ~= "" then
          table.insert(args, "--glob")
          table.insert(args, "*." .. ft)
        end
      end
      return args
    end,
  }
end, { desc = "Live grep by dirs + filetypes" })

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

local nomap = vim.keymap.del

-- remove default keymaps
nomap("n", "<leader>h")
nomap("n", "<leader>v")
nomap("n", "<leader>cm")
nomap("n", "<leader>fm")
nomap("n", "<leader>gt")
nomap("n", "<leader>pt")
nomap("i", "<C-h>")
nomap("i", "<C-j>")
nomap("i", "<C-l>")
nomap("i", "<C-k>")

-- switch languages
map("n", "<leader>rr", "<cmd>set keymap=russian-jcukenwin<CR>", { desc = "Russian Keyboard" })
map("n", "<leader>rk", "<cmd>set keymap=kazakh-jcuken<CR>", { desc = "Kazakh Keyboard" })
map("n", "<leader>re", '<cmd>set keymap=""<CR>', { desc = "English Keyboard" })

-- tmux-mapping
vim.keymap.set("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", { silent = true })
vim.keymap.set("n", "<C-\\>", "<Cmd>TmuxNavigatePrevious<CR>", { silent = true })
