return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    highlight = {
      groups = {
        label = "FlashLabel",
      },
    },
  },
  config = function(_, opts)
    require("flash").setup(opts)
    vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#ffffff", bg = "#ff007c", bold = true })
    vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#88aabb", bg = "#3b4252" })

    -- flash only dismisses the f/F/t/T state on a literal <Esc> byte. When the
    -- terminal speaks the kitty keyboard protocol, <C-[> arrives as its own key,
    -- so dismiss on that too.
    local Char = require "flash.plugins.char"
    vim.on_key(function(key)
      if not (Char.state and Char.state.visible) then
        return
      end
      local trans = vim.fn.keytrans(key)
      if trans ~= "<Esc>" and trans ~= "<C-[>" then
        return
      end
      local mode = vim.fn.mode()
      if mode == "n" or mode == "v" then
        Char.state:hide()
        vim.schedule(function()
          vim.cmd "redraw"
        end)
      end
    end)
  end,
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
    {
      "S",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
    {
      "r",
      mode = "o",
      function()
        require("flash").remote()
      end,
      desc = "Remote Flash",
    },
    {
      "R",
      mode = { "o", "x" },
      function()
        require("flash").treesitter_search()
      end,
      desc = "Treesitter Search",
    },
    {
      "<c-s>",
      mode = { "c" },
      function()
        require("flash").toggle()
      end,
      desc = "Toggle Flash Search",
    },
  },
}