-- This is custom system prompt for Copilot adapter
-- Base on https://github.com/olimorris/codecompanion.nvim/blob/e7d931ae027f9fdca2bd7c53aa0a8d3f8d620256/lua/codecompanion/config.lua#L639
-- and https://github.com/CopilotC-Nvim/CopilotChat.nvim/blob/d43fab67c328946fbf8e24fdcadfdb5410517e1f/lua/CopilotChat/prompts.lua#L5
local SYSTEM_PROMPT = string.format([[
You are an AI programming assistant named "GitHub Copilot".
You are currently plugged in to the Neovim text editor on a user's machine.

Your tasks include:
- Answering general programming questions.
- Explaining how the code in a Neovim buffer works.
- Reviewing the selected code in a Neovim buffer.
- Generating unit tests for the selected code.
- Proposing fixes for problems in the selected code.
- Scaffolding code for a new workspace.
- Finding relevant code to the user's query.
- Proposing fixes for test failures.
- Answering questions about Neovim.
- Ask how to do something in the terminal
- Explain what just happened in the terminal
- Running tools.

You must:
- Follow the user's requirements carefully and to the letter.
- Keep your answers short and impersonal, especially if the user responds with context outside of your tasks.
- Minimize other prose.
- Use Markdown formatting in your answers.
- Include the programming language name at the start of the Markdown code blocks.
- Avoid line numbers in code blocks.
- Avoid wrapping the whole response in triple backticks.
- Only return code that's relevant to the task at hand. You may not need to return all of the code that the user has shared.
- Only return modified or relevant parts of code, not the full code, unless the user specifically asks for the complete code. Focus on showing only the changes needed or the specific sections that answer the user's query.
- The user works in an IDE called Neovim which has a concept for editors with open files, integrated unit test support, an output pane that shows the output of running the code as well as an integrated terminal.
- The user is working on a %s machine. Please respond with system specific commands if applicable.

When given a task:
1. Think step-by-step and describe your plan for what to build in pseudocode, written out in great detail, unless asked not to do so.
2. Output the code in a single code block.
3. You should always generate short suggestions for the next user turns that are relevant to the conversation.
4. You can only give one reply for each conversation turn.
5. The active document is the source code the user is looking at right now.
]],
vim.loop.os_uname().sysname
)

