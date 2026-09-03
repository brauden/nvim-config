local previewers = require "telescope.previewers"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

-- <CR> opens every <Tab>-selected entry, falling back to the default action
-- when nothing is multi-selected.
local function open_multi(prompt_bufnr)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local selection = picker:get_multi_selection()

  if vim.tbl_isempty(selection) then
    actions.select_default(prompt_bufnr)
    return
  end

  actions.close(prompt_bufnr)

  for _, entry in ipairs(selection) do
    local filename = entry.path or entry.filename or entry.value
    if type(filename) == "string" then
      vim.cmd.edit(vim.fn.fnameescape(filename))
      if entry.lnum then
        pcall(vim.api.nvim_win_set_cursor, 0, { entry.lnum, (entry.col or 1) - 1 })
      end
    end
  end
end

-- current_buffer_fuzzy_find ranks with telescope's fzy sorter, which lowercases
-- both the prompt and the line, so "Foo" and "foo" are indistinguishable. Gate
-- which lines match on case, and let fzy rank whatever survives the gate.
--
--   "smart"     -- case-sensitive only when the prompt contains an upper-case char
--   "sensitive" -- always case-sensitive
local CASE_MODE = "smart"

local function is_case_sensitive(prompt)
  return CASE_MODE == "sensitive" or prompt:find "%u" ~= nil
end

-- Left-most case-sensitive subsequence match, nil when the line doesn't match.
local function subsequence_positions(needle, haystack)
  local positions, from = {}, 1
  for i = 1, #needle do
    local at = haystack:find(needle:sub(i, i), from, true)
    if not at then
      return nil
    end
    positions[i] = at
    from = at + 1
  end
  return positions
end

-- Stands in for telescope.algos.fzy, overriding only the two entry points that
-- decide *whether* and *where* a line matches; scoring falls through to fzy.
-- Positions matter beyond highlighting here: current_buffer_fuzzy_find asks the
-- sorter for them to place the cursor on the chosen line.
local function case_aware_fzy()
  local fzy = require "telescope.algos.fzy"

  return setmetatable({
    has_match = function(needle, haystack)
      if not is_case_sensitive(needle) then
        return fzy.has_match(needle, haystack)
      end
      return subsequence_positions(needle, haystack) ~= nil
    end,

    positions = function(needle, haystack)
      if not is_case_sensitive(needle) then
        return fzy.positions(needle, haystack)
      end
      return subsequence_positions(needle, haystack) or {}
    end,
  }, { __index = fzy })
end

require("telescope").setup {
  defaults = {
    mappings = {
      i = { ["<CR>"] = open_multi },
      n = { ["<CR>"] = open_multi },
    },
  },
  pickers = {
    current_buffer_fuzzy_find = {
      sorter = require("telescope.sorters").get_fzy_sorter { fzy_mod = case_aware_fzy() },
    },
    git_commits = {
      previewer = previewers.new_termopen_previewer {
        get_command = function(entry)
          return { "git", "show", "--stat", "--color", entry.value }
        end,
      },
    },
  },
  extensions = {
    advanced_git_search = {
      diff_plugin = "diffview",
      git_diff_flags = { "--stat" },
      keymaps = {
        copy_commit_patch = "<C-x>",
      },
    },
  },
}

