# Deploying northbyte.gg

The site is deployed to the **nas2** cluster as an OPM module behind the shared Istio
gateway. Three pieces, in three repos:

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
