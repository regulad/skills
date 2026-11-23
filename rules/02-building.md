# Building software

## Reuse before writing

Ship as little original code as possible.

**Learn how Parker already does it.** Before writing something, look at how
his other projects handle it:
- his code: GitHub under regulad (`gh search code --owner regulad`) and his
  local clones;
- his recorded decisions: each project's AGENTS.md, DECISIONS.md and PLAN.md,
  and homelab's `.claude/history/`;
- his methods: how his projects set up Sentry, CI, releases, settings files
  and licence notices.

Follow an established pattern or decision rather than inventing a parallel
one. Where his projects already solve something particular to them (glue, an
integration, a convention), port or share that rather than writing a
second. When the same code would live in several of his projects, propose a
common repository for it instead of another copy. Creating one is Parker's
call.

**For a platform's own procedure,** such as attaching an OCI volume or
setting up an image, read the vendor's current documentation first, through
the vendor's MCP server where there is one (Microsoft Learn's for Windows),
and quote what it requires. Then show where Parker's precedent differs, and
let him choose.

**Use maintained libraries for general-purpose logic.** Before writing
logic that isn't the project's own mechanism, find the respectable,
maintained FOSS library that already does it, and use it. That covers
containers and codecs, protocol framing (RTP, SRTP, DNS, HTTP, protobuf),
request signing, argument parsing, schema validation and licence notices.
For example, an AGPL program that writes MP4 links FFmpeg's libavformat
instead of carrying its own muxer.

- **Parker's own code doesn't outrank a maintained upstream.** A fork of his
  is used only for the changes it carries that the project needs. Otherwise
  the project depends on upstream. For a hypothetical example: if he had an
  FFmpeg fork carrying one unrelated commit, that would be no reason to use
  it over upstream FFmpeg.
- Search for prior art first. Prefer, in order: a dependency the project
  already has, the platform's own API, then the ecosystem's established
  library.
- Search the web with the harness's own tools (Claude Code's WebSearch and
  WebFetch). Use the ddg-search MCP only when those are unavailable or
  failing, and brief subagents the same way.
- Prior art you can't reuse as code is the reference: cite its file and
  function in the module's docs, and use it as a test oracle when it has
  machine-readable output.
- Experiments and reverse engineering too: search published research and the
  binaries already in hand before designing one.
- Check the candidate against this project's licence, not only Parker's
  default: a GPL-2.0-only project can't take Apache-2.0 code. Check that the
  library is maintained.
- Update tools such as Dependabot wait 14 days before proposing a release
  (in Dependabot, `cooldown: default-days: 14`). Where a package manager has
  a native cooldown of its own, such as pnpm's `minimumReleaseAge`, you may
  set it. Otherwise don't hold a release back because of its age.
- Write it yourself only when one of these holds, and tell Parker before you
  start, with what you checked:
  - it is the project's mechanism, and a recorded prior-art search found
    nothing adequate;
  - every candidate's licence or EULA rules it out;
  - the platform can't take the library;
  - it's trivial glue of a few dozen lines (never hand-assembled crypto);
  - a measurement shows the library is inadequate.
- When a tool lacks a feature, lead with its native options, the upstream
  issue for the feature, and any convention-level alternative. Don't propose
  a wrapper, drop-in or retagging layer bolted on top unless Parker asks: he
  has turned one down as fragile.
- When you reject a library, record why in the code or the project's docs.
- If using a library needs an install, ask Parker. Tools are declared in
  regulad/dotfiles.

**Keep one source of truth.**
- Never write a constant a second time: derive it, import it or reference it
  from where it is defined.
- Docs point at the code; never restate its tables or layouts.
- Never keep two copies of something, on disk or in a repository, when one
  of them is always the authoritative one. Delete the other, or generate it
  from the source.

**Fix the general problem.** When proposing a fix, say whether it's general
or specific to one case, and prefer the general one. Once a general fix
exists, remove the specific workarounds it replaces.

## CI/CD and builds

- **Cache everything a pipeline downloads or builds,** keyed on the lockfile
  or other inputs it depends on: package downloads, toolchains, compiler
  output, Docker layers. Use the caching built into the actions you already
  use (the `cache` input of setup actions, `astral-sh/setup-uv`'s
  `enable-cache`, `Swatinem/rust-cache`, `gradle/actions/setup-gradle`)
  before writing `actions/cache` steps yourself. A job that starts from
  nothing every run is a bug.
- **Prefer maintained, plug-and-play workflows** to hand-written build steps,
  as with libraries. For container images that means docker/github-builder's
  reusable workflows (`build.yml`, or `bake.yml` for a Bake definition).
  These build each platform on its own native runner and sign provenance.
  Their cache is off by default, so set `cache: true`.
- **Building from a fork or a mirror** (where building is the fork's goal):
  leave upstream's branches untouched. An orphan `ci` branch, made the
  default (with `default_branch: ci` in its `.github/settings.yml`), holds
  only a README and the workflow. The workflow checks the source out of
  `master` (or a manual run's `ref`), never `ci` itself, pins every input,
  and publishes only when a manual run opts in. Put the branch on the
  existing fork, or on the repository named for where the artifacts
  publish, never on a new repository. regulad/nssm and regulad/RSSHub work
  this way.
- **Build for more than one architecture:** aarch64 and amd64 at the
  x86-64-v3 level, on every platform that has both. For example:
  - `linux/arm64` and `linux/amd64/v3` for images;
  - `GOAMD64=v3` for Go;
  - `-C target-cpu=x86-64-v3` for Rust;
  - `-march=x86-64-v3` for C and C++.

  Build each architecture on a native runner rather than under emulation
  where the CI offers one. When a platform, toolchain or dependency rules
  out an architecture or the v3 level, say which in the workflow or the
  docs, and tell Parker.
- **Legacy hardware:** when a project targets hardware older than
  x86-64-v3 can run on, ask Parker whether to target v3 before choosing.
  Examples are the Intel Macs that regulad/dotfiles supports back to macOS
  10.15, and older x86 PCs or servers. Don't assume v3 or a lower baseline
  for him.

## User privacy in telemetry

Error reporting and analytics (Sentry, or anything like it) carry nothing
that identifies a person.

- **No PII:** no names, email addresses, usernames, device names, or the
  contents of messages and files. Leave the SDK's default-PII switch off:
  Sentry's `sendDefaultPii`. Sentry's JavaScript SDK is replacing it with
  `dataCollection`, and passing that option at all makes its categories
  permissive by default, so set `userInfo: false` and each of the others.
- **No IP address is stored.** Turn on the setting that prevents storing IP
  addresses in the Sentry project's Security & Privacy settings, and ask for
  it in the homelab hand-off along with the project. The app never sets one
  itself (no `ip_address` in Sentry's `setUser`), and deny lists keep
  headers such as `X-Forwarded-For` out of events.
- **Approximate location is the one carve-out:** the country, region or
  city the service derives from the connection is fine, as long as the
  address itself isn't kept.
- **Identify a user or device by one opaque ID at most:** a UID, such as a
  random UUID the app keeps per install, or a trace ID. Never an email
  address (hashed or not), a username or a hardware serial in its place.
- Where an existing project sends more than this, tell Parker and propose
  the fix.
