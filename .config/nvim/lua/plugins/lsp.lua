return {
    -- LSP Management
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = function()
            require('mason').setup({
            })
        end,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        lazy = false,
        dependencies = { 'williamboman/mason.nvim' },
        config = function()
            require('mason-lspconfig').setup({
                automatic_enable = false, -- setting this to true messes with roslyn?
                ensure_installed = { "pyright", "html", "lua_ls", "ts_ls" }
            })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        lazy = false,
        dependencies = {
            'williamboman/mason-lspconfig.nvim'
        },
        config = function(_, opts)
            local lspConfig = require("lspconfig");

            for server, config in pairs(opts.servers) do
                -- LSP capabilities for completions
                local capabilities = vim.lsp.protocol.make_client_capabilities()
                capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
                config.capabilities = capabilities
                lspConfig[server].setup(config)
            end
            vim.lsp.config("roslyn", {
                cmd = {
                    "dotnet",
                    "/home/rrivas/.local/share/nvim/roslyn/Microsoft.CodeAnalysis.LanguageServer.dll",
                    "--logLevel=Information",
                    "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
                    "--stdio",
                },
                -- Add other options here
            })
            vim.lsp.enable("pyright")
        end,
    },
    -- TypeScript support
    {
        'pmizio/typescript-tools.nvim',
        ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = function()
            require('typescript-tools').setup({
            })
        end,
    },

    'nvim-lua/plenary.nvim',
}
