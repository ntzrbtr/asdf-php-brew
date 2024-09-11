<div align="center">

# asdf-php-brew [![Build](https://github.com/ntzrbtr/asdf-php-brew/actions/workflows/build.yml/badge.svg)](https://github.com/ntzrbtr/asdf-php-brew/actions/workflows/build.yml) [![Lint](https://github.com/ntzrbtr/asdf-php-brew/actions/workflows/lint.yml/badge.svg)](https://github.com/ntzrbtr/asdf-php-brew/actions/workflows/lint.yml)

[PHP](https://www.php.net/) plugin for the [asdf version manager](https://asdf-vm.com/) or [mise](https://mise.jdx.dev/); uses [Homebrew](https://brew.sh/) for PHP installation instead of compiling PHP.

</div>

Throughout the use of this documentation, whenever `asdf` as a command is used, `mise` should work as well.

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- [curl](https://curl.se/)
- [Homebrew](https://brew.sh/)

# Install

Plugin:

```shell
asdf plugin add php https://github.com/ntzrbtr/asdf-php-brew.git
```

PHP:

```shell
# Show all installable versions
asdf list-all php

# Install specific version
asdf install php 8.2

# Set a version globally (on your ~/.tool-versions file)
asdf global php 8.2
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/ntzrbtr/asdf-php-brew/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Thomas Off](https://github.com/ntzrbtr/)
