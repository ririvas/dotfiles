return {
  -- Treesitter for better syntax highlighting and code understanding
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    dependencies = {
      "OXY2DEV/markview.nvim"
    },
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'c', 'lua', 'vim', 'vimdoc', 'query',
          'javascript', 'typescript', 'html', 'css',
          'json', 'python', 'c_sharp', 'markdown', 'markdown_inline',
          'yaml'
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
        },
      })
    end
  },
  
  -- Markview (depends on Treesitter)
  {
    'OXY2DEV/markview.nvim',
    lazy = false,
    priority = 49,
    config = function()
      require("markview").setup({
        preview = {
          filetypes = { "md", "markdown", "codecompanion", "copilot-chat" },
          ignore_buftypes = {},
          icon_provide = "devicons"
        }
      })
    end
  }
}
