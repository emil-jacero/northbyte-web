# Build the Hugo site, then serve the static output with nginx.
#
# The catalog data file (site/data/catalog.json) is generated from catalog.cue
# by `task generate` and committed, so this image needs only Hugo — no CUE.
# `task image` runs generate + build before docker build to keep it fresh.

FROM hugomods/hugo:exts AS build
WORKDIR /src
COPY site/ ./site/
RUN hugo --source site --minify --gc --destination /public

FROM nginx:1.27-alpine
LABEL org.opencontainers.image.title="northbyte-web" \
      org.opencontainers.image.description="NorthByte static game-server hub"
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /public /usr/share/nginx/html
EXPOSE 80
