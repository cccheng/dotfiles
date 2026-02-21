return {
    settings = {
        ["harper-ls"] = {
            -- userDictPath = vim.fn.stdpath("config") .. "/dict/spell.txt",
            diagnosticSeverity = "warning", -- "hint", "information", "warning", or "error"

            linters = {
                SpellCheck = false, -- true,
                SpelledNumbers = false,
                AnA = true,
                SentenceCapitalization = false, -- true,
                UnclosedQuotes = true,
                WrongQuotes = false,
                LongSentences = true,
                RepeatedWords = true,
                Spaces = false,
                Matcher = true,
                CorrectNumberSuffix = true,
            },
        },
    },
    filetypes = {
        "text",
        "markdown",
        "gitcommit",
        "gitsendemail",
        "changelog",
    },
}
