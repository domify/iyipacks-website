section.detail.prose
  a.text-link href="#{root}index.html" ← Back home
  h1!= accent("A good place to start")
  p.lead A directory of the iyi ecosystem, inspired by the Ruby Toolbox.
  h2 What is in the directory?
  p The iyi standard library, and every iyi module on GitHub: a repository whose iyi.mod at its root names it, so that iyi get can fetch it.
  h2 Crystal shards
  p Crystal shards are not listed here, but iyi supports them: build your program with iyi build --crystal, and require a shard as in Crystal.
  p
    a.text-link href="https://shardbox.org/" target="_blank" rel="noopener noreferrer"
      | Find Crystal shards on Shardbox
      span ↗
  h2 Bring a shard over
  p
    ' iyi has a tool that rewrites a shard as iyi modules:
    code> iyi migrate src --out iyi --annotate --check
    | writes the modules, compiles each one and names what is left for a person to finish, such as the types it could not work out.
  p We recommend doing the rest with an LLM as well: give it the shard, the migrated modules and what --check reports, and review what it writes. Then publish the module on GitHub, and it is listed here.
  h2 Honest data
  p Stars, forks, issues, contributors, version tags and the last push come from GitHub, as they were when the catalog was last imported. "Used by" counts the listed modules whose iyi.mod requires a module. Downloads are not counted: iyi get fetches from git, and nobody sees that.
  h2 Add your package
  p There is nothing to fill in or send: publish your module on GitHub, and the next import of the catalog finds it. It is listed when
  ul
    li the repository is public (an archived one is listed too: archived does not mean broken),
    li
      ' an iyi.mod at its root names the repository, as in
      code> module github.com/you/your-module
      | so that iyi get can fetch it,
    li and it has the topic iyi, or GitHub's code search has seen its iyi.mod.
  p The page shows what the repository says about itself: its description, its license, its newest version tag such as v1.0.0, and a category from its topics, such as http, json, template, cli or time. Write those well, and your package reads well here.
  h2 Use packages with care
  p Packages are written and published by their own authors. iyipacks lists them as it finds them on GitHub: it does not review their code and is not responsible for what they contain or do. Read a package's source and check its license before you depend on it.
  p
    ' If a package is malicious or has a serious security problem, report it to
    a> href=GITHUB_ABUSE target="_blank" rel="noopener noreferrer" GitHub ↗
    ' and
    a href=REPORT_URL target="_blank" rel="noopener noreferrer" open an issue for iyipacks ↗
    | . We take such a package off the directory.
  p
    a.button href="https://iyi.dev/" Explore iyi ↗
