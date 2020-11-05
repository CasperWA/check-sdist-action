# Check Python source distribution - GitHub Action

_**Make sure a Python source distribution is buildable and installable.**_

This very simple action will build a source distribution via `python setup.py sdist` from your checked out repository and try to `pip install` it.

## Usage

There are two ways to use this action:

1. First use the [`actions/checkout`](https://github.com/marketplace/actions/checkout) action to checkout your local repository, or
2. Use the `repository` (and possibly `token` and `branch`) inputs to specify any repository.

Concerning the second option, the token might be needed if the chosen repository is private.
For more information about creating a personal access token (PAT) see [here](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token).

Below are examples of jobs representing each of the usage options:

```yml
jobs:
  build-package-1:
    runs-on: ubuntu-latest
    name: Build and install package - option 1
    steps:
    - name: Checkout local repository
      uses: actions/checkout@v2

    - name: Check package can be built and pip install-ed
      uses: CasperWA/check-sdist-action@v1

  build-package-2:
    runs-on: ubuntu-latest
    name: Build and install package - option 2
    steps:
    - name: Check package can be built and pip install-ed
      uses: CasperWA/check-sdist-action@v1
      with:
        repository: octocat/Spoon-Knife
        branch: develop
        token: ${{ secrets.MY_PAT }}
```

## Inputs

**All** inputs are _optional_.

| Name | Description | Default |
|:---:|:---|:---:|
| `repository` | Repository for which to check building and installation of the source distribution.<br>Must be a GitHub repository and the value should be of the form `<owner>/<repository>` (see example under [Usage](#Usage)).<br>If not specified, the repository in the current working directory will be used (use [`actions/checkout`](https://github.com/marketplace/actions/checkout)). | '' |
| `branch` | Branch in `repository`, for which to check building and installation of the source distribution.<br>If not specified, the default branch is used. | '' |
| `token` | Token with which to retrieve `repository`.<br>Used for authentication. See [Usage](#Usage) for information about a personal access token (PAT). | '' |

## License

[MIT License](LICENSE) and copyright by Casper Welzel Andersen.
