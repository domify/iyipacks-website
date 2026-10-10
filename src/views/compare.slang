section.detail#compare-empty
  h1 Pick a few good tools.
  p Select between 1 and 3 packages from the directory.
  noscript
    p Comparing packages needs JavaScript.
  a.button href="#{root}index.html#catalog" Browse packages ↗

/ One column per package; app.js shows the 1–3 named by ?p= parameters.
section.detail#compare-result hidden=true
  a.text-link href="#{root}index.html#catalog" ← Back to packages
  h1!= accent("Side by side")
  p.lead Find the right building block for your project.
  .table-scroll
    table
      thead
        tr
          th scope="col" Package
          - PACKAGES.each do |pack|
            - slug = pack["slug"]
            th scope="col" data-slug=slug hidden=true
              a href="#{root}packages/#{slug}/index.html"= "#{pack["name"]} ↗"
      tbody
        - COMPARE_ROWS.each do |row|
          tr
            th scope="row"= row[0]
            - PACKAGES.each do |pack|
              td data-slug=pack["slug"] hidden=true = compare_value(pack, row[1])
