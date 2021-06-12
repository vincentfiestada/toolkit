![](./icon.svg)

# toolkit

A collection of modular tools for building software projects in Go

## Usage

These tools are written for [PowerShell Core](https://microsoft.com/PowerShell). To install, simply copy the relevant files into your project directory.

```ps1
Copy-Item tools -Recurse ~/project/dir/
Copy-Item presets/go/*   ~/project/dir/
Copy-Item go-tools.ps1   ~/project/dir/tools.ps1

```

By default, the following commands are available:

- **install** - check the dev environment and install the project
- **format** - apply style guide and tidy dependencies
- **check** - check for issues using linters
- **fix** - apply autofixes suggested by linters
- **test** - run all tests with coverage
- **run** _[args]_ - compile and run
- **publish** _version_ - publish a version to [pkg.go.dev](https://pkg.go.dev)

## Copyright

Copyright 2021 [Vincent Fiestada](mailto:vincent@vincent.click). This project is released under a [BSD-3-Clause License](./LICENSE).

Icon made by [photo3idea](https://www.flaticon.com/authors/photo3idea-studio).
