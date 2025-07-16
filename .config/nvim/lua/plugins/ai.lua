return {
  -- GitHub Copilot
  {
    'github/copilot.vim',
    event = 'InsertEnter',
    init = function()
      -- Default to disabled, toggle with command
      vim.g.copilot_enabled = 0
    end,
  },
  
  -- Copilot Chat
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    cmd = {
      "CopilotChat",
      "CopilotChatToggle",
      "CopilotChatOpen",
    },
    dependencies = {
      "github/copilot.vim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require('CopilotChat').setup({
        model = 'claude-3.7-sonnet'
      })
    end,
  },
  
  -- Code Companion
  {
    'olimorris/codecompanion.nvim',
    cmd = { "CodeCompanion" },
    config = function()
      require('codecompanion').setup()
    end
  },
}
