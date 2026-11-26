# Tracking work

How far a to-do list escalates depends on how long it has to live.

- **Two or three steps you'll finish in this session:** no list at all.
  Just do them.
- **Work for now, inside this session** (a set of things to research, or to
  get done before the session ends): the harness's own task tools
  (`TaskCreate`, `TaskList`, `TaskUpdate`), which an agent team shares.
  Nothing of it is written anywhere that outlives the session.
- **Everything else:** a GitHub issue on the repository it belongs to. Not a
  `TODO.md`, a checklist in AGENTS.md or a Basic Memory note: AGENTS.md and a
  project's history hold design, decisions and what was done, never open work.
  - A `TODO` or `FIXME` in code names its issue, as `TODO(#123): …`. The
    pre-commit starter's `todo-needs-issue` hook refuses one without it.
    Don't set up automation that opens issues from comments, such as
    todo-to-issue-action.
  - Before opening an issue or commenting on one, show Parker the proposed
    text in a quote block, with the AI-disclosure footer, and wait for his
    go-ahead. Only then post it with `gh`, verbatim. The `regulad-llm-usage`
    skill covers the text and the footer.

## A project's plans and history

- **Plans and instructions go in the project's AGENTS.md:** its goal, its
  design and decisions, and how agents work in it. No `PLAN.md`,
  `DECISIONS.md` or similar file beside it.
- **Nothing goes in `.claude/`, `.codex/` or another harness's folder unless
  it's that harness's own:** its settings (`.claude/settings.json`), or what
  the harness itself makes there, such as `.claude/worktrees/`. No plans,
  notes or history in those folders.
- **Every project keeps a history.** When a piece of work is done, after its
  applies or releases, add an entry: what was done, with the findings a later
  session could use (what a tool really does, what failed and why, what was
  measured and when), not approvals, counts or routine confirmations.
- **History lives in Basic Memory,** project `main`, in
  `areas/<project>-history/`, one note per entry named `<date>.<slug>.md`: the
  date of the work, then its title in lowercase words joined by `-`. The note
  opens with a `# ` title saying what was done. Add a new note for new work;
  edit one only to correct it. Search a project's history before
  investigating something it may already have met. It's never in the
  repository, so a commit never waits on it.