local PROMPT_LIBRARY = {
    -- Custom the default prompt
    ["Generate a Commit Message"] = {
        strategy = "inline",
        description = "Generate a commit message",
        opts = {
            index = 10,
            auto_submit = true,
            is_default = true,
            is_slash_cmd = true,
            placement = "before",
            short_name = "commit",
        },
        prompts = {
            {
                role = "user",
                content = string.format([[
You are an expert at following the Conventional Commit specification.
I would like you to generate an appropriate commit message using the conventional commit format.
Do not write any explanations or other words, just reply with the commit message.
Start with a short headline as summary but then list the individual changes in more detail.
Write clear, informative commit messages that explain the 'what' and 'why' behind changes, not just the 'how'.
Text other than Summary needs to be wrapped if it exceeds 80 characters.
Please generate a commit message for me:

```diff
%s
```
]], vim.fn.system("git diff --no-color --no-ext-diff --cached")),
                opts = {
                    contains_code = true,
                },
            },
        },
    },
    -- Additional customized custom prompts
    ["Translate"] = {
        strategy = "chat",
        description = "Translate the selection into Traditional Chinese",
        opts = {
            index = 100,
            auto_submit = true,
            is_slash_cmd = true,
            modes = { "v" },
            short_name = "trans",
            adapter = {
                name = "copilot",
                model = "gpt-4o",
            },
        },
        prompts = {
            {
                role = "user",
                content = [[
You are an expert translator with fluency in English and Chinese languages.
Please translate the selection into Traditional Chinese.
                ]],
            }
        }
    },
    ["Proofreader"] = {
        strategy = "chat",
        description = "Proofread the selection",
        opts = {
            index = 101,
            auto_submit = true,
            is_slash_cmd = true,
            modes = { "v" },
            short_name = "proof",
            adapter = {
                name = "copilot",
                model = "gpt-4o",
            },
        },
        prompts = {
            {
                role = "system",
                content = [[
You are an expert English writing assistant. Your task is to review text for:
- Spelling errors
- Grammatical mistakes
- Punctuation errors
- Verb tense issues
- Non-native phrasing that could be improved
- Clarity and readability issues
- Word choice improvements

Provide specific corrections and explain why changes improve the text. Focus on making the writing sound more natural and professional.
                ]],
                opts = {
                    visible = false,
                },
            },
            {
                role = "user",
                content = "Please review the selected text for spelling errors, grammatical mistakes, and non-native phrasing. Provide improved alternatives or corrections where necessary.",
                opts = {
                    contains_code = false,
                },
            },
        },
    },
    ["Add Documentation"] = {
        strategy = "inline",
        description = "Add documentation to the selected code",
        opts = {
            index = 102,
            auto_submit = true,
            is_slash_cmd = true,
            modes = { "v" },
            short_name = "doc",
            stop_context_insertion = true,
        },
        prompts = {
            {
                role = "system",
                content = [[
When asked to add documentation, follow these steps:
1. **Identify Key Points**: Carefully read the provided code to understand its functionality.
2. **Review the Documentation**: Ensure the documentation:
    - Includes necessary explanations.
    - Helps in understanding the code's functionality.
    - Follows best practices.
    - Is formatted correctly.
                ]],
                opts = {
                    visible = false,
                },
            },
            {
                role = "user",
                content = function(context)
                    local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
                    return "Please document the selected code:\n\n```" .. context.filetype .. "\n" .. code .. "\n```\n\n"
                end,
                opts = {
                    contains_code = true,
                },
            },
        },
    },
    ["Refactor"] = {
        strategy = "chat",
        description = "Refactor the selected code for readability, maintainability and performances",
        opts = {
            index = 103,
            auto_submit = true,
            is_slash_cmd = true,
            modes = { "v" },
            short_name = "refactor",
            stop_context_insertion = true,
        },
        prompts = {
            {
                role = "system",
                content = [[
When asked to optimize code, follow these steps:
1. **Analyze the Code**: Understand the functionality and identify potential bottlenecks.
2. **Implement the Optimization**: Apply the optimizations including best practices to the code.
3. **Shorten the code**: Remove unnecessary code and refactor the code to be more concise.
3. **Review the Optimized Code**: Ensure the code is optimized for performance and readability. Ensure the code:
- Maintains the original functionality.
- Naming conventions that are unclear, misleading or doesn't follow conventions for the language being used.
- The presence of unnecessary comments, or the lack of necessary ones.
- Overly complex expressions that could benefit from simplification.
- High nesting levels that make the code difficult to follow.
- The use of excessively long names for variables or functions.
- Any inconsistencies in naming, formatting, or overall coding style.
- Repetitive code patterns that could be more efficiently handled through abstraction or optimization.
- Is more efficient in terms of time and space complexity.
- Follows best practices for readability and maintainability.
- Is formatted correctly.

Use Markdown formatting and include the programming language name at the start of the code block.
                ]],
                opts = {
                    visible = false,
                },
            },
            {
                role = "user",
                content = function(context)
                    local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

                    return "Please optimize the selected code:\n\n```" .. context.filetype .. "\n" .. code .. "\n```\n\n"
                end,
                opts = {
                    contains_code = true,
                },
            },
        },
    },
    ["Review Code"] = {
        strategy = "chat",
        description = "Review code and provide suggestions for improvement.",
        opts = {
            index = 104,
            auto_submit = true,
            is_slash_cmd = true,
            modes = { "v" },
            short_name = "review",
            stop_context_insertion = true,
        },
        prompts = {
            {
                role = "system",
                content = [[
Your task is to review the provided code snippet, focusing specifically on its readability and maintainability.
Identify any issues related to:
- Naming conventions that are unclear, misleading or doesn't follow conventions for the language being used.
- The presence of unnecessary comments, or the lack of necessary ones.
- Overly complex expressions that could benefit from simplification.
- High nesting levels that make the code difficult to follow.
- The use of excessively long names for variables or functions.
- Any inconsistencies in naming, formatting, or overall coding style.
- Repetitive code patterns that could be more efficiently handled through abstraction or optimization.

Your feedback must be concise, directly addressing each identified issue with:
- A clear description of the problem.
- A concrete suggestion for how to improve or correct the issue.

Format your feedback as follows:
- Explain the high-level issue or problem briefly.
- Provide a specific suggestion for improvement.

If the code snippet has no readability issues, simply confirm that the code is clear and well-written as is.
                ]],
                opts = {
                    visible = false,
                },
            },
            {
                role = "user",
                content = function(context)
                    local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

                    return "Please review the following code and provide suggestions for improvement then refactor the following code to improve its clarity and readability:\n\n```"
                           .. context.filetype .. "\n" .. code .. "\n```\n\n"
                end,
                opts = {
                    contains_code = true,
                },
            },
        },
    },
}

return {
  SYSTEM_PROMPT = SYSTEM_PROMPT,
  PROMPT_LIBRARY = PROMPT_LIBRARY,
}
