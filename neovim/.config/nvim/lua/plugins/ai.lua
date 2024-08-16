return {
    {
        "frankroeder/parrot.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        keys = {
            { "<LEADER>pa", "<CMD>PrtAsk<CR>", desc = "GPT Ask" },
            { "<LEADER>pc", "<CMD>PrtChatToggle<CR>", desc = "GPT chat" },
            { "<LEADER>pg", "<CMD>PrtCommitMsg<CR>", desc = "GPT Commit message" },
            { "<LEADER>pr", ":<C-u>'<,'>PrtRefine<CR>", desc = "GPT Refine", mode = { "v" } },
            { "<LEADER>pt", ":<C-u>'<,'>PrtTranslate<CR>", desc = "GPT Translate", mode = { "v" } },
            { "<LEADER>pe", ":<C-u>'<,'>PrtExplain<CR>", desc = "GPT Explain", mode = { "v" } },
        },
        config = function()
            require("parrot").setup({
                providers = {
                    gemini = {
                        api_key = os.getenv("GEMINI_API_KEY"),
                    },
                },
                toggle_target = "vsplit", -- popup / split / vsplit / tabnew
                style_popup_border = "single",
                spinner_type = "dots", -- "dots", "line", "star", "bouncing_bar", "bouncing_ball"
                hooks = {
                    Grammar = function(prt, params)
                        local chat_prompt = [[
                            Your task is to take the text provided and rewrite it into a clear,
                            grammatically correct version while preserving the original meaning
                            as closely as possible. Correct any spelling mistakes, punctuation
                            errors, verb tense issues, word choice problems, and other
                            grammatical mistakes.

                            ```
                            {{selection}}
                            ```
                        ]]
                        local model = prt.get_model("chat")
                        prt.Prompt(params, prt.ui.Target.new, model, nil, chat_prompt)
                        -- prt.ChatNew(params, chat_prompt)
                    end,
                    Translate = function(prt, params)
                        local chat_prompt = [[
                            Please translate this into Traditional Chinese:
                            ```
                            {{selection}}
                            ```
                        ]]
                        local model = prt.get_model("chat")
                        prt.Prompt(params, prt.ui.Target.new, model, nil, chat_prompt)
                    end,
                    Explain = function(prt, params)
                        local template = [[
                            Your task is to take the code snippet from {{filename}} and explain it with gradually increasing complexity.
                            Break down the code's functionality, purpose, and key components.
                            The goal is to help the reader understand what the code does and how it works.

                            ```{{filetype}}
                            {{selection}}
                            ```

                            Use the markdown format with codeblocks and inline code.
                            Explanation of the code above:
                        ]]
                        local model = prt.get_model("chat")
                        prt.logger.info("Explaining selection with model: " .. model.name)
                        prt.Prompt(params, prt.ui.Target.new, model, nil, template)
                    end,
                    CommitMsg = function(prt, params)
                        local futils = require "parrot.file_utils"
                        if futils.find_git_root() == "" then
                            prt.logger.warning "Not in a git repository"
                            return
                        else
                            local template = [[
                                I want you to act as a commit message generator. I will provide you
                                with information about the task and the prefix for the task code, and
                                I would like you to generate an appropriate commit message using the
                                conventional commit format. Do not write any explanations or other
                                words, just reply with the commit message.
                                Start with a short headline as summary but then list the individual
                                changes in more detail. Text other than Summary needs to be wrapped
                                if it exceeds 80 characters.

                                Here are the changes that should be considered by this message:
                            ]] .. vim.fn.system "git diff --no-color --no-ext-diff --staged"
                            local model_obj = prt.get_model "command"
                            prt.Prompt(params, prt.ui.Target.prepend, model_obj, nil, template)
                        end
                    end,
                    ProofReader = function(prt, params)
                        local chat_prompt = [[
                            I want you to act as a proofreader. I will provide you with texts and
                            I would like you to review them for any spelling, grammar, or
                            punctuation errors. Once you have finished reviewing the text,
                            provide me with any necessary corrections or suggestions to improve the
                            text. Highlight the corrected fragments (if any) using markdown backticks.

                            When you have done that subsequently provide me with a slightly better
                            version of the text, but keep close to the original text.

                            Finally provide me with an ideal version of the text.

                            Whenever I provide you with text, you reply in this format directly:

                            ## Corrected text:

                            ```
                            {corrected text, or say "NO_CORRECTIONS_NEEDED" instead if there are no corrections made}
                            ```

                            ## Slightly better text:

                            ```
                            {slightly better text}
                            ```

                            ## Ideal text:

                            ```
                            {ideal text}
                            ```
                        ]]
                        prt.ChatNew(params, chat_prompt)
                    end,
                }
            })
        end
    },
}
