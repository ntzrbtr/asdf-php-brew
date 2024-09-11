<div align="center">

# asdf-php-brew [![Build](https://github.com/ntzrbtr/asdf-php-brew/actions/workflows/build.yml/badge.svg)](https://github.com/ntzrbtr/asdf-php-brew/actions/workflows/build.yml) [![Lint](https://github.com/ntzrbtr/asdf-php-brew/actions/workflows/lint.yml/badge.svg)](https://github.com/ntzrbtr/asdf-php-brew/actions/workflows/lint.yml)

[php-brew](https://github.com/ntzrbtr/asdf-php-brew) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add php-brew
# or
asdf plugin add php-brew https://github.com/ntzrbtr/asdf-php-brew.git
```

php-brew:

```shell
# Show all installable versions
asdf list-all php-brew

# Install specific version
asdf install php-brew latest

# Set a version globally (on your ~/.tool-versions file)
asdf global php-brew latest

# Now php-brew commands are available
php-brew --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/ntzrbtr/asdf-php-brew/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Thomas Off](https://github.com/ntzrbtr/)
