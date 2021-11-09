#!/usr/bin/env pwsh
# Copyright 2021 Vincent Fiestada

. (Join-Path 'tools' 'std' 'std.ps1')

enum Error {
    NotDirectory = 1
}

$target = $args[0]
if (-not (Confirm-IsDirectory $target)) {
    Write-Error "'$target' is not a directory"
    exit [Error]::NotDirectory
}
$toolsDir = (Join-Path $target 'tools')
$toolkitScript = (Join-Path $target 'tools.ps1')

if (-not (Test-Path $toolsDir)) {
    New-Item -ItemType Directory -Name $toolsDir > $null
}
Copy-Item -Recurse -Force tools/std $toolsDir
Copy-Item -Recurse -Force tools/nodejs $toolsDir
if (Test-Path $toolkitScript) {
    Write-Warning "nodejs toolkit already installed in '$target'"
} else {
    Copy-Item -Force tools/nodejs.ps1 $toolkitScript
}

Write-Ok "nodejs toolkit installed in '$target'"