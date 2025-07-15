-- Install lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup
require("lazy").setup({
  -- UI
  'nvim-tree/nvim-web-devicons',
  'nvim-tree/nvim-tree.lua',
  
  -- LSP
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
 
  -- Treesitter
  { 'nvim-treesitter/nvim-treesitter', brancy = 'master', build = ':TSUpdate', lazy = false, dependencies = { "OXY2DEV/markview.nvim" } },
   
  -- Markview
  { 'OXY2DEV/markview.nvim', priority = 49, lazy = false },
  
  -- Code outline
  'stevearc/aerial.nvim',
  
  -- Completions
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',
  
  -- Snippets
  'hrsh7th/cmp-vsnip',
  'hrsh7th/vim-vsnip',
  
  -- C# Support
  'OmniSharp/omnisharp-vim',
  'dense-analysis/ale',
  'tpope/vim-dispatch',
  'Shougo/vimproc.vim',
  'prabirshrestha/asyncomplete.vim',
  
  -- Debugging
  'mfussenegger/nvim-dap',
  'nvim-neotest/nvim-nio',
  'rcarriga/nvim-dap-ui',
  'mfussenegger/nvim-dap-python',
  
  -- SQL client
  'tpope/vim-dadbod',
  'kristijanhusak/vim-dadbod-ui',
  'kristijanhusak/vim-dadbod-completion',
  
  'folke/which-key.nvim',
  'Kurren123/mssql.nvim',
  
  -- TS support
  'nvim-lua/plenary.nvim',
  'pmizio/typescript-tools.nvim',
  
  -- Telescope
  'tpope/vim-fugitive',
  'BurntSushi/ripgrep',
  'nvim-telescope/telescope.nvim',
  'projekt0n/github-nvim-theme',
  'isak102/telescope-git-file-history.nvim',
  
  -- AI
  'github/copilot.vim',
  'CopilotC-Nvim/CopilotChat.nvim',
  'olimorris/codecompanion.nvim',
  
  -- Colorscheme
  'catppuccin/nvim',
  'ellisonleao/gruvbox.nvim',
  'folke/tokyonight.nvim',
  'Mofiqul/vscode.nvim',
  
  -- Statusline
  'itchyny/lightline.vim',
  'shinchu/lightline-gruvbox.vim',
  'maximbaz/lightline-ale',
  
  -- Markdown Preview
  { 'iamcco/markdown-preview.nvim', build = 'cd app && npx --yes yarn install' },
})

-- Basic settings
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Plugin settings
vim.g.db_ui_execute_on_save = 0
vim.g.copilot_enabled = 0
vim.g.OmniSharp_server_use_net6 = 1
vim.g.ale_linters = {
  cs = {'OmniSharp'},
  cshtml = {}
}
vim.g.ale_pattern_options = {
  ['.*\\.cshtml$'] = {ale_enabled = 0},
}
vim.g.vimspector_enable_mappings = 'HUMAN'
vim.g.mkdp_echo_preview_url = 1

-- Lightline settings
vim.g.lightline = {
  colorscheme = 'one'
}

-- Theme settings
vim.o.background = 'light'
vim.opt.relativenumber = true
-- ripgrep
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"
-- theme
vim.cmd('colorscheme vscode')
vim.api.nvim_set_hl(0, "csXmlTag", { fg = "#3F6641", italic = true }) -- C# XML doc comments
vim.api.nvim_set_hl(0, "xmlTag", { fg = "#3F6641", italic = true })

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- enable 24-bit color
vim.opt.termguicolors = true

-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>')

-- Key mappings
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { desc = 'Open diagnostic float' })
vim.keymap.set('n', 't', '<cmd>tabnew<CR>', { desc = 'New tab' })

-- LSP Mappings
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature help' })
vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, { desc = 'Type definition' })
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'References' })
vim.keymap.set('n', '<space>fr', function() vim.lsp.buf.format({ async = true }) end, { desc = 'Format' })

-- nvim-dap bindings
vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = 'Continue' })
vim.keymap.set('n', '<F6>', function() require('dap').disconnect() end, { desc = 'Disconnect' })
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end, { desc = 'Step over' })
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end, { desc = 'Step into' })
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end, { desc = 'Step out' })
vim.keymap.set('n', '<F9>', function() require('dap').toggle_breakpoint() end, { desc = 'Toggle breakpoint' })

-- OmniSharp commands
local omnisharp_group = vim.api.nvim_create_augroup("omnisharp_commands", { clear = true })

-- Show type information automatically when the cursor stops moving
vim.api.nvim_create_autocmd("CursorHold", {
    pattern = "*.cs",
    callback = function()
        vim.cmd("OmniSharpTypeLookup")
    end,
    group = omnisharp_group
})

