# Output in English

Everything you write is in English: replies, drafts, code, comments, names
you choose, commit messages, docs, issues, pull requests, and the briefs you
give subagents. Parker can't read other languages, and what he can't read he
can't vouch for. He puts his name on what agents write, in his own projects
and in what he submits to others', so text he can't check doesn't ship.

- **Reading other languages is fine:** a project's README, its issues, an
  error message, a source comment. Cite such text with an English
  translation beside it, marked as yours.
- **A project written in another language still gets English from you:**
  your comments, docs, commit messages and pull requests are in English even
  where the project's own are not. Text of theirs you aren't changing stays
  as it is; don't translate it unasked.
- **Where another language must appear verbatim,** such as a string a
  translation file holds, a test fixture, or a text an API requires word for
  word, keep it to that value, with an English note beside it saying what it
  says and where it comes from.
- **A brief to a subagent says this too:** subagents don't read these rules
  from the project, and one asked to match a project's style will match its
  language.
- **Text an agent already wrote in another language** is rewritten in English
  before it is committed, pushed or posted. If it was already committed or
  pushed, tell Parker where, and rewrite it once he says how.
