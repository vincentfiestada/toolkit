# Copyright 2021 Vincent Fiestada

. (Join-Path 'tools' 'std' 'std.ps1')

class NodeJSPackage {
    [String]$Name
    [String]$Version

    NodeJSPackage([String]$Name, [String]$Version) {
        $this.Name = $Name
        $this.Version = $Version
    }
}

function Get-NodeJSPackage {
    $pkgFile = Join-Path (Get-Location) 'package.json'
    if (-not (Test-Path $pkgFile)) {
        Write-Error 'package file not found'
        exit [Error]::NoNodeJSPackage
    }

    $pkg = Get-Content $pkgFile | ConvertFrom-Json
    $name = $pkg.name
    $version = $pkg.version

    if (-not $name) {
        Write-Error 'package name missing'
        exit [Error]::InvalidNodeJSPackage
    }
    if (-not $version) {
        Write-Error 'package version missing'
        exit [Error]::InvalidNodeJSPackage
    }

    return [NodeJSPackage]::new($name, $version)
}

enum Error {
    NoNodeJSPackage = 1
    InvalidNodeJSPackage = 2
}
