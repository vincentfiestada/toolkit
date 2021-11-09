# Copyright 2021 Vincent Fiestada

. (Join-Path 'tools' 'std' 'std.ps1')

<#
.SYNOPSIS
Install git hooks

.DESCRIPTION
Copy this project's git hooks into the .git directory

.EXAMPLE
Install-Hooks
#>
function Install-Hooks {
    if (-Not (
        (Test-Path '.git' -ErrorAction SilentlyContinue) -And
        (Test-Path 'hooks' -ErrorAction SilentlyContinue)
    )) {
        Write-Info 'no git hooks found'
        return
    }

    New-Item -Type Directory -Force (Join-Path ".git" "hooks") > $null
    foreach ($file in (Get-ChildItem (Join-Path "hooks" "*.*"))) {
        $name = $file.BaseName
        $dest = (Join-Path ".git" "hooks" $name)
        Write-Info "installing $name hook"

        Copy-Item $file $dest
        if (Get-Command chmod -ErrorAction SilentlyContinue) {
            chmod +x $dest
        }
    }
    Write-Ok "git hooks installed"
}