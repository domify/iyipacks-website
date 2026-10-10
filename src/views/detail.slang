section.detail
  a.text-link href="#{root}index.html#catalog" ← Back to packages
  .eyebrow= category_name(pack["category"])
  h1!= accent(pack["name"])
  p.lead= pack["description"]
  span.badge class=badge_class(pack) = badge(pack)
  .detail-grid
    div
      h2 Get started
      / One line: whitespace inside pre is shown as is.
      pre!= "<code>#{esc(pack["usage"])}</code>"
      - if std?(pack)
        h2 Notes
        p= field(pack, "note")
        p Included with iyi. No external dependency installation needed.
      - else
        p
          ' iyi get adds it to iyi.mod and fetches its newest version tag. Import it as
          code= "#{pack["module"]}::*"
          | .
        - unless field(pack, "note").empty?
          h2 Notes
          p= field(pack, "note")
        - requires = field(pack, "requires").split(' ').reject(&.empty?)
        - unless requires.empty?
          h2 Requires
          ul
            - requires.each do |path|
              li
                code= path
    aside.metadata
      h3 Package information
      dl
        dt Distribution
        dd= pack["distribution"]
        dt License
        dd= field(pack, "license").empty? ? "Not stated" : field(pack, "license")
        - unless std?(pack)
          dt Version
          dd= field(pack, "version").empty? ? "No release yet" : "#{field(pack, "version")}, #{ago(field(pack, "released"), NOW)}"
          dt Activity
          dd= "#{activity(field(pack, "pushed"), NOW)}, last push #{ago(field(pack, "pushed"), NOW)}"
          dt Stars
          dd= field(pack, "stars")
          dt Used by
          dd= field(pack, "dependents") == "1" ? "1 iyi module" : "#{field(pack, "dependents")} iyi modules"
          dt Contributors
          dd= field(pack, "contributors")
          dt Forks
          dd= field(pack, "forks")
          dt Open issues and PRs
          dd= field(pack, "issues")
          dt Created
          dd= ago(field(pack, "created"), NOW)
      a.button href=pack["source"] target="_blank" rel="noopener noreferrer" View source ↗
      - unless std?(pack)
        p.care
          ' Published by its author, not reviewed by iyipacks. Check the source before you use it.
          a href=REPORT_URL target="_blank" rel="noopener noreferrer" Report a problem ↗
