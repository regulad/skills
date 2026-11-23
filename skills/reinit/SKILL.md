---
name: reinit
description: Reads regulad's always-on rules back into the current session, for when they have dropped out of context. Parker runs it by hand; it changes nothing.
disable-model-invocation: true
# How the rules get in: each !`cat` line below runs while the skill renders,
# and its output replaces the line, so Claude receives the rules themselves.
#
# One line per file in rules/, in name order, the same files the hooks read.
# Adding, renaming or removing a rules file means changing this list too.
# No wildcard: Claude Code can't tell that `cat <dir>/*.md` only reads, so in
# auto mode it hands that line to Claude as a command to run instead of
# running it (tested with Claude Code 2.1.318). A plain `cat` of one file runs
# without any allowed-tools grant.
#
# When the session still holds the hooks' copy of a file, Claude Code puts a
# placeholder where the identical output would go instead of repeating it
# (seen on 2.1.318). That's why the body tells Claude to read the files itself
# when it sees placeholders: the rules are in context but have stopped being
# followed, and reading them again is the point.
#
# powershell, not bash: on Windows, bash would run the lines through the Bash
# tool, which Parker's settings deny, and the deny rule aborts the
# invocation. With powershell, Windows runs them through the PowerShell tool,
# and macOS and Linux, which have no PowerShell tool, run them through bash
# anyway. `cat <file>` works in both. The paths are unquoted: the plugin cache
# path has no spaces.
shell: powershell
---

**Your rules are being reiterated: you should still resume execution of your
current task once you read the rules below.** This is not a new task.
Nothing here asks you to start over, summarize your work or stop. Read the
rules, apply them from here on, and carry on where you left off. If there was
no task in progress, say in one line that the rules are loaded.

If the rules don't appear below, or stand only as placeholders, read every
file in `${CLAUDE_PLUGIN_ROOT}/rules/` (in Codex, this plugin's `rules/`
directory, two levels above this file) in name order, and then resume.

!`cat ${CLAUDE_PLUGIN_ROOT}/rules/01-working-with-parker.md`

!`cat ${CLAUDE_PLUGIN_ROOT}/rules/02-building.md`

!`cat ${CLAUDE_PLUGIN_ROOT}/rules/03-pinning-and-data.md`

!`cat ${CLAUDE_PLUGIN_ROOT}/rules/04-parkers-machines.md`

!`cat ${CLAUDE_PLUGIN_ROOT}/rules/05-tracking-work.md`
