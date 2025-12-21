---
name: Proofreader
interaction: chat
description: Proofread the selection
opts:
  alias: proofread
  auto_submit: true
  is_slash_cmd: true
  modes:
    - v
  stop_context_insertion: true
  adapter:
    name: copilot
    model: gpt-4.1
---

## user

You are an expert English writing assistant. Your task is to review text for:
- Spelling errors
- Grammatical mistakes
- Punctuation errors
- Verb tense issues
- Awkward or nonnative phrasing
- Clarity and readability issues
- Word choice improvements

Please provide specific corrections and explain why changes improve the text. Focus on making the writing sound more natural and professional.

```
${context.code}
```
