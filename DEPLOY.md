# Deploying northbyte.gg

The site has **two hosts**:

- **GitHub Pages — canonical**, at `https://northbyte.gg` + `https://www.northbyte.gg`.
- **Kubernetes (nas2) — mirror**, at `https://mc.larnet.eu`.

## GitHub Pages (canonical)

Repo `github.com/emil-jacero/northbyte-web` (public). Every push to `main` runs
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
| CNAME | `www` | `emil-jacero.github.io.` |

(Optional AAAA `@` → `2606:50c0:8000::153` … `:8003::153`.) Replace the apex parking
record; **leave `*.mc.northbyte.gg` untouched** (those are Minecraft connect addresses
on the game LB, port 25565). Once DNS resolves, GitHub auto-issues a Let's Encrypt cert;
then enable **Enforce HTTPS** (Settings → Pages, or
`gh api repos/emil-jacero/northbyte-web/pages -X PUT -F https_enforced=true`).

Content updates: edit `catalog.cue` → `task generate` → commit + push → Pages redeploys.

## Kubernetes mirror (mc.larnet.eu)

Deployed as an OPM module behind the shared Istio gateway. Three pieces, in three repos:

| Piece | Path |
| --- | --- |
| Module (how the image is deployed) | `open-platform-model/modules/northbyte_web/` |
| Release (the actual deployment) | `opm-releases/nas2/northbyte/release.cue` |
| Gateway hostnames (TLS + listener) | `opm-releases/nas2/gateway/release.cue` |

## Prerequisites (one-time)

1. **Container registry.** Pick a registry the cluster can pull from and replace
   `ghcr.io/CHANGEME/northbyte-web` in both `opm-releases/nas2/northbyte/release.cue`
   and `modules/northbyte_web/module.cue` (default). If private, add an
   `imagePullSecret`.

2. **DNS.** Point all three site hostnames at the **Istio ingress** LB IP:
   - `northbyte.gg`     → A → `<Istio ingress LB IP>`   (Cloudflare)
   - `www.northbyte.gg` → A → `<Istio ingress LB IP>`   (Cloudflare)
   - `mc.larnet.eu`     → A → `<Istio ingress LB IP>`   (larnet DNS)

   Find the ingress IP:
   ```bash
   kubectl -n istio-ingress get svc istio-ingressgateway \
     -o jsonpath='{.status.loadBalancer.ingress[0].ip}'
   ```
   Watch the two different larnet LBs:
   - `mc.larnet.eu` (the website) must point at the **HTTP ingress** above.
   - `*.mc.larnet.eu` (e.g. `vanilla.mc.larnet.eu`) are **Minecraft connect**
     addresses pointing at the *Minecraft router* LB on :25565 — leave those alone.
   - `*.mc.northbyte.gg` likewise point at the Minecraft router, not the website.

   Before applying, confirm nothing else already serves HTTP on bare `mc.larnet.eu`:
   ```bash
   kubectl get httproute -A -o json \
     | jq -r '.items[] | select(.spec.hostnames[]? == "mc.larnet.eu") | .metadata.namespace+"/"+.metadata.name'
   ```

## Build & publish the image

```bash
cd northbyte.gg
IMAGE=<registry>/northbyte-web:v0.1.0 task push    # generate -> build -> docker build -> push
```

## Publish the module

```bash
cd open-platform-model/modules
task check
task publish:one MODULE=northbyte_web
# then refresh release pins:
cd .. && task update-deps
```

## Apply (gateway first, so the cert/listener exists)

```bash
cd opm-releases/nas2/gateway
opm release apply release.cue --context=admin@gon1-nas2

cd ../northbyte
cue vet ./...
opm release apply release.cue --context=admin@gon1-nas2 --dry-run
opm release apply release.cue --context=admin@gon1-nas2
```

## Verify

```bash
# cert covers the apex (mc.larnet.eu is already covered by the existing cert)
kubectl -n istio-ingress describe certificate cert-web | grep -A3 'DNS Names'

# site is live with valid TLS on all three hostnames
curl -I https://northbyte.gg
curl -I https://www.northbyte.gg
curl -I https://mc.larnet.eu
```

Then open `https://northbyte.gg` and confirm the cards render and the copy-address
buttons work.

## Updating content later

Edit `catalog.cue`, then rebuild/push a new image tag, bump `values.image.tag` in the
release, and re-apply. No module or gateway change needed for content-only updates.
