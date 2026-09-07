# northbyte.gg - repo guide

Public website for **NorthByte** game servers. Static Hugo site rendered from a
secret-free CUE catalog, served by nginx, deployed to the nas2 cluster as the
`northbyte_web` OPM module behind the Istio gateway.

## Golden rules

- **`catalog.cue` is public.** Never copy secrets into it (no RCON/restic passwords,
  S3 keys, ops UUIDs). Author it from the *public* fields of
  `../opm-releases/nas2/minecraft/values.cue`.
- **Content lives in `catalog.cue`**, not in templates. Adding/removing a server =
  edit `catalog.cue` + rebuild. The schema is `catalog_schema.cue`.
- **`site/data/catalog.json` is generated** (`task generate`) and committed so the
  Docker image builds with Hugo alone. Don't hand-edit it.

## Layout

- `catalog.cue` / `catalog_schema.cue` - content + its contract.
- `site/` - Hugo: `hugo.toml`, `layouts/index.html` (single landing page),
  `layouts/partials/server-card.html`, `static/css/style.css` (aurora theme).
- `Dockerfile` / `nginx.conf` - bake built site into nginx.
- `Taskfile.yml` - `generate`, `build`, `run`, `image`, `push`, `check`, `clean`.

## Commands

```bash
task run     # dev server at http://localhost:1313
task check   # vet CUE + build sanity
task image   # build container (IMAGE=... to set tag)
```

## Deploy

See `DEPLOY.md`. Deploy artifacts are in the OPM repos
(`modules/northbyte_web/`, `opm-releases/nas2/northbyte/`,
`opm-releases/nas2/gateway/`), not here.

## Design

Visual identity is a deliberate dark "aurora/north" theme (Space Grotesk / Sora /
Space Mono; deep navy + aurora teal→violet). Keep it distinctive - see the
`frontend-philosophy` guidance before restyling.

## Change process (OpenSpec)

Design-and-plan work runs through OpenSpec: `openspec/config.yaml` is the constitution
and `openspec/schemas/site-change/` is this repo's project-local workflow -
**proposal → design → tasks, with no specs artifact**. `catalog_schema.cue` plus the
`catalog.cue` that satisfies it are the specification, and `task check` is the gate; a
prose spec would be a second copy nothing checks. Every change carries
`skip_specs: true` in its `.openspec.yaml`; never create an `openspec/specs/` directory.

Use the repo-local `openspec-*` skills in `.claude/skills/`, not the generic ones - they
are patched for this schema.

**Not everything goes through OpenSpec.** Content edits inside the existing schema (a
version bump, a blurb, a link, the notice banner) and anything `mc-website-sync` does as
the tail of a fleet change: just edit and `task check`. OpenSpec is for schema changes,
new content types, layout/theme work, new client-side behavior, build or deploy
changes, and anything implementing a `northbyte-enhancements/` entry. The full threshold
is in `openspec/config.yaml`.

## Working Style for Agents

- Pick the right destination for new work:
  - **Cross-repo design intent, a contract another repo relies on, a policy**: `../northbyte-enhancements/` (an entry, or a new `DN`/`OQN` on an existing one via its skills). Never a local `design.md`.
  - **A repo-scoped slice of an entry**: an OpenSpec change here. Write `enhancement.yaml` at creation (`implements: [{enhancement: "NNNN", decisions: [D1], resolves: []}]`, validated by `../northbyte-enhancements/schema.cue` `#ChangeDeclaration`); the archive skill logs the landing with `task enhancements:delivery:log FROM=northbyte.gg/openspec/changes/archive/<name> SUMMARY="…"` from the workspace root, and `task enhancements:delivery:reconcile` catches a declared change never logged. A `[legacy]` entry defers the log to the rewrite pass. A change that implements no entry carries no file.
  - **A repo-local authoring decision**: a `CLAUDE.md` rule, `README.md` or `DEPLOY.md`, declared in the change's `design.md` Durable decisions section and landed before archive.
  - **A routine change**: a content edit inside the existing schema, or the tail of a fleet change via `mc-website-sync`. Edit and `task check`; no change directory.
- The `openspec-*` skills under `.claude/skills/` are `openspec` 1.12.0 output plus repo-local patches (marked `REPO-LOCAL PATCH` in new-change, propose, continue-change, update-change, apply-change, verify-change, archive-change, bulk-archive-change, explore, onboard). `openspec init` / `openspec update` overwrite them: after either, re-apply from git history (`git checkout -- .claude/skills/`) and diff.

### Source of truth precedence

When guidance conflicts, the most-specific source wins: a loaded skill > `openspec/config.yaml` (normative) > this `CLAUDE.md` > the `northbyte-enhancements` entry a change declares, for intent and rationale. If implementation shows a live entry decision must change, amend the entry in the same batch; a reversal is a new `DN`, never an edit.
