# Deploying northbyte.gg

**The site has ONE host: GitHub Pages**, at `https://northbyte.gg` + `https://www.northbyte.gg`.

🛑 **This repo is PUBLIC.** Never write an internal hostname, cluster address, LB IP or private
domain into it - not in docs, not in a comment, not in a commit message. The catalog is authored
secret-free for the same reason (`CLAUDE.md`); this file is held to the same rule and was not,
until 2026-09-17.

## GitHub Pages (canonical)

Repo `github.com/northbyte-gg/web` (public). Every push to `main` runs
`.github/workflows/gh-pages.yml` → builds Hugo → deploys to Pages. The custom domain is
pinned by `site/static/CNAME` (`northbyte.gg`) and the repo's Pages settings
(`cname=northbyte.gg`).

**One-time DNS (Namecheap → Advanced DNS for the `northbyte.gg` zone):**

| Type | Host | Value |
| --- | --- | --- |
| A | `@` | `185.199.108.153` |
| A | `@` | `185.199.109.153` |
| A | `@` | `185.199.110.153` |
| A | `@` | `185.199.111.153` |
| CNAME | `www` | `northbyte-gg.github.io.` |

(Optional AAAA `@` → `2606:50c0:8000::153` … `:8003::153`.) Replace the apex parking
record; **leave `*.mc.northbyte.gg` untouched** (those are Minecraft connect addresses
on the game LB, port 25565). Once DNS resolves, GitHub auto-issues a Let's Encrypt cert;
then enable **Enforce HTTPS** (Settings → Pages, or
`gh api repos/northbyte-gg/web/pages -X PUT -F https_enforced=true`).

Content updates: edit `catalog.cue` → `task generate` → commit + push → Pages redeploys.

## Retired: the self-hosted mirror

⚠️ **Removed from this file 2026-09-17.** The site was once also going to be served from the nas2
Kubernetes cluster on an internal hostname, behind the shared Istio gateway, as an OPM module. The
procedure for it lived here from the repo's first commit (2026-06-21).

**It was never deployed** - verified 2026-09-17: no HTTPRoute in the cluster serves that hostname,
and the release paths the procedure named point at `opm-releases`, which was not migrated.

It is gone from here because the instructions named a **private domain in a public repo**, and
because they described a deployment that does not exist. The internal deployment notes, if the
mirror is ever revived, belong in a private repo.

## Updating content

Edit `catalog.cue` → `task check` (vet + regenerate `site/data/catalog.json` + build) → commit
**both** `catalog.cue` and the regenerated JSON → push. Pages redeploys on every push to `main`.
