# iyipacks

A static catalog site of the iyi standard library and the iyi modules on
GitHub, built from `data/catalog.toml` and `data/modules.toml` by
`src/build.iyi`.

The live site is available at <https://packs.iyi.dev>.

- The HTML is in Slang templates under `src/views/`. Before you change one,
  read Slang's guide to writing templates: `TEMPLATES.md` in
  `.cache/mod/github.com/domify/slang@v1.0.0/` after a build, or
  <https://github.com/domify/slang/blob/main/TEMPLATES.md>. Raw output is
  `!=`, not `==`.
- `make update` imports the iyi modules on GitHub into `data/modules.toml`,
  which is generated; corrections go in `[[modules]]` of `data/catalog.toml`.
- `make build` writes the site to `site/`, `make serve` previews it.
- `make check`, `make test` and `make test-smoke` must pass.
