
-- Theme highlight settings
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        vim.api.nvim_set_hl(0, "csXmlTag", { fg = "#3F6641", italic = true }) -- C# XML doc comments
        vim.api.nvim_set_hl(0, "xmlTag", { fg = "#3F6641", italic = true })
    end,
    group = vim.api.nvim_create_augroup("CustomColorScheme", { clear = true })
})
