section.detail.prose
  a.text-link href="#{root}index.html" ← Back home
  h1!= accent("A good place to start")
  p.lead A directory of the iyi ecosystem, inspired by the Ruby Toolbox.
  h2 What is in the directory?
  p The iyi standard library, and every iyi module on GitHub: a repository whose iyi.mod at its root names it, so that iyi get can fetch it. Crystal shards are not listed; find them in the Crystal ecosystem's own directories.
  h2 Honest data
  p Stars, forks, issues, contributors, version tags and the last push come from GitHub, as they were when the catalog was last imported. "Used by" counts the listed modules whose iyi.mod requires a module. Downloads are not counted: iyi get fetches from git, and nobody sees that.
  h2 Contribute
  p Give your module's repository the topic iyi, or add it to data/catalog.toml, which also corrects a module's category or description. Every entry links to its source.
  p
    a.button href="https://iyi.dev/" Explore iyi ↗
