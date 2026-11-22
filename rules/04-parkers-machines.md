# Parker's machines

- **SSH signatures need Parker.** Pushes, fetches, signed commits and
  pam_rssh sudo all sign through Bitwarden's SSH agent, and he approves each
  one. Tell him first, and run the command in the background. After "agent
  refused operation", ssh waits on a passphrase prompt: stop the stuck `git`
  or `ssh` processes, and retry when he's ready.
- **Elevated work goes in one script and one process:** one UAC or sudo
  prompt, progress written to a file, and in-process APIs rather than a loop
  of console programs (`EventLogSession.GlobalSession.ClearLog()`, not
  `wevtutil cl` once per log). An interrupted elevated loop once filled his
  desktop with error dialogs that kept coming back (2026-11-13).
- **Commands for Parker to paste:** split a long Windows command with its
  shell's continuation character: `^` in cmd, a backtick in PowerShell (never
  `^` there). If you don't know the shell, give the cmd form. Claude Code's
  `!` runs bash: write `!` lines in bash, with Windows paths in single
  quotes.
- **WSL:** the login shell is zsh, so `wsl -d <distro> -- <cmd>` globs `?`
  and breaks nested quotes. Use `wsl -d <distro> -e <program> <args>`, or a
  script file run with `-e bash /mnt/c/…`. From pwsh, `~` in an argument
  becomes the Windows home before WSL sees it: use `$HOME` inside
  `-e sh -c '…'`.
- **IPv6 is first class** on Parker's networks. Record every machine or
  subnet (firewall, DNS, tailnet policy, configs) with its IPv6 addresses,
  before IPv4. If only IPv4 is known, ask for the IPv6 counterpart. A missing
  AAAA or PTR record doesn't mean there's no IPv6.
