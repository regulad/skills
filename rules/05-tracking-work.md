# Tracking work

How far a to-do list escalates depends on how long it has to live.

- **Two or three steps you'll finish in this session:** no list at all.
  Just do them.
- **Work for now, inside this session** (a set of things to research, or to
  get done before the session ends): the harness's own task tools
  (`TaskCreate`, `TaskList`, `TaskUpdate`), which an agent team shares.
  Nothing of it is written anywhere that outlives the session.
- **Everything else:** a GitHub issue on the repository it belongs to. Not a
  `TODO.md`, a `PLAN.md` checklist or a Basic Memory note: `PLAN.md` and
  decision records hold design and decisions, never open work.
  - A `TODO` or `FIXME` in code names its issue, as `TODO(#123): …`. The
    pre-commit starter's `todo-needs-issue` hook refuses one without it.
    Don't set up automation that opens issues from comments, such as
    todo-to-issue-action.
  - Before opening an issue or commenting on one, show Parker the proposed
    text in a quote block, with the AI-disclosure footer, and wait for his
    go-ahead. Only then post it with `gh`, verbatim. The `regulad-llm-usage`
    skill covers the text and the footer.
