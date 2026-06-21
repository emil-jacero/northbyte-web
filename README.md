# northbyte.gg

The public website for **NorthByte** — a small fleet of community game servers.
A static [Hugo](https://gohugo.io) site, rendered from a secret-free CUE catalog and
served by nginx. Deployed to the cluster as an OPM module behind the Istio gateway at
`https://northbyte.gg`.

Today it lists the Minecraft fleet; it's structured to grow to other services
(media, file sync, …) later.

## How it fits together

```
catalog.cue ──(cue export)──> site/data/catalog.json ──(hugo)──> site/public/ ──(docker)──> nginx image
   ▲ curated, secret-free                                                              served at northbyte.gg
```

- **`catalog.cue`** — the only content source. Hand-authored, public fields only.
  Never put RCON/restic passwords, S3 keys, or ops UUIDs here; those stay in
  `opm-releases/nas2/minecraft/values.cue`.
- **`catalog_schema.cue`** — the `#Catalog` / `#Server` / `#Service` contract.
- **`site/`** — the Hugo site (config, the single landing template, the card partial,
  and the static aurora-theme CSS).
- **`Dockerfile` / `nginx.conf`** — bake the built site into an nginx image.

## Local development

Requires `task`, `cue`, and `hugo` (extended).

```bash
task run        # live-reload dev server at http://localhost:1313
task build      # generate data + build static site into site/public
task check      # vet CUE + confirm the site builds
task image      # build the nginx container image (IMAGE=... to override the tag)
```

## Adding or changing a server

1. Edit `catalog.cue` (mirror the public fields from the minecraft release).
2. `task check` to validate.
3. Rebuild and redeploy the image (see deploy below).

## Deploy

The deploy artifacts live in the OPM repos, not here:

- Module: `open-platform-model/modules/northbyte_web/`
- Release: `opm-releases/nas2/northbyte/`
- Gateway hostnames: `opm-releases/nas2/gateway/release.cue`

See `DEPLOY.md` for the full build → publish → apply flow and DNS/registry
prerequisites.
