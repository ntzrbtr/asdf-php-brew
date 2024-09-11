# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

# TODO: adapt this
asdf plugin test php-brew https://github.com/ntzrbtr/asdf-php-brew.git "php-brew --help"
```

Tests are automatically run in GitHub Actions on push and PR.
