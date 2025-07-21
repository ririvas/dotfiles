return {
    {
        "seblj/roslyn.nvim",
        ft = "cs",
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
    },
    {
        "nvimtools/none-ls.nvim",
        optional = true,
        opts = function(_, opts)
            local nls = require("null-ls")
            opts.sources = opts.sources or {}
            table.insert(opts.sources, nls.builtins.formatting.csharpier)
        end,
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                cs = { "csharpier" },
            },
            formatters = {
                csharpier = {
                    command = "dotnet-csharpier",
                    args = { "--write-stdout" },
                },
            },
        },
    },
}
