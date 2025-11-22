-- wilder.nvim configuration
local wilder = require "wilder"

wilder.setup {
  modes = { ":", "/", "?" }, -- Enable for command mode and search (forward/backward)
}

wilder.set_option("pipeline", {
  wilder.branch(
    wilder.cmdline_pipeline {
      language = "vim", -- Use Vim's native completion instead of Python
      fuzzy = 1,
    },
    wilder.search_pipeline()
  ),
})

-- Configure the popup menu renderer
wilder.set_option(
  "renderer",
  wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
    -- Popup menu appearance
    highlights = {
      border = "Normal", -- Border color
      accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#5fd7ff" } }),
    },

    -- Border style: 'single', 'double', 'rounded', or 'solid'
    border = "rounded",

    -- Maximum height of the popup
    max_height = "50%",

    -- Minimum and maximum width
    min_width = "30%",
    max_width = "50%",

    -- Position: 'top' or 'bottom'
    pumblend = 20, -- Transparency (0-100)

    -- Left and right columns
    left = { " ", wilder.popupmenu_devicons() },
    right = { " ", wilder.popupmenu_scrollbar() },

    -- Highlighter for matching characters
    highlighter = wilder.basic_highlighter(),
  })
)

-- Pipeline for command mode
wilder.set_option("pipeline", {
  wilder.branch(
    -- For command mode
    wilder.cmdline_pipeline {
      fuzzy = 1, -- Enable fuzzy matching
      fuzzy_filter = wilder.vim_fuzzy_filter(),
    },
    -- For search mode
    wilder.search_pipeline {
      fuzzy = 1,
    }
  ),
})

-- wilder.set_option('pipeline', {
--   wilder.branch(
--     wilder.cmdline_pipeline({
--       fuzzy = 1,
--       set_pcre2_pattern = 1,  -- Use PCRE2 for faster matching
--     }),
--     wilder.search_pipeline()
--   ),
-- })

-- Custom color scheme highlights
vim.cmd [[
  " Main popup menu colors
  highlight WilderMenu guibg=#1e1e2e guifg=#cdd6f4
  
  " Selected item
  highlight WilderSelected guibg=#45475a guifg=#f5e0dc
  
  " Accent color for matched characters
  highlight WilderAccent guifg=#89b4fa gui=bold
  
  " Border color
  highlight WilderBorder guifg=#6c7086
  
  " Scrollbar
  highlight WilderScrollbar guibg=#313244
]]
