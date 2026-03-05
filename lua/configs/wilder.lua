local wilder = require "wilder"

wilder.setup {
  modes = { ":", "/", "?" },
}

wilder.set_option("pipeline", {
  wilder.branch(
    wilder.cmdline_pipeline {
      fuzzy = 1,
      fuzzy_filter = wilder.vim_fuzzy_filter(),
    },
    wilder.search_pipeline {
      fuzzy = 1,
    }
  ),
})

wilder.set_option(
  "renderer",
  wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
    highlights = {
      border = "Normal",
      accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#5fd7ff" } }),
    },
    border = "rounded",
    max_height = "50%",
    min_width = "30%",
    max_width = "50%",
    pumblend = 20,
    left = { " ", wilder.popupmenu_devicons() },
    right = { " ", wilder.popupmenu_scrollbar() },
    highlighter = wilder.basic_highlighter(),
  })
)
