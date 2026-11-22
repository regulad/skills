# skills

[regulad](https://github.com/regulad)'s rules and skills for coding agents, as
a plugin marketplace for
[Claude Code](https://code.claude.com/docs/en/plugins/create-marketplace) and
[Codex](https://developers.openai.com/codex/plugins/build).

The rules apply to every session and subagent: the plugin's hooks add them
when each one starts. The skills load when a task calls for them.

## Using it

[regulad/dotfiles](https://github.com/regulad/dotfiles) installs it on
regulad's machines and keeps it current. To install it by hand:

```sh
claude plugin marketplace add regulad/skills
claude plugin install regulad@regulad
codex plugin marketplace add regulad/skills
codex plugin add regulad@regulad
```

## Licence

Free software, under the GNU Affero General Public License, version 3 or (at
your option) any later version ([`LICENSE.md`](LICENSE.md)).
