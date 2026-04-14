return {
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true,
            },
            check = {
                command = "clippy",
                features = "all",
            },
            diagnostics = {
                enable = true,
            },
            lens = {
                enable = true,                       -- master switch
                run = { enable = true },             -- "Run" lens
                debug = { enable = true },           -- "Debug" lens
                implementations = { enable = true }, -- "X implementations"
                references = {
                    adt = { enable = true },         -- references on structs/enums
                    enumVariant = { enable = true }, -- references on enum variants
                    method = { enable = true },      -- references on methods
                    trait = { enable = true },       -- references on traits
                },
            },
        },
    }
}
