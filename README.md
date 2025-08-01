# Balena CLI

Continuously deliver your applications to [balenaCloud](https://www.balena.io/) using the [official balena CLI tool](https://github.com/balena-io/balena-cli).

Based on [Balena Push](https://github.com/theaccordance/balena-push) from [Joe Mainwaring](https://github.com/theaccordance) and [balena CLI action](https://github.com/bekriebel/balena-cli-action) from [Brint Kriebel](https://github.com/bekriebel).

## Inputs

### `balena_api_token`

**Required**: A BalenaCloud API Token, used to authenticate with BalenaCloud.  API keys can be created in the [user settings for BalenaCloud](https://dashboard.balena-cloud.com/preferences/access-tokens).

### `balena_command`

**Required**: The balena command you would like to run with the action.

### `application_path`

_Optional_: Provide a sub-path to the location for application being deployed to BalenaCloud.  Defaults to the workspace root.

### `balena_secrets`

_Optional_: Provide the contents of a balena secrets.json file for authenticating against private registries.

_Note_: If using private GitHub Packages, you must provide a Personal Access Token instead of using the builtin `secrets.GITHUB_TOKEN`. GitHub currently [does not support](https://github.community/t5/GitHub-Actions/GITHUB-TOKEN-cannot-access-private-packages/m-p/35240) pulling from private package registries using the actions token.

### `balena_url`

_Optional_: Redirects deployment to an openBalena instance instead of Balena Cloud. Should be a URL in the format `cloud.openbalena.com`.

## Workflow Example
```yaml
name: BalenaCloud Deploy

on:
  push:
    # Only run workflow for pushes to specific branches
    branches:
      - master

jobs:
  balena-deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3
      - name: Balena Deploy
        uses: NebraLtd/balena-cli-action@v22.1.4
        if: success()
        with:
          balena_url: cloud.openbalena.com
          balena_api_token: ${{secrets.BALENA_API_TOKEN}}
          balena_command: "deploy my-awesome-app --logs"
          balena_secrets: |
            {
              "docker.pkg.github.com": {
                "username": "${{ secrets.MY_GITHUB_USER }}",
                "password": "${{ secrets.MY_GITHUB_TOKEN }}"
              }
            }
```
