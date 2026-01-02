---
name: Generate a Commit Message for Staged Files
interaction: inline
description: Generate a commit message
opts:
  alias: commit
  auto_submit: true
  is_slash_cmd: true
  placement: before
  adapter:
    name: copilot
    model: claude-sonnet-4.5
---

## user

You are an expert at following the Conventional Commit specification.
I would like you to generate an appropriate commit message using the conventional commit format.
- Start with a short headline as summary but then list the individual changes in more detail.
- Do not write any explanations or other words, just reply with the commit message.
- Write clear, informative commit messages that explain the 'what' and 'why' behind changes, not just the 'how'.
- Text other than Summary needs to be wrapped if it exceeds 72 characters.

Given the git diff listed below, please generate a commit message for me:

`````diff
${git.staged_diff}
`````

