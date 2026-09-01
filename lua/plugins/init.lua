return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save,
    config = function()
      require "configs.conform"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  -- mason.nvim itself is declared by NvChad (mason-org/mason.nvim); it has no
  -- ensure_installed option, so the tool list lives in mason-tool-installer.
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "pyright",
        "debugpy",
        "clangd",
        "clang-format",
        "codelldb",
        -- ruff intentionally omitted: installed globally via `uv tool install ruff`.
        "gopls",
      },
      run_on_start = true,
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    opts = false,
    config = function()
      pcall(function()
        dofile(vim.g.base46_cache .. "syntax")
        dofile(vim.g.base46_cache .. "treesitter")
      end)
      require "configs.treesitter-config"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    lazy = false,
    dependencies = { "nvim-treesitter" },
    config = function()
      require "configs.treesitter-textobjects"
    end,
  },
  {
    "folke/zen-mode.nvim",
    event = "VeryLazy",
    config = function()
      require "configs.zen-mode-conf"
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  {
    "chrishrb/gx.nvim",
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    cmd = { "Browse" },
    init = function()
      vim.g.netrw_nogx = 1 -- disable netrw gx
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },
  {
    "selimacerbas/markdown-preview.nvim",
    ft = "markdown",
    dependencies = { "selimacerbas/live-server.nvim" },
    config = function()
      require("markdown_preview").setup {
        port = 8421,
        open_browser = true,
        debounce_ms = 300,
      }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "tpope/vim-fugitive",
    lazy = false,
  },
  {
    "tpope/vim-rhubarb",
    dependencies = { "tpope/vim-fugitive" },
    lazy = false,
  },
  {
    "shumphrey/fugitive-gitlab.vim",
    dependencies = { "tpope/vim-fugitive" },
    lazy = false,
    config = function()
      vim.g.fugitive_gitlab_domains = {
        ["gitlab.oit.duke.edu"] = "https://gitlab.oit.duke.edu",
        ["git-internal.oit.duke.edu"] = "https://git-internal.oit.duke.edu",
      }
    end,
  },
  {
    "aaronhallaert/advanced-git-search.nvim",
    lazy = false,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "tpope/vim-fugitive",
    },
    config = function()
      require "configs.telescope"
      require("telescope").load_extension "advanced_git_search"
      require("telescope").load_extension "zoxide"
      require("telescope").load_extension "live_grep_args"
    end,
  },
  {
    "jvgrootveld/telescope-zoxide",
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  {
    "jecaro/fugitive-difftool.nvim",
    lazy = false,
  },
  {
    "sindrets/diffview.nvim",
    lazy = false,
    opts = {
      view = {
        merge_tool = {
          layout = "diff3_mixed",
        },
      },
    },
  },
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = require("configs.claudecode").keys,
    opts = require("configs.claudecode").opts,
  },
  {
    "Vigemus/iron.nvim",
    ft = { "python" },
    config = function()
      require "configs.iron"
    end,
  },
  {
    "folke/which-key.nvim",
    opts = {
      -- only pop up after a 2s pause; plugin views (marks, registers) stay instant
      delay = function(ctx)
        return ctx.plugin and 0 or 2000
      end,
    },
  },
  require "configs.flash",
  require "configs.window-picker",
}
