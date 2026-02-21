-- see $clangd -h, https://clangd.llvm.org/installation

return {
    -- cmd = {
    --     "clangd",
    --     "-j=6",
    --     "--all-scopes-completion",
    --     "--background-index", -- should include a compile_commands.json or .txt
    --     "--clang-tidy",
    --     "--cross-file-rename",
    --     "--completion-style=detailed",
    --     "--fallback-style=Microsoft",
    --     "--function-arg-placeholders",
    --     "--header-insertion-decorators",
    --     "--header-insertion=never",
    --     "--limit-results=10",
    --     "--pch-storage=memory",
    --     "--query-driver=/usr/include/*",
    --     "--suggest-missing-includes",
    -- },
    capabilities = {
        offsetEncoding = { "utf-16" },
        textDocument = {
            inlayHints = { enabled = true },
            completion = { editsNearCursor = true },
        },
    },
    cmd = {
        "clangd",
        "--background-index",
        "--background-index-priority=background",
        "--all-scopes-completion",
        "--pch-storage=memory",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--enable-config",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
    },
    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
    },
    settings = {
        clangd = {
            semanticHighlighting = true,
        },
    },
}
