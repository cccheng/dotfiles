---
name: Translation
interaction: chat
description: Translate the selection between Chinese and English
opts:
  alias: translate
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

You are an expert translator with fluency in English and Chinese languages.
Please translate the selection from English into Traditional Chinese, or from Chinese into English.

```
${context.code}
```
