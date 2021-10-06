#!/usr/bin/env pwsh
# Copyright 2021 Vincent Fiestada

. (Join-Path 'tools' 'std' 'std.ps1')

enum Error {
    NotDirectory = 1
    AlreadyInstalled = 2
}

$target = $args[0]
if (-not (Confirm-IsDirectory $target)) {
    Write-Error "'$target' is not a directory"
    exit [Error]::NotDirectory
}
$toolsDir = (Join-Path $target 'tools')
$toolkitScript = (Join-Path $target 'tools.ps1')

if (Test-Path $toolkitScript) {
    Write-Warning "go toolkit already installed in '$target'"
    exit [Error]::AlreadyInstalled
}

Copy-Item -Recurse -Force presets/go/* $target
if (-not (Test-Path $toolsDir)) {
    New-Item -ItemType Directory -Name $toolsDir > $null
}
Copy-Item -Recurse -Force tools/std $toolsDir
Copy-Item -Recurse -Force tools/go $toolsDir
Copy-Item -Force tools/go.ps1 $toolkitScript

Write-Ok "go toolkit installed in '$target'"