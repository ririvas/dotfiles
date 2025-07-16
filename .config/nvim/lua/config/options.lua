-- Basic settings
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.number = false
vim.opt.relativenumber = false

-- Plugin settings
vim.g.db_ui_execute_on_save = 0
vim.g.copilot_enabled = 0
vim.g.vimspector_enable_mappings = 'HUMAN'
vim.g.mkdp_echo_preview_url = 1

-- Lightline settings
vim.g.lightline = {
  colorscheme = 'one'
}

-- Theme settings
vim.o.background = 'light'

-- ripgrep
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- enable 24-bit color
vim.opt.termguicolors = true
