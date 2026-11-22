---
name: regulad-llm-usage
description: >-
  Parker's (GitHub regulad) standing rules for AI agents: commit trailers,
  commit messages and signing, Signed-off-by, text published under Parker's
  name (issue and PR comments, reviews, descriptions, emails), the
  AI-disclosure footer, other projects' AI policies, licence text, and version
  schemes. Use before any commit, amend, rebase or push; before drafting or
  posting anything on GitHub or another public channel; when contributing to
  a project Parker doesn't own; and when creating a project, setting up its
  pre-commit hooks, choosing or bumping a version, or cutting a release.
---

# Parker's standing rules for agents

These apply in every workspace. In another organization's workspace, its
rules take precedence, and these still apply wherever its rules don't
conflict with them ([Other organizations' projects](#other-organizations-projects)).

## Commits

- Commit when one of these applies:
  - Parker asks for that change.
  - He approved it in advance, for example "commit as you go" for a task.
  - The way the work is done needs a commit. In regulad/homelab, for
    example, alock applies only from commits, so an agent in its own
    worktree commits on that worktree's branch before applying.

  Otherwise leave changes uncommitted.
- Push your commits, unless Parker says otherwise.
- An approval covers only what it names: one change, one task, or one
  repository's stated workflow.
- When the work is done, report what is left uncommitted or unpushed.
- Parker stays author and committer. Never change `user.name` or
  `user.email`, and never pass `--author`.
- Every commit an agent assisted ends with one trailer per assisting model,
  naming the model exactly as its own system prompt states it:

  ```
  Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
  Co-authored-by: Codex <noreply@openai.com>
  ```

  Each line is spelled, capitals included, exactly as that vendor's own tool
  writes it. Codex checks for its exact string (openai/codex,
  `codex-rs/ext/git-attribution`), so any other spelling gets a second
  trailer added. Add the trailer with `git commit --trailer '<line>'`. Keep
  every trailer already there, a contributor's `Co-Authored-By` included, and
  put yours after them. This holds for commits you amend, rebase or rewrite
  too.
- In a web or Remote Control session, Claude Code also asks for a
  `Claude-Session: <session URL>` trailer. Keep it: Parker wants commits
  traceable to their session.
- Never bypass signing: no `--no-gpg-sign`, `-c commit.gpgsign=false` or
  `--no-verify`. Amends and rebases re-sign, as they should.
- **Commit messages and PR titles follow the project's precedent wherever
  it has one:** its CONTRIBUTING, PR template or PR-title check, or a
  consistent style in its `git log` and recently merged PR titles. A squash
  merge turns the PR title into a commit subject, so the two count as one
  style.
- **Where there is no precedent,** because the project is new or its history
  has no consistent style, use Conventional Commits,
  `<type>(<scope>): <summary>`, as regulad/homelab and Parker's PRs to
  bpg/terraform-provider-proxmox do:
  - `<type>` says what kind of change it is: `feat`, `fix`, `docs`,
    `refactor`, `perf`, `test`, `ci`, `build` or `chore`.
  - `<scope>` is the area changed, in the project's own terms: `ceph`,
    `lxc`, `vm`.
  - `!` after the scope marks a breaking change, for example
    `fix(ceph)!: fix pool import by moving storages to proxmox_storage_rbd`.
  - `<summary>` is lowercase and imperative, with no trailing period, and
    names the resource or behaviour, for example
    `feat(ceph): add proxmox_ceph_mds resource`.

  Write a PR title as the squash commit's message, which it becomes.

## Signed-off-by

- Never add `Signed-off-by` with Parker's identity, whether by `-s`,
  `--signoff`, a hand-written line or `git interpret-trailers`, unless he has
  signed off on those specific commits. None of these is his sign-off: a DCO
  check, a CI failure, his being the committer, his sign-off on other
  commits, or a request to commit, push or open a PR.
- In a repository that requires a DCO, stop before pushing and ask him to
  sign off. If he does, take the identity from the repository's git config
  (what `git commit --signoff` would write), and put it last.
- Don't confuse it with commit signing, which is automatic and never
  bypassed.

## Text published under Parker's name

- Never author prose that is posted as Parker: comments, reviews, PR and
  issue descriptions, emails, chat. You may make mechanical changes he asked
  for (close, reopen, merge, label, assign) and post short factual strings he
  specified (a hash, a version, a URL).
- Draft the text in chat, in a Markdown quote block that Parker can copy,
  paste and edit. Post only the text he approved, verbatim. If you change it
  afterwards, show it again before posting.
- A new issue or PR fills in the project's template, not your own
  structure. A reply needs no template.
- An issue or PR either asks for something actionable or adds
  documentation. Research doesn't stand on its own: findings are written up
  as documentation, and captures, dumps or logs are committed only together
  with the write-up of what they show, as a documentation commit.
- Write as Parker writes. Lead with the answer or the verdict, give the
  reason, and stop. No greeting, no sign-off, no hedging, no restating the
  question. Speak in his first person ("I"); the footer says who drafted it.
- Where the project permits AI-drafted text, a terse reply is enough, often
  one sentence: "This is not possible; the module depends on xyz, which is
  under an incompatible licence." Closing or declining something takes a
  label and the reason: "Superseded: main already has Pillow 13.0.0.", "Not
  merging: production runs regulad/homelab's copy of this compose file."
- Be exact, so a reader can check it: short commit SHAs, exact versions,
  issue and PR numbers, and paths, flags and identifiers in backticks. Cite
  only commits that have been pushed: an unpushed SHA resolves to nothing for
  the reader. Say what you verified, and how, when it matters.
- Answering a maintainer's review: "Thanks! All three are in, rebased onto
  the latest `main`:", then one numbered item per point, in their order.
- **Patches by email (`git send-email`):** never suppress CCs (no
  `--suppress-cc`, `sendemail.suppresscc` or `--no-cc-cover`). Parker
  reviews the `Cc:` lines from `--dry-run` before he approves the send.
- Every draft ends with the AI-disclosure footer, in the draft itself and
  not only when it is posted. It names the model as your system prompt
  states it, and the model's ID:

  ```
  ---

  _Drafted by Claude Opus 5.5 (`claude-opus-5-5`); reviewed by @regulad._
  ```

  A project whose AI policy asks for a different form gets that form instead
  ([Other organizations' projects](#other-organizations-projects)).
- In a PR body the footer stands in for a tool's own attribution line: don't
  add Claude Code's `🤖 Generated with [Claude Code](https://claude.com/claude-code)`
  (Parker's settings turn it off) or Codex's
  `Generated with [Codex](https://openai.com/codex/).` A session link that
  Claude Code asks for in a web or Remote Control session stays, after the
  footer.

## Other organizations' projects

Before drafting anything for a project Parker doesn't own, read its
CONTRIBUTING, AGENTS.md and any AI or LLM policy (often in the organization's
`community` or `.github` repository). Where its rules differ, they replace
the footer and the trailers above, and the rest of this skill still applies.
The ones known so far:

- Ansible orgs (ansible, ansible-collections, ansible-community): an
  `Assisted-by:` line opens the issue or PR body, above the template. It
  names the model as your system prompt states it, and the model's ID:

  ```
  Assisted-by: Claude Opus 5.5 (`claude-opus-5-5`), which drafted this issue; reviewed by @regulad.
  ```

  Never use "signed off" wording there: it reads as the DCO trailer.
- podman-container-tools: LLM text may not be posted verbatim in issues,
  comments or PRs, and commits carry no agent trailers. You still draft it.
  Write the report in the project's template, observations only (what
  happens, reproducers, versions), as a copy-and-pastable quote block for
  Parker to edit into his own words. In place of the footer, end it with his
  disclosure line, naming the model as your system prompt states it:

  ```
  An LLM (Claude Opus 5.5) was used to draft this issue and conform findings to the issue template. I have a full understanding of the issue at hand, per the LLM policy.
  ```
- bpg/terraform-provider-proxmox: the standard footer is accepted.

## Licence and other canonical text

- Never write a third-party asset from memory: a licence text, a logo or
  icon's SVG path, a hash, an exact API snippet or config. Download the raw
  file (not through a fetch tool that summarizes it), check it with a script,
  and cite its source and licence beside it. Say up front if anything was
  written from memory.
- Parker's licence is AGPL-3.0-or-later, unless what the code links rules it
  out: GPL-2.0-only code can't be combined with it, so flag the conflict.
  `LICENSE.md` is https://www.gnu.org/licenses/agpl-3.0.md, byte for byte,
  and the README says "version 3 or (at your option) any later version".

## Versioning

- A program that exposes an API to other programs or over a network (a
  library, a plugin, a daemon or server with an HTTP, gRPC or MCP interface)
  uses Semantic Versioning (https://semver.org). The version tracks that API:
  major for a breaking change, minor for an addition, patch for a fix.
- A program that only makes outgoing connections, or that only a person uses
  (a desktop app, a command-line tool meant for a person, a bot or client
  that only calls out), uses its release date: `YYYY.M.D`, as in
  `2026.11.21`. Write the month and day without leading zeros: `2026.1.5`,
  not `2026.01.05`. Cargo and npm reject leading zeros as invalid semver, and
  PEP 440 strips them anyway.
- A second release on the same day appends `_1`, then `_2` and so on, as in
  `2026.11.21_1`, wherever the packaging format accepts it (git tags and
  container image tags do). Python (PEP 440), Cargo and npm reject the
  underscore. In those, ask Parker before a second release that day.
- In Go, tag a date version without the `v`: `2026.11.21`, as cloudflared
  does. Go reads it as a plain tag name, so
  `go install example.com/cmd@2026.11.21` resolves to the tagged commit
  through a pseudo-version. A tag like `v2026.11.21` would be semver major
  2026, which needs a `/v2026` module path.
- A program that does both uses semver. Exposing an API decides it.
- If a project's current scheme doesn't match these rules, point it out, but
  don't convert it unless Parker asks.

## Starting pre-commit hooks

A project of Parker's that has no `.pre-commit-config.yaml` starts from
this, plus hooks for its own languages (formatters and linters it already
uses). regulad/skills' own config is a working copy.
- **Pin the `rev`s** as the Pinning rules say: a full commit SHA with the
  release tag in a `# frozen:` comment. `pre-commit autoupdate --freeze`
  writes them that way.
- **Exclude the licence text** so the whitespace hooks never touch it.
- **Install the commit-message stage too,** so `pre-commit install` installs
  both stages, and set `default_stages: [pre-commit]`. Without it, every
  hook without its own `stages` also runs at the commit-msg stage, against
  the message file.
- **The conventional-commits hook needs a `git-conventional-commits.yaml`**
  at the root, or it fails. Copy its `convention` block (the `commitTypes`,
  and `commitScopes: []`) from the tool's own
  `git-conventional-commits.default.yaml` at the pinned rev. A `convention`
  block must list both keys.

```yaml
default_install_hook_types: [pre-commit, commit-msg]
default_stages: [pre-commit]
# The licence text stays exactly as published.
exclude: '^LICENSE\.md$'
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: <full SHA>  # frozen: <release tag>
    hooks:
      - id: trailing-whitespace
        args: [--markdown-linebreak-ext=md]
      - id: end-of-file-fixer
      - id: mixed-line-ending
        args: [--fix=lf]
      - id: check-yaml
      - id: check-toml
      - id: check-merge-conflict
      - id: check-added-large-files
  # Commit messages follow Conventional Commits where the project has no
  # other precedent (see Commits).
  - repo: https://github.com/qoomon/git-conventional-commits
    rev: <full SHA>  # frozen: <release tag>
    hooks:
      - id: conventional-commits
```

Leave out the conventional-commits hook in a project whose established
commit style isn't Conventional Commits.
