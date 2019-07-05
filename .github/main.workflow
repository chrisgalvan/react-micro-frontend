workflow "Build & Deploy" {
  resolves = ["netlify"]
  on = "push"
}

action "GitHub Action for npm install" {
  uses = "Tgjmjgj/npm@specify-workspace-directory"
  args = "install"
  env = {
    DIR = "host-app"
  }
}

action "GitHub Action for npm build" {
  uses = "Tgjmjgj/npm@specify-workspace-directory"
  needs = ["GitHub Action for npm install"]
  args = "run build"
  env = {
    DIR = "host-app"
  }
}

action "Check host-app" {
  uses = "wcchristian/gh-pattern-filter-action@master"
  needs = ["GitHub Action for npm build"]
  args = "host-app/*"
}

action "netlify" {
  uses = "netlify/actions/cli@master"
  needs = ["Check host-app"]
  runs = "host-app"
  args = "deploy --dir=build"
  env = {
    NETLIFY_AUTH_TOKEN = "b05784ba6e0c5d503fc59c80430d557c0202bab3551579a280e1317762debdb7"
    NETLIFY_SITE_ID = "06a4d13a-6498-449c-8ff5-bc5429c1c955"
  }
}
