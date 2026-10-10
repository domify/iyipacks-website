doctype html
html lang="en"
  head
    meta charset="utf-8"
    meta name="viewport" content="width=device-width, initial-scale=1"
    meta name="description" content="Discover native iyi modules and Crystal ecosystem libraries. Browse, search and compare your next building blocks."
    meta name="color-scheme" content="light dark"
    meta http-equiv="Content-Security-Policy" content=CONTENT_SECURITY_POLICY
    title= "#{title} · iyipacks"
    link rel="icon" href=FAVICON
    link rel="stylesheet" href="#{root}style.css"
    script src="#{root}app.js" defer=true
  body
    a.skip-link href="#main" Skip to content
    .shell
      header
        a.logo href="#{root}index.html" aria-label="iyipacks home"
          span.logo-mark== "iyi<span>▰</span>"
          span.logo-name== accent("packs")
        nav aria-label="Main navigation"
          a href="#{root}index.html#catalog" Packages
          a href="#{root}index.html#categories" Categories
          a href="#{root}about/index.html" About
        a.header-link href="https://iyi.dev/" target="_blank" rel="noopener noreferrer" iyi language ↗
      main#main== content
      section.closing
        .eyebrow GOOD TOOLS. BETTER POSSIBILITIES.
        h2
          ' Build something
          em iyi.
        a.text-link href="https://github.com/iyilang/iyi" target="_blank" rel="noopener noreferrer" Meet the language ↗
      footer
        a.footer-logo href="#{root}index.html"== "iyi<span class=\"accent\">packs.</span>"
        span A community-minded directory. Built with iyi.
        a href="#{root}about/index.html" About the catalog ↗
