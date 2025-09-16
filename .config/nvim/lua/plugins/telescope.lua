return {
  -- Telescope - fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'BurntSushi/ripgrep', -- better grep
      'isak102/telescope-git-file-history.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
    },
    keys = {
      { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Find Files' },
      { '<leader>fg', function() require('telescope.builtin').live_grep() end, desc = 'Live Grep' },
      { '<leader>fb', function() require('telescope.builtin').buffers() end, desc = 'Buffers' },
      { '<leader>fh', function() require('telescope.builtin').help_tags() end, desc = 'Help Tags' },
    },
    config = function()
      require('telescope').setup({
        defaults = {
          -- Default configuration for telescope
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "smart" },
        },
        -- Your custom pickers configuration
        pickers = {},
        -- Extension configuration
        extensions = {}
      })
      require('telescope').load_extension("ui-select")
    end
  },
  
  -- Telescope dependencies
  'nvim-telescope/telescope-ui-select.nvim',
  'nvim-lua/plenary.nvim',
  'isak102/telescope-git-file-history.nvim',
  'tpope/vim-fugitive', -- Git integration
}
