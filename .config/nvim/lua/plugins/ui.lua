return {
  -- Icons
  {
    'nvim-tree/nvim-web-devicons',
    lazy = false,
    config = function()
      require("nvim-web-devicons").setup({ default = true })
    end
  },
  
  -- File explorer
  {
    'nvim-tree/nvim-tree.lua',
    cmd = "NvimTreeToggle",
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },
    },
    config = function()
      require("nvim-tree").setup()
    end
  }
}
