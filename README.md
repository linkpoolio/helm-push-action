# Helm Repo Pusher

Pushes an entire directory of Helm Charts to a [ChartMuseum](https://chartmuseum.com/) instance.

This Github Action is a fork of goodsmileduck's [helm push action](https://github.com/Goodsmileduck/helm-push-action). 

This fork varies in that rather than pushing just a singular helm chart, it will push all of the charts in the given `${SOURCE_DIR}`.

Thus if you are using a GitHub Repository to manage all of your helm charts in one place, you can use this Github Action to automate pushing all of your charts with a very simple CI configuration.

You can also manage multiple Chart repositories (e.g. `stable` and `incubator`) from the same GitHub repository and use this Action to publish each.

## Usage

### `workflow.yml` Example

Place in a `.yml` file such as this one in your `.github/workflows` folder. [Refer to the documentation on workflow YAML syntax here.](https://help.github.com/en/articles/workflow-syntax-for-github-actions)

```yaml
name: release incubator charts

on:
  push:
    branches:
      - master
    paths:
      - 'incubator/**'

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - uses: linkpoolio/helm-push-action@v3
      env:
        SOURCE_DIR: './incubator'
        FORCE: 'True'
        CHARTMUSEUM_URL: 'https://chartmuseum.url'
        CHARTMUSEUM_USER: '${{ secrets.CHARTMUSEUM_USER }}'
        CHARTMUSEUM_PASSWORD: ${{ secrets.CHARTMUSEUM_PASSWORD }}
```

### Configuration

The following settings must be passed as environment variables as shown in the example. Sensitive information, especially `CHARTMUSEUM_USER` and `CHARTMUSEUM_PASSWORD`, should be [set as encrypted secrets](https://help.github.com/en/articles/virtual-environments-for-github-actions#creating-and-using-secrets-encrypted-variables) — otherwise, they'll be public to anyone browsing your repository.

| Key | Value | Suggested Type | Required |
| ------------- | ------------- | ------------- | ------------- |
| `CHARTMUSEUM_URL` | Chartmuseum url | `env` | **Yes** |
| `CHARTMUSEUM_USER` | Username for chartmuseum  | `secret` | **Yes** |
| `CHARTMUSEUM_PASSWORD` | Password for chartmuseum | `secret` | **Yes** |
| `SOURCE_DIR` | The local directory you wish to upload. For example, `./charts`. Defaults to the root of your repository (`.`) if not provided. | `env` | **Yes** |
| `FORCE` | Force chart upload (in case version exist in chartmuseum, upload will fail without `FORCE`). Defaults is `False` if not provided. | `env` | No |

## Action versions

- v2: helm v2.17.0
- v3: helm3 v3.3.1

## License

This project is distributed under the [MIT license](LICENSE.md).
