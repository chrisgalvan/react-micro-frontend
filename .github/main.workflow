workflow "Build & Deploy" {
  on = "push"
  resolves = ["GitHub Action for npm-1", "GitHub Action for npm-2", "netlify"]
}

action "Check host-app" {
  uses = "wcchristian/gh-pattern-filter-action@master"
  args = "./host-app/**"
}

action "Check micro-apps" {
  uses = "wcchristian/gh-pattern-filter-action@master"
  args = "./micro-apps/**"
}

action "GitHub Action for npm" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  needs = ["Check host-app"]
  args = "npm i && npm run build"
  runs = "host-app"
}

action "GitHub Action for npm-1" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  needs = ["Check micro-apps"]
  runs = "micro-apps/redbox-details"
  args = "npm i && npm run build"
}

action "GitHub Action for npm-2" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  needs = ["Check micro-apps"]
  runs = "micro-apps/redbox-search"
  args = "npm i && npm run build"
}

action "netlify" {
  uses = "netlify/actions/cli@master"
  needs = ["GitHub Action for npm"]
  runs = "host-app"
  args = "deploy --dir=public"
  env = {
    NETLIFY_AUTH_TOKEN = "b05784ba6e0c5d503fc59c80430d557c0202bab3551579a280e1317762debdb7"
    NETLIFY_SITE_ID = "ce1db875-407e-493e-a6fe-1cbb3ec87377"
  }
}
