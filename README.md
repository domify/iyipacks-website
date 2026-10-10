# iyipacks

A package directory written in iyi, inspired by the
[Ruby Toolbox](https://www.ruby-toolbox.com/). An iyi program reads
`data/catalog.toml` and `data/modules.toml` and generates a finished static site: the web server only
serves HTML, CSS, JavaScript and JSON files. No Crystal compatibility mode is
needed; the one dependency, the iyi module
[domify/slang](https://github.com/domify/slang), is fetched by the first build.

## Getting started

Requirements: **iyi 0.16.2 or later** and `make`. Run these commands from the
project root:

```sh
cd ~/contribute/iyipacks
make build   # writes the site into site/
make serve   # optional local preview at http://127.0.0.1:3000
```

`OUT=dist make build` writes somewhere else. `PORT` and `HOST` change the
preview address. `site/index.html` can also be opened straight from disk: links
are relative and name each `index.html`. For production, upload the contents of
`site/` to any static web host (nginx, Caddy, GitHub Pages, …), in any directory.
Configure the host to answer missing pages with `404.html`; it is the only page
whose links start from the host's root.

## Features

- The 16 iyi standard library modules and every iyi module found on GitHub, with
  its stars, forks, contributors, latest version tag, last push and how many listed
  modules require it. Crystal shards are not listed.
- 6 categories with their own pre-rendered pages, so browsing works without JavaScript.
- Search, category filtering and sorting by name, stars, use or last update run
  in the browser (`public/app.js`); the state is kept in the URL, e.g. `/?q=http`.
- Package pages with install commands, source links and the GitHub numbers.
- Side-by-side comparison of up to three packages at `/compare/?p=http&p=json`
  (needs JavaScript).
- Responsive light and dark themes matching iyi.dev, visible keyboard focus, and a `/` search shortcut.
- `packages.json` holds the catalog as JSON.
- HTML escaping at generation time and a Content Security Policy in every page.

## Updating the catalog

```sh
GITHUB_TOKEN=… make update   # finds the iyi modules on GitHub, writes data/modules.toml
make build
```

The token may also be kept in `.env` in the project root, as a line
`GITHUB_TOKEN=…`; git ignores that file and the Makefile reads it. A
fine-grained token with read-only access to public repositories and no
permissions is enough.

`make update` (`src/update.iyi`) looks at three kinds of repository: those
with an `iyi.mod` at their root, found by GitHub code search; those with the
topic `iyi`; and the `repo` of each `[[modules]]` entry in `data/catalog.toml`.
It keeps a repository that is not archived and whose `iyi.mod` says
`module github.com/OWNER/REPO` for itself, as `iyi get` requires; that leaves
out applications, whose `iyi.mod` names no repository, and forks that only copy
a module. For each it records the repository's numbers, the highest
`vMAJOR.MINOR.PATCH` tag and its date, the number of contributors (up to 100),
and the modules its `iyi.mod` requires, from which "used by" is counted. The
category comes from the repository's topics, or is `other`.

The requests go through `curl`, as iyi's HTTP client has no TLS, and the token
is given to curl on its standard input. Without `GITHUB_TOKEN` code search is
skipped and GitHub allows 60 requests an hour, enough for a handful of modules.
When GitHub does not answer for a module, its record from the last run is kept;
a refused token or the rate limit stops the run without writing anything.

`data/modules.toml` is generated; do not edit it. A `[[modules]]` entry in
`data/catalog.toml` with the same `repo` replaces any field of the import, such
as `category` or `description`, at build time; `hidden = "true"` leaves the
module out. Edit `data/catalog.toml` for the categories and the standard
library. Changes to data, `style.css` or `app.js` need only `./bin/build`;
templates are compiled into the generator, so `make build` recompiles it.

## Templates

The HTML is written in [Slang](https://github.com/domify/slang), Slim-style
templates for iyi, under `src/views/`:

```slim
section.detail
  h1!= accent(pack["name"])
  p.lead= pack["description"]
  - if std?(pack)
    p Included with iyi.
```

`= expr` writes escaped output, `!= expr` raw HTML, `- code` runs iyi code, and
`| text` is HTML text, in which `#{expr}` is escaped. Local variables of the
method that renders a template are visible in it. As in Slim, there is no
whitespace between tags: `' text` ends the text with a space, and `tag>` or
`=>` puts one after the tag or output (`<` before it).

Slang is required in `src/iyi.mod` (short name `slang`, pinned in
`src/iyi.sum`); `iyi get -u` in `src/` moves it to its latest release. Templates
are compiled into the generator by the `Slang.render` macro. See its README for
the full syntax, and its `TEMPLATES.md` for what differs from Slim. An attribute value without quotes ends at the first space
outside parentheses, so compute longer expressions in a `- name = …` line
first, and keep a space before `=` output after such a value.

TOML is read by [github.com/domify/toml](https://github.com/domify/toml),
the iyi port of toml.cr, so invalid TOML stops the build with its line and
column. Every field of the catalog is a string, the imported numbers too,
and a value of another kind stops the build; `TOML.quote` writes them for
`make update`.

Downloads are not counted: `iyi get` fetches from git, which no one can see.

## Validation

```sh
make check       # Static checking of the generator, preview server and smoke test
make test        # Native iyi tests of the import rules and every generated page
make test-smoke  # iyi end-to-end test: build, serve over HTTP, drive headless Chrome
```

`make test-smoke` is written in iyi (`src/smoke.iyi`). It checks that invalid TOML
stops the build, serves a fresh build with the preview server's handler, and
loads pages in headless Chrome to test search, filters, sorting and comparison.
It looks for `google-chrome`, `chromium` or `chromium-browser`; set `CHROME` to
use another binary. Without a browser, it skips those checks and says so.

## Project layout

- `src/build.iyi`: writes the generated files.
- `src/catalog.iyi`: page data and helpers; renders the templates.
- `src/update.iyi`: the GitHub import; `src/modules.iyi`: its rules, and the dates shown.
- `src/views/`: Slang templates for the layout and every page.
- `src/iyi.mod`, `src/iyi.sum`: the Slang dependency.
- `src/toml.iyi`: the TOML subset reader, and the string writer.
- `src/serve.iyi`, `src/static.iyi`: the local preview server.
- `src/check.iyi`, `src/smoke.iyi`: site tests.
- `public/`: CSS and JavaScript.
- `data/catalog.toml`: categories, the standard library, and module overrides.
- `data/modules.toml`: the modules `make update` imported.

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
