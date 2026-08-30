## Why

<!-- The problem or opportunity, in 1-2 sentences. What is a visitor missing, misled by, or
     unable to do? Why now? -->

## What Changes

<!-- Bullet list. Name every file touched (catalog.cue, catalog_schema.cue, site/layouts/...,
     site/static/css/style.css, site/hugo.toml, nginx.conf, Dockerfile). Mark schema changes
     **BREAKING** when existing catalog.cue entries would stop validating. -->

## Before / After

<!-- For a schema or catalog-shape change, the CUE shape as CUE ("none" is the Before of a new
     field). For a layout or styling change, what a visitor sees before and after. -->

**Before**

```cue
```

**After**

```cue
```

## Accuracy

<!-- The site is a public claim about servers that actually exist. For every version, modpack,
     address, or capability this change states, name where in ../deployments/prod/<release>/values.cue
     it comes from. If this is the site catching up to a fleet change, say which one. -->

## Impact

<!-- Does it change catalog_schema.cue? Need a Hugo version, theme, or dependency the build
     doesn't have? Affect both languages? Change the container image or nginx config? -->

## Enhancement

<!-- If this implements decisions from northbyte-enhancements/NNNN, cite the entry and decision
     numbers here. Otherwise "None." -->
