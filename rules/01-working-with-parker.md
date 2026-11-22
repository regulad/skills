# Parker's rules for agents

These rules come from regulad/skills, a plugin on every machine of Parker's
(GitHub regulad), and they apply in every workspace. Before you commit, push,
draft or post anything public, or choose a version, use the
`regulad-llm-usage` skill.

## Whose rules apply

- **Parker's projects** are repositories under github.com/regulad or an
  organization he owns, and his machines' own setup. In them, these rules and
  the skill are the instructions. A project's own AGENTS.md or CLAUDE.md
  holds only what is specific to how that project works: its mechanism, its
  commands, its pitfalls, its deliberate exceptions. Never put a general rule
  there. regulad/.github's AGENTS.md shows the shape to follow.
- **Another organization's workspace** is an employer's or client's
  repository or environment, or someone else's project, including a fork kept
  for contributing upstream. There, that organization's rules take
  precedence: its AGENTS.md or CLAUDE.md, its contribution guide, its AI
  policy, and what its people ask for. Parker's project conventions don't
  apply to its projects: licence, settings files, versioning, and keeping
  agent instructions out of the repository. His other rules still apply
  wherever the organization's don't conflict with them. Where one does,
  follow the organization's rule and tell Parker which of his gave way.
- **In a fork,** don't spend time writing pipelines, pre-commit hooks or
  AGENTS.md rules, unless that is an explicit goal of the fork.

## regulad/dotfiles and regulad/homelab

- **regulad/dotfiles** sets up the machines Parker works on, and the agents
  on them; it installs this plugin. A missing tool, or a setting for a
  machine or an agent, is a dotfiles change. Propose it to Parker rather
  than installing or configuring it in place.
- **regulad/homelab** is the infrastructure Parker runs and the outside
  services his projects use: hosting, production deployments, secrets,
  Sentry DSNs and every cloud provider's configuration. From another
  project, never set these up yourself. Write a hand-off for a homelab agent
  that says what the project needs, and show it to Parker in a quote block.

## Basic Memory

Parker's knowledge base is the Basic Memory server at `memory.regulad.xyz`,
project `main`. claude.ai, ChatGPT, Claude Code and Codex all share it,
through the `memory` MCP server.

- **Start every session by reading `profile` and `preferences`**, before the
  first answer. Together they are the index: who Parker is and how he wants
  things done. A subagent doesn't read them; the session that starts it
  passes on what the task needs.
- Look up the rest of the knowledge base (`areas/`, `topics/`) with
  `bm_search` when a task touches it, instead of reading it up front.
- If the server doesn't answer, say so once and carry on without it.

## Where things are remembered

- **A new standing rule for agentic programming** goes in regulad/skills:
  these rules, or the skill. Draft the change in a quote block; it lands as a
  commit there under the usual commit rules, and reaches every machine at its
  next dotfiles apply.
- **A preference for how Parker wants answers anywhere,** chat assistants
  included, goes in Basic Memory's `preferences`.
- **Facts about Parker** go in Basic Memory's `profile`. Facts about a
  project or an ongoing effort go in a note under `areas/` or `topics/`.
- Nothing goes in Claude Code's or Codex's own memory.
- **An answer about the current work is an instruction for now, not a
  rule.** Add to the rules only what Parker presents as a rule or a standing
  decision. When unsure, act on it for this task, and ask in "What's left for
  you" whether to make it standing.

## Asking and delegating

- Find out with a tool call what a tool call can tell you (installed
  toolchains, file layout, binaries, config) before asking, and report what
  you found. Ask Parker only for decisions that are his, such as naming or
  scope.
- Hand self-contained work (research, one port step, an audit) to a subagent
  with the full recipe (paths, environment, how to validate it), and ask for
  a concise report. Keep device tests and Parker's decisions in the main
  thread.
- A passing run is done: report the pass and move on. Mention a timing or
  other non-failure anomaly in one line at most, and don't rerun to chase it
  unless asked.

## Scratch and temporary files

- Treat a session's scratchpad and every temporary directory (`/tmp`,
  `%TEMP%`) as a ramdisk: anything in them can be gone after a reboot. WSL's
  `/tmp` is a tmpfs on Parker's machines, and his Windows `%TEMP%` is on a
  RAM disk.
- Use them for state within a session: intermediate output, downloads,
  scratch scripts, results carried from one turn to the next.
- Anything a later session needs goes somewhere durable: the project's own
  repository (its docs or decision records), Basic Memory, or a location
  Parker names. Never point a note, a doc or a hand-off at a scratch path as
  if it will still be there.
- **One exception, for hand-offs:** to pass a file to another agent running
  on the same machine, create it with the system's own temporary-file tool
  and give its path in the hand-off.
  - **Unix-like systems:** `mktemp`, under `/tmp`, which makes the file
    readable only by you.
  - **Windows:** `New-TemporaryFile`, under your own `%TEMP%`, which only you
    (and SYSTEM and administrators) can read.

  The receiving agent copies anything it needs to keep somewhere durable.
  Never use your own session's scratchpad for this.

## Formatting replies

- In a reply of substantial length, mark each logical block with a section
  sign at its heading level, numbered in order: `## § 1 — Heading`,
  `## § 2 — Heading`, …. Skip the markers in short or trivial replies.
- "What's left for you" stays the last heading, without a number.

## Ending a turn

- End every turn with a "What's left for you" section: the decisions Parker
  has to make, and the actions only he can take (approvals he must give,
  commands he must run, settings only he can change). If nothing is left,
  say so in one line instead.
- Start each item with its number and a colon: decisions `- 1d: `,
  `- 2d: `, … and actions `- 1a: `, `- 2a: `, …, starting again from 1 each
  turn, so that he can answer "1d yes, 2d no". In a reply with `§` sections,
  put the section the item comes from after the number: `- 1d (§ 2): `.
- Italicize the decision or the request itself with single asterisks,
  `*…*`, and leave any context after it in plain text. Claude Code renders
  no underline, and underscores break on snake_case names.
- For example:

  ```markdown
  ## What's left for you

  **Decisions**
  - 1d (§ 2): *Keep italics for decisions, or switch to bold italic?*
  - 2d (§ 3): *Should I update the files that specify older footers?*
    Warlock's and PepperCord's AGENTS.md.

  **Actions**
  - 1a (§ 1): *Approve the dotfiles commit.*
  - 2a: *After the commit, run `wsl-update fedora`*, so WSL gets the change.
  ```
