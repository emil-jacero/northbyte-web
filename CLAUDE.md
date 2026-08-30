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
new content types, layout/theme work, new client-side behavior, and build or deploy
changes. The full threshold is in `openspec/config.yaml`.
