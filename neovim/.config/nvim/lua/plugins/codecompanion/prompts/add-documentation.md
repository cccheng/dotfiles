---
name: Add Documentation
interaction: inline
description: Add documentation to the selected code
opts:
  alias: doc
  auto_submit: true
  is_slash_cmd: true
  modes:
    - v
  stop_context_insertion: true
  user_prompt: false
---

## system

When asked to add documentation, follow these steps:
1. **Identify Key Points**: Carefully read the provided code to understand its functionality.
2. **Review the Documentation**: Ensure the documentation:
  - Includes necessary explanations.
  - Helps in understanding the code's functionality.
  - Follows best practices for readability and maintainability.
  - Is formatted correctly.

For C/C++ code: use Doxygen comments using `\` instead of `@`.
For Python code: Use Docstring numpy-notypes format.

## user

Please document the selected code:

```${context.filetype}
${context.code}
```