-- Set up FileType specific mappings for C# files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "cs",
    callback = function()
        -- The following commands are contextual, based on the cursor position
        vim.keymap.set("n", "gd", "<Plug>(omnisharp_go_to_definition)", { silent = true, buffer = true })
        vim.keymap.set("n", "gr", "<Plug>(omnisharp_find_usages)", { silent = true, buffer = true })
        vim.keymap.set("n", "gi", "<Plug>(omnisharp_find_implementations)", { silent = true, buffer = true })
        vim.keymap.set("n", "<Leader>D", "<Plug>(omnisharp_preview_definition)", { silent = true, buffer = true })
        vim.keymap.set("n", "<Leader>I", "<Plug>(omnisharp_preview_implementations)", { silent = true, buffer = true })
        vim.keymap.set("n", "<Leader>T", "<Plug>(omnisharp_type_lookup)", { silent = true, buffer = true })
        vim.keymap.set("n", "<Leader>d", "<Plug>(omnisharp_documentation)", { silent = true, buffer = true })
        vim.keymap.set("n", "<Leader>S", "<Plug>(omnisharp_find_symbol)", { silent = true, buffer = true })
        vim.keymap.set("n", "<C-K>", "<Plug>(omnisharp_signature_help)", { silent = true, buffer = true })
        vim.keymap.set("i", "<C-K>", "<Plug>(omnisharp_signature_help)", { silent = true, buffer = true })
        -- Navigate up and down by method/property/field
        vim.keymap.set("n", "[[", "<Plug>(omnisharp_navigate_up)", { silent = true, buffer = true })
        vim.keymap.set("n", "]]", "<Plug>(omnisharp_navigate_down)", { silent = true, buffer = true })
        -- Rename
        vim.keymap.set("n", "<Leader>osnm", "<Plug>(omnisharp_rename)", { silent = true, buffer = true })
    end,
    group = omnisharp_group
})

-- Plugin setups
require("nvim-web-devicons").setup({default = true})
require("nvim-tree").setup()

-- Telescope setup
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- nvim-cmp setup
local cmp = require('cmp')

cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) 
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      { name = 'buffer' },
      { name = 'vim-dadbod-completion' }
    })
})

-- Use buffer source for `/` and `?` 
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
})

-- LSP capabilities for completions
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Mason setup
require('mason').setup()
local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup {
    automatic_enable = false,
    ensure_installed = { "pyright" }
}

-- LSP configurations
require("lspconfig").pyright.setup {
    capabilities = capabilities,
}
require('typescript-tools').setup{}

-- DAP setup
local dap = require('dap')

dap.adapters.coreclr = {
    type = 'executable',
    command = '/usr/local/bin/netcoredbg/netcoredbg',
    args = {'--interpreter=vscode'}
}

-- Dotnet build and debug helpers
vim.g.dotnet_build_project = function()
    local default_path = vim.fn.getcwd() .. '/'
    if vim.g['dotnet_last_proj_path'] ~= nil then
        default_path = vim.g['dotnet_last_proj_path']
    end
    local path = vim.fn.input('Path to your *proj file', default_path, 'file')
    vim.g['dotnet_last_proj_path'] = path
    local cmd = 'dotnet build -c Debug ' .. path .. ' > /dev/null'
    print('')
    print('Cmd to execute: ' .. cmd)
    local f = os.execute(cmd)
    if f == 0 then
        print('\nBuild: ✔️ ')
    else
        print('\nBuild: ❌ (code: ' .. f .. ')')
    end
end

vim.g.dotnet_get_dll_path = function()
    local request = function()
        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end

    if vim.g['dotnet_last_dll_path'] == nil then
        vim.g['dotnet_last_dll_path'] = request()
    else
        if vim.fn.confirm('Do you want to change the path to dll?\n' .. vim.g['dotnet_last_dll_path'], '&yes\n&no', 2) == 1 then
            vim.g['dotnet_last_dll_path'] = request()
        end
    end

    return vim.g['dotnet_last_dll_path']
end

local config = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
        if vim.fn.confirm('Should I recompile first?', '&yes\n&no', 2) == 1 then
            vim.g.dotnet_build_project()
        end
        return vim.g.dotnet_get_dll_path()
    end,
  },
}

dap.configurations.cs = config
dap.configurations.fsharp = config 
require('dap-python').setup('python3')

-- DAP UI setup
local dapui = require('dapui')
dapui.setup()
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

-- Other plugin setups
require("mssql").setup({
    keymap_prefix = "<leader>m",
    max_rows = 50,
    max_column_width = 25
})

require('CopilotChat').setup{
    model='claude-3.7-sonnet'
}

require("codecompanion").setup()
require("aerial").setup()
require("markview").setup({
    preview = {
        filetypes = { "md", "markdown", "codecompanion", "copilot-chat" },
        ignore_buftypes = {},
        icon_provide = "devicons"
    }
})
