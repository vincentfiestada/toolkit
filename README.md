![](./icon.svg)

# toolkit

[![Conventional Commits](https://img.shields.io/badge/commits-conventional-0047ab.svg?labelColor=16161b)](https://conventionalcommits.org)
[![License: BSD Zero Clause](https://img.shields.io/github/license/vncntx/toolkit.svg?labelColor=16161b&color=0047ab)](./LICENSE)

A collection of modular tools for building software projects in Go

## Usage

These tools are written for [PowerShell Core](https://microsoft.com/PowerShell). To install, simply copy the relevant files into your project directory.

```ps1
Copy-Item tools -Recurse ~/project/dir/
Copy-Item presets/go/*   ~/project/dir/
Copy-Item go-tools.ps1   ~/project/dir/tools.ps1
```

By default, the following commands are available:

- **help** - list available commands
- **install** - check dev environment and install project
- **format** - apply style guide and tidy dependencies
- **check** - detect issues using linters
- **fix** - apply autofixes suggested by linters
- **test** - run all tests with coverage
- **run** _[args]_ - compile and run
- **publish** _version_ - publish a version to [pkg.go.dev](https://pkg.go.dev)

## Copyright

Copyright 2021 [Vincent Fiestada](mailto:vincent@vincent.click). This project is released under a [BSD Zero Clause License](./LICENSE).

Icon made by [photo3idea](https://www.flaticon.com/authors/photo3idea-studio).
