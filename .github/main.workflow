workflow "Build & Deploy" {
  resolves = [
    "netlify",
    "Tgjmjgj/npm@specify-workspace-directory-2",
    "netlify-1",
  ]
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

action "Tgjmjgj/npm@specify-workspace-directory" {
  uses = "Tgjmjgj/npm@specify-workspace-directory"
  args = "install"
  env = {
    DIR = "micro-apps/redbox-details"
  }
}

action "Tgjmjgj/npm@specify-workspace-directory-1" {
  uses = "Tgjmjgj/npm@specify-workspace-directory"
  args = "install"
  env = {
    DIR = "micro-apps/redbox-search"
  }
}

action "GitHub Action for npm" {
  uses = "Tgjmjgj/npm@specify-workspace-directory"
  needs = ["Tgjmjgj/npm@specify-workspace-directory"]
  args = "run build"
  env = {
    DIR = "micro-apps/redbox-details"
  }
}

action "Tgjmjgj/npm@specify-workspace-directory-2" {
  uses = "Tgjmjgj/npm@specify-workspace-directory"
  needs = ["Tgjmjgj/npm@specify-workspace-directory-1"]
  args = "run build"
  env = {
    DIR = "micro-apps/redbox-search"
  }
}

action "Filters for GitHub Actions" {
  uses = "actions/bin/filter@3c0b4f0e63ea54ea5df2914b4fabf383368cd0da"
  needs = ["GitHub Action for npm", "Tgjmjgj/npm@specify-workspace-directory-2"]
  args = "micro-apps/*"
}

action "netlify-1" {
  uses = "netlify/actions/cli@master"
  needs = ["Filters for GitHub Actions"]
}
