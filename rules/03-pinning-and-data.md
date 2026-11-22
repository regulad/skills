# Pinning and data

## Pinning

Anything pinned by a git tag isn't pinned at all: a tag, like a branch, can
be moved after you read it. Pin anything fetched from git by its full
commit SHA, with the readable version beside it:
- **GitHub Actions and reusable workflows:** `uses: owner/repo@<full SHA> #
  v1.2.3`. Never `@main`, and not a tag such as `@v1` unless one of the
  exceptions below applies. Dependabot's `github-actions` ecosystem keeps
  SHA pins and their version comments current.
- **pre-commit hooks:** `rev: <full SHA>  # frozen: v6.0.0`, as
  `pre-commit autoupdate --freeze` writes it, rather than a tag.
- **Git dependencies in Poetry, Cargo and the like:** `rev = "<full SHA>"`
  rather than `tag =`, and never `branch =`.
- **Anything else that takes a git ref:** a commit SHA.

**Plugin marketplaces are exempt.** A Claude Code or Codex marketplace, and
the plugins it lists, may follow their default branch, as dotfiles installs
regulad/skills and the others. Pinning one is still allowed where a project
wants it, as homelab pins alock in its `.claude/settings.json`.

A tag is fine in two cases. Say which one applies, in a comment beside it:
- **The ecosystem makes the tag immutable,** so a published version can't be
  moved or replaced. Examples are a GitHub release marked immutable, or a
  registry that refuses to republish a version.
- **The reference deliberately follows a major version** rather than a
  precise one. For example:
  - a container image tag `:1` that auto-updates within its line;
  - in a traditional package manager, a semver requirement on a major
    version: Cargo's `serde = "1"`, npm's `"^1.4.0"`, Poetry's `^1.4`.

  There is no precise version to pin there, so the tag or range is the
  honest reference. A project that follows Semantic Versioning fully falls
  under this case: following its major version takes only compatible
  releases.

**Don't assume a project follows SemVer because its versions look like
SemVer.** Many don't, especially projects developed with LLMs. RenderCV is
the canonical example: SemVer-shaped versions without SemVer's guarantees.
- **Get positive confirmation before following a major version:** the
  project says it follows SemVer (in its README, CONTRIBUTING or changelog),
  and its release history agrees, with breaking changes only in major
  releases.
- **Without confirmation, pin a precise version.**
- **Record the finding beside the dependency,** as a comment in the
  manifest where its format allows one (`Cargo.toml`, `pyproject.toml`, YAML
  files). For example:
  - `# follows SemVer: its CHANGELOG says so and its history agrees (checked 2026-11-22)`;
  - `# not SemVer despite its version format: pinned exactly`.

  Where the format can't hold a comment, as with `package.json`, record it
  in the project's docs.

Registry packages resolved through a lockfile with checksums are already
pinned by their content: crates.io through `Cargo.lock`, PyPI through
`poetry.lock` or `uv.lock`, Go modules through `go.sum`. Their version
numbers are fine as they are.

## Data files and constants

- **Prefer JSON5 to JSON for data you define,** wherever the consumer reads
  it, for example `renovate.json5`, or a file the project's own code loads
  with a JSON5 parser. The main reason is comments. Where a tool reads JSONC
  instead, as VS Code's settings and `tsconfig.json` are, use that.
- **Keep strict JSON only where the consumer requires it,** as `package.json`
  and Claude Code's `settings.json` do. Put the notes a comment would carry
  in the project's docs.
- **Record the provenance of every magic number or secret** you generate or
  bring in, as a comment beside it: the tool, its version, and the exact
  call, or the source it came from. For example:
  `# generated with Python 3.15.0's stdlib secrets.token_urlsafe(16)`, or
  `# from RFC 9000, section 17.2`. A secret's comment sits beside its key in
  the SOPS file. The comment never contains the value itself.
