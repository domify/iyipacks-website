# iyipacks

A static catalog site of iyi and Crystal packages, built from
`data/catalog.toml` by `src/build.iyi`.

- The HTML is in Slang templates under `src/views/`. Before you change one,
  read Slang's guide to writing templates: `TEMPLATES.md` in
  `.cache/mod/github.com/domify/slang@v1.0.0/` after a build, or
  <https://github.com/domify/slang/blob/main/TEMPLATES.md>. Raw output is
  `!=`, not `==`.
- `make build` writes the site to `site/`, `make serve` previews it.
- `make check`, `make test` and `make test-smoke` must pass.
