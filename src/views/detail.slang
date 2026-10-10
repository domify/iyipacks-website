- kind = pack["kind"].as_s
section.detail
  a.text-link href="#{root}index.html#catalog" ← Back to packages
  .eyebrow= category_name(pack["category"].as_s)
  h1== accent(pack["name"].as_s)
  p.lead= pack["description"].as_s
  span.badge class=badge_class(kind) = kind
  .detail-grid
    div
      h2 Get started
      / One line: whitespace inside pre is shown as is.
      pre== "<code>#{esc(pack["usage"].as_s)}</code>"
      h2 Compatibility notes
      p= pack["note"].as_s
      - if kind == "Native iyi"
        p Included with iyi. No external dependency installation needed.
      - else
        p Install this shard with Crystal’s shards tool and build your application with iyi build --crystal. Compatibility must be checked for the version you choose.
    aside.metadata
      h3 Package information
      dl
        dt Distribution
        dd= pack["distribution"].as_s
        dt License
        dd= pack["license"].as_s
        dt Popularity / release data
        dd Not collected
      a.button href=pack["source"].as_s target="_blank" rel="noopener noreferrer" View source ↗
