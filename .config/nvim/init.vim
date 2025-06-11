call plug#begin()

Plug 'nvim-tree/nvim-web-devicons'

" LSP
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'

" Markview 
Plug 'OXY2DEV/markview.nvim'

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

" Code outline
Plug 'stevearc/aerial.nvim'

" Completions
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" Snippets
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" C# Support 
Plug 'OmniSharp/omnisharp-vim'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-dispatch'
Plug 'Shougo/vimproc.vim'
Plug 'prabirshrestha/asyncomplete.vim'

" Debugging
"Plug 'puremourning/vimspector'
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-neotest/nvim-nio'
Plug 'rcarriga/nvim-dap-ui'
Plug 'mfussenegger/nvim-dap-python'
"Plug 'NicholasMata/nvim-dap-cs'

" SQL client
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'kristijanhusak/vim-dadbod-completion'

"TS support
Plug 'nvim-lua/plenary.nvim'
Plug 'pmizio/typescript-tools.nvim'

" Telescope
Plug 'BurntSushi/ripgrep'
Plug 'nvim-telescope/telescope.nvim'
Plug 'projekt0n/github-nvim-theme'

" AI
Plug 'github/copilot.vim'
Plug 'CopilotC-Nvim/CopilotChat.nvim'
Plug 'olimorris/codecompanion.nvim'

" Colorscheme
Plug 'catppuccin/nvim'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'Mofiqul/vscode.nvim'

" Statusline
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'maximbaz/lightline-ale'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

call plug#end()

set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent
set smartindent
let g:db_ui_execute_on_save = 0
let g:copilot_enabled = 0
let g:OmniSharp_server_use_net6 = 1
let g:ale_linters = {
\ 'cs': ['OmniSharp'],
\ 'cshtml': []
\}
let g:ale_pattern_options = {
\   '.*\.cshtml$': {'ale_enabled': 0},
\}
let g:vimspector_enable_mappings = 'HUMAN'
let g:mkdp_echo_preview_url = 1

lua << EOF
    vim.opt.relativenumber = true
    -- ripgrep
    vim.opt.grepprg = "rg --vimgrep"
    vim.opt.grepformat = "%f:%l:%c:%m"
    -- theme
    vim.cmd('colorscheme vscode')
    vim.api.nvim_set_hl(0, "csXmlTag", { fg = "#3F6641", italic = true }) -- C# XML doc comments
    vim.api.nvim_set_hl(0, "xmlTag", { fg = "#3F6641", italic = true })


    -- diagnostics
    vim.keymap.set('n','<space>e','<cmd>lua vim.diagnostic.open_float()<CR>')
    -- set leader key to space
    vim.g.mapleader = ' '
    vim.g.maplocalleader = ' '
    vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>')

    --new tab 
    vim.keymap.set('n', 't','<cmd>tabnew<CR>')
    -- LSP Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    vim.keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    vim.keymap.set('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    vim.keymap.set('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
    vim.keymap.set('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    vim.keymap.set('n', '<space>fr', '<cmd>lua vim.lsp.buf.formatting()<CR>')

    -- nvim-dap bindings
    vim.keymap.set('n','<F5>', "<cmd>lua require('dap').continue()<CR>")
    vim.keymap.set('n','<F6>', "<cmd>lua require('dap').disconnect()<CR>")
    vim.keymap.set('n','<F10>', "<cmd>lua require('dap').step_over()<CR>")
    vim.keymap.set('n', '<F11>', "<cmd>lua require('dap').step_into()<CR>")
    vim.keymap.set('n', '<F12>', "<cmd>lua require('dap').step_out()<CR>")
    vim.keymap.set('n', '<F9>', "<cmd>lua require('dap').toggle_breakpoint()<CR>")
    -- OmniSharp commands
    vim.api.nvim_create_augroup("omnisharp_commands", { clear = true })

    -- Show type information automatically when the cursor stops moving
    vim.api.nvim_create_autocmd("CursorHold", {
        pattern = "*.cs",
        callback = function()
            vim.cmd("OmniSharpTypeLookup")
        end,
        group = "omnisharp_commands"
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
        group = "omnisharp_commands"
    })

    require("nvim-web-devicons").setup({default = true})

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

    local cmp = require'cmp'

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
           {name = 'buffer' },
           { name ='vim-dadbod-completion' }
        })
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
    })
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    require('mason').setup()
    local mason_lspconfig = require('mason-lspconfig')
    mason_lspconfig.setup {
        automatic_enable = false,
        ensure_installed = { "pyright" }
    }
    require("lspconfig").pyright.setup {
        capabilities = capabilities,
    }
    require 'typescript-tools'.setup{}
    local dap = require('dap')
    
    dap.adapters.coreclr = {
        type = 'executable',
        command = '/usr/local/bin/netcoredbg/netcoredbg',
        args = {'--interpreter=vscode'}
    }
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

    require'CopilotChat'.setup{
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
EOF


