# Project layout

Keep as few files in a project's root as its tools allow. It's for
neatness and nothing else, so what a tool needs always comes first.

- **Canonical locations win.** Where a tool or ecosystem documents where its
  files go, put them there, even when that is the root. Sentry's wizard puts
  `sentry.server.config.ts` and `sentry.edge.config.ts` in the root of a
  Next.js project with `src/`, so they stay there.
- **JavaScript tools' configs go in `.config/`** when the tool officially
  supports a config there: it reads `.config/` by itself, or its maintainers
  name `.config/` as the place for it. ESLint's do, with
  `--config .config/eslint.config.ts` (eslint/eslint#18294). An option that
  accepts any path doesn't count on its own. A config with no supported
  `.config/` location stays in the root, as `next.config.ts` and Next.js's
  PostCSS config do.
- **When a config moves, point everything that reads it at the new path:**
  package scripts, CI cache keys, `tsconfig.json`'s `include` (its `**`
  globs skip dot-directories), and editors, through workspace settings
  committed with the project, such as `.vscode/settings.json`.
- **Code goes in `src/`** wherever the ecosystem supports it or offers it.
  When a scaffolder asks, answer yes, even against its own recommended
  defaults: `create-next-app`'s recommended setup has no `src/` directory,
  and its question "Would you like your code inside a `src/` directory?"
  gets Yes. Parker's Poetry projects use `src/` too (`from = "src"` in
  regulad/aioespn's `pyproject.toml`), though Python doesn't default to it.
- **A chezmoi source state inside a repository goes in `home/`,** with a
  `.chezmoiroot` file at the repository's root containing `home`, as
  chezmoi's guide shows and regulad/dotfiles does. chezmoi then reads the
  source state from `home/`, which keeps the repository's own files, such
  as its README, out of it. Special root files such as
  `.chezmoi.$FORMAT.tmpl` move into `home/` with the rest.
- **Record each placement in the project's AGENTS.md:** what moved out of
  the root and how its tools find it, and what stays in the root and which
  tool requires it.
