# iyipacks

A package directory written in iyi, inspired by the
[Ruby Toolbox](https://www.ruby-toolbox.com/). An iyi program reads
`data/catalog.toml` and generates a finished static site: the web server only
serves HTML, CSS, JavaScript and JSON files. No Crystal compatibility mode or
external libraries are needed.

## Getting started

Requirements: **iyi 0.16.2 or later** and `make`. Run these commands from the
project root:

```sh
cd ~/contribute/iyipacks
make build   # writes the site into site/
make serve   # optional local preview at http://127.0.0.1:3000
```

`OUT=dist make build` writes somewhere else. `PORT` and `HOST` change the
preview address. For production, upload the contents of `site/` to any static
web host (nginx, Caddy, GitHub Pages, …) serving it from the root of its
domain; links are root-relative. Configure the host to answer missing pages
with `404.html`.

## Features

- 19 entries: 16 iyi standard library modules and 3 Crystal ecosystem libraries.
- 5 categories with their own pre-rendered pages, so browsing works without JavaScript.
- Name and description search, compatibility filtering and A–Z / Z–A sorting run
  in the browser (`public/app.js`); the state is kept in the URL, e.g. `/?q=http`.
- Package pages with import examples, source links, and compatibility notes.
- Side-by-side comparison of up to three packages at `/compare/?p=http&p=json`
  (needs JavaScript).
- Responsive light and dark themes matching iyi.dev, visible keyboard focus, and a `/` search shortcut.
- `packages.json` holds the catalog as JSON.
- HTML escaping at generation time and a Content Security Policy in every page.

## Updating the catalog

Edit `data/catalog.toml` and run `make build`. Recompiling is only needed when
the iyi sources change; changes to data or to `public/` need only `./bin/build`.

iyi has no TOML module, so `src/toml.iyi` reads the subset the catalog uses:
comments, `[[categories]]` / `[[packages]]` arrays of tables, and bare keys with
`"basic"` (with escapes), `'literal'` and `'''multiline literal'''` string values.
Anything else — numbers, inline tables, duplicate keys — stops the build with
its line number. Category and package fields must be strings.

`Native iyi` entries are standard library modules, rather than separately
installable packages. `Crystal compatible` entries refer to the Crystal ecosystem:
they require shard dependencies and the `iyi build --crystal` mode. Check
compatibility for each library version you choose.

This is a curated starter catalog, not a package registry. GitHub stars,
downloads, releases, and maintenance metrics have not been collected.

## Validation

```sh
make check       # Static checking of the generator, preview server and smoke test
make test        # Native iyi tests of the TOML reader and every generated page
make test-smoke  # iyi end-to-end test: build, serve over HTTP, drive headless Chrome
```

`make test-smoke` is written in iyi (`src/smoke.iyi`). It checks that invalid TOML
stops the build, serves a fresh build with the preview server's handler, and
loads pages in headless Chrome to test search, filters, sorting and comparison.
It looks for `google-chrome`, `chromium` or `chromium-browser`; set `CHROME` to
use another binary. Without a browser, it skips those checks and says so.

## Project layout

- `src/build.iyi`: writes the generated files.
- `src/catalog.iyi`: renders every page from the catalog.
- `src/toml.iyi`: the TOML subset reader.
- `src/serve.iyi`, `src/static.iyi`: the local preview server.
- `src/check.iyi`, `src/smoke.iyi`: tests.
- `public/`: page template, CSS, and JavaScript.
- `data/catalog.toml`: categories and package entries.

## Design and verification limitations

The color palette comes from the user-supplied contents of
[iyi.dev’s stylesheet](https://iyi.dev/_astro/Page.CPHo-8Vg.css): white paper,
neutral gray surfaces, and red accents in light mode; charcoal surfaces and
coral accents in dark mode. The theme follows the system color preference.
All component colors, including badges and decorative tiles, use this palette.

Font stacks also follow the reference: Figtree and IBM Plex Mono with system
fallbacks. Font files are not bundled, so browsers use the fallbacks unless the
reference fonts are installed locally. The original website and its font assets
were inaccessible from the development environment.

The site was built with iyi 0.16.2; `make test` and `make test-smoke` passed,
the latter with Google Chrome in headless mode.
