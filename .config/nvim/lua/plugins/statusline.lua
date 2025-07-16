return {
  -- Statusline
  {
    'itchyny/lightline.vim',
    lazy = false,
    dependencies = {
      'shinchu/lightline-gruvbox.vim',
      'maximbaz/lightline-ale',
    },
    init = function()
      vim.g.lightline = {
        colorscheme = 'one',
        -- Add any other lightline configuration options here
      }
    end
  },
  
  -- Lightline dependencies
  'shinchu/lightline-gruvbox.vim',
  'maximbaz/lightline-ale',
}
