return {
  -- Markdown Preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewToggle", "MarkdownPreviewStop" },
    ft = { "markdown", "md" },
    build = "cd app && npx --yes yarn install",
    init = function()
      vim.g.mkdp_echo_preview_url = 1
    end,
  },
}
