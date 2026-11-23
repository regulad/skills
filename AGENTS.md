# Agent notes for `regulad/skills`

This repository is a plugin marketplace and nothing else: no build, no
package, no release. Claude Code and Codex clone it from GitHub and load what
it holds. [README.md](README.md) says what it is for.

What it holds is the text agents read on all of Parker's machines: the
always-on rules and the skills. General rules for agents belong here, not in
regulad/dotfiles or in a project's AGENTS.md. Two kinds of agent text stay
where they are: a project's notes on its own workings, in its AGENTS.md, and
machine-local extensions describing what dotfiles installs (such as the
Vencord clone's desktop-discord skill), in dotfiles.

## How it is consumed

- regulad/dotfiles installs the marketplace and its plugin, `regulad@regulad`,
  the way it installs the other marketplaces it uses, and doesn't pin it:
  `claude-plugins.sh` and `codex-plugins.sh` add it, and
  `claude-plugin-update.sh` moves Claude Code's copy to the latest commit on
  `master` at every apply.
- So a push to `master` reaches each machine at its next apply, or sooner
  with `claude plugin marketplace update` and
  `claude plugin update regulad@regulad`
  ([manage plugins](https://code.claude.com/docs/en/plugins/install)).
- Every commit on `master` reaches every machine, so each one stands on its
  own: manifests that validate, hooks that run, rules that read complete.
- After pushing, update the installs on the machine you're on, so the change
  is live without waiting for the next apply: run
  `claude plugin marketplace update regulad`, then
  `claude plugin update regulad@regulad`. On a Windows host, run the same in
  each WSL instance that has Claude Code (`wsl --list` names them), through
  its login shell, since `claude` comes from Homebrew's prefix, which only
  the login shell puts on `PATH`:
  `wsl -d <distro> -e zsh -lc 'claude plugin …'`. A session that is already
  running picks the change up after `/reload-plugins` or a restart.

## What goes where

- `rules/`: the always-on rules, as plain Markdown. The plugin's
  [SessionStart](https://code.claude.com/docs/en/hooks#sessionstart) and
  [SubagentStart](https://code.claude.com/docs/en/hooks#subagentstart) hooks
  add them to every session and subagent, one hook per file.
  `skills/reinit/` is `/regulad:reinit`, which Parker runs to read them back
  into a running session. The hooks and `reinit` each list the files by
  name, so a file added, renamed or removed here changes both.
- Each file in `rules/` stands on its own, with its own `#` heading and no
  reference to another file's text: the hooks run in parallel, so the files
  reach the session in no fixed order.
- `hooks/emit-rules.sh` turns one rules file into the hook's JSON. It's POSIX
  `sh` and `awk`, because it runs under Git Bash, macOS and Linux alike.
- `skills/<name>/SKILL.md`: the skills, which load when a task calls for
  them. Both tools find them under `skills/`
  ([Claude Code skills](https://code.claude.com/docs/en/skills),
  [Codex skills](https://developers.openai.com/codex/skills)).
- `.claude-plugin/`: Claude Code's `marketplace.json` and `plugin.json`
  ([marketplaces](https://code.claude.com/docs/en/plugins/create-marketplace),
  [manifest](https://code.claude.com/docs/en/plugins/manifest-reference)).
  The plugin is the repository root, `./`.
- Codex's manifest and marketplace are its own files
  ([Codex plugins](https://developers.openai.com/codex/plugins/build)).

## Limits that shape the files

- Claude Code caps each hook's output at 10,000 characters. Above that,
  Claude gets a file path and a 2,000-character preview, and nothing tells it
  to read the file
  ([Add context for Claude](https://code.claude.com/docs/en/hooks#add-context-for-claude)).
  Keep every file in `rules/` well under it, and split a file rather than
  trim the rules.
- Codex caps each hook message at about 2,500 tokens unless the hook sets
  `additionalContextLimit`, and runs a new or changed hook only after it is
  trusted in `/hooks` ([Codex hooks](https://developers.openai.com/codex/hooks)).
  Tell Parker when a change needs that review.
- Hooks run at every session and subagent start, on Windows (Git Bash),
  macOS and Linux. They read only the plugin's own files, through
  `${CLAUDE_PLUGIN_ROOT}`, use no network, and finish fast.
- No `version` in a manifest or a marketplace entry. Without one, Claude Code
  versions the plugin by its commit; with one, nobody gets a change until the
  string changes
  ([versions and updates](https://code.claude.com/docs/en/plugins/loading#versions-and-updates)).
- The marketplace entry's name and the manifest's `name` are the same, and
  neither takes a form reserved for Anthropic, such as a `claude-` prefix
  ([names](https://code.claude.com/docs/en/plugins/manifest-reference#name)).
- No `CLAUDE.md`: Claude Code doesn't load one at a plugin's root, and
  `claude plugin validate` warns about it. This file is the repository's
  notes.

## Checking a change

- `claude plugin validate .` checks the marketplace and the plugin's manifest
  ([`plugin validate`](https://code.claude.com/docs/en/plugins/cli-reference#plugin-validate)).
  Two warnings are expected: "No version specified" (see above), which is
  why `--strict` can't pass here, and the plugin directory check's missing
  icon, which only matters for a listing in Anthropic's directory. Fix any
  other warning.
- `claude --plugin-dir .` runs a session with this working tree in place of
  the installed plugin, so hooks and skills can be tried before a commit
  ([develop without a marketplace](https://code.claude.com/docs/en/plugins/create#develop-without-a-marketplace)).

## Commits

- Conventional commits: `<type>(<scope>): <summary>`. The scope is `rules`, a
  skill's name, `hooks`, `plugin` for the manifests and marketplaces,
  `pre-commit`, `dependabot`, `settings`, `agents` for this file, or
  `readme`.
- `LICENSE.md` is the FSF's text, byte for byte. Never edit it or reproduce it
  from memory.
