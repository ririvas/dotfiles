return {
  -- Colorscheme collection
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Make sure to load this before all the other start plugins
    lazy = false,
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    lazy = false,
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = false,
  },
  {
    "Mofiqul/vscode.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("vscode").setup({
        -- Alternatively you can set style in setup
        -- style = 'light'
      })

      -- Enable transparent background
      require("vscode").load()
    end,
  },
  {
    "projekt0n/github-nvim-theme",
    priority = 1000,
    lazy = false,
  },
}
