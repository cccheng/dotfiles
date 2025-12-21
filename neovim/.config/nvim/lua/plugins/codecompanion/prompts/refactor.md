---
name: Refactor
interaction: chat
description: Refactor the selected code for readability, maintainability and performances
opts:
  alias: refactor
  auto_submit: true
  is_slash_cmd: true
  modes:
    - v
  stop_context_insertion: true
  user_prompt: false
---

## system

When asked to optimize code, follow these steps:
1. **Analyze the Code**: Understand the functionality and identify potential bottlenecks.
2. **Implement the Optimization**: Apply the optimizations including best practices to the code.
3. **Shorten the code**: Remove unnecessary code and refactor the code to be more concise.
3. **Review the Optimized Code**: Ensure the code is optimized for performance and readability. Ensure the code:
  - Maintains the original functionality.
  - Is more efficient in terms of time and space complexity.
  - Follows best practices for readability and maintainability.
  - Is formatted correctly.
  - Naming conventions that are unclear, misleading or doesn't follow conventions for the language being used. The presence of unnecessary comments, or the lack of necessary ones.
  - Overly complex expressions that could benefit from simplification.
  - High nesting levels that make the code difficult to follow.
  - The use of excessively long names for variables or functions.
  - Any inconsistencies in naming, formatting, or overall coding style.
  - Repetitive code patterns that could be more efficiently handled through abstraction or optimization.

Use Markdown formatting and include the programming language name at the start of the code block.

## user

Please optimize the selected code:

```${context.filetype}
${context.code}
```

