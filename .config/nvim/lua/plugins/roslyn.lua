return {
    {
        "seblj/roslyn.nvim",
        ft = "cs",
        dependences = {
            {
                "tris203/rzls.nvim",
                config = true
            }
        },
        opts = {
            filewatching = "roslyn",
            keymap_prefix = "<leader>r",
            config = {
                settings = {
                    ["csharp|inlay_hints"] = {
                    dotnet_show_completion_items_from_unimported_namespaces = true,
                    dotnet_show_name_completion_suggestions = true
                    },
                    ["csharp|symbol_search"] = {
                    dotnet_search_reference_assemblies = true,
                    }
                }
            }
        },
        init = function()
            -- We add the Razor file types before the plugin loads.
            vim.filetype.add({
                extension = {
                    razor = "razor",
                    cshtml = "razor",
                },
            })
        end
    },
    {
        "tris203/rzls.nvim",
        ft = "cshtml"
    },
    {
        "nvimtools/none-ls.nvim",
        enabled = true,
        optional = true,
        dependencies = {
            'MunifTanjim/prettier.nvim'
        },
        opts = function(_, opts)
            local nls = require("null-ls")
            opts.sources = opts.sources or {}
            table.insert(opts.sources, nls.builtins.formatting.csharpier)
        end,
    },
    {
        "stevearc/conform.nvim",
        enabled = true,
        optional = true,
        dependencies = {
            'MunifTanjim/prettier.nvim'
        },
        opts = {
            formatters_by_ft = {
                cs = { "csharpier" }
            },
            formatters = {
                csharpier = {
                    command = "dotnet-csharpier",
                    args = { "--write-stdout" },
                },
            },
        },
    }
}
