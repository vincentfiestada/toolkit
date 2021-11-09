# Copyright 2021 Vincent Fiestada

. (Join-Path 'tools' 'std' 'std.ps1')
. (Join-Path 'tools' 'std' 'install.ps1')
. (Join-Path 'tools' 'nodejs' 'package.ps1')

<#
.SYNOPSIS
Install dependencies

.EXAMPLE
Install-Project
#>
function Install-NodeJSProject {
    Write-Info 'inspecting environment'
    Confirm-Ready

    Write-Info 'installing dependencies'
    Install-Dependencies
    
    Install-Hooks
    
    Write-Divider
    Write-Ok 'project installed'
}

<#
.SYNOPSIS
Verify the build environment

.DESCRIPTION
Verify the build environment is set up correctly

.EXAMPLE
Confirm-Ready
#>
function Confirm-Ready {
    # required checks (errors)

    # nodejs must be installed
    if (-not (Get-Command -Name node -ErrorAction SilentlyContinue)) {
        Write-Error 'node is required'
        exit [Error]::NoNodeJS
    }
    # npm must be installed
    if (-not (Get-Command -Name npm -ErrorAction SilentlyContinue)) {
        Write-Error 'npm is required'
        exit [Error]::NoNodePackageManager
    }
    

    # optional checks (warnings)
    # -- none --
}

<#
.SYNOPSIS
Install and verify dependencies

.DESCRIPTION
Install and verify the project dependencies

.EXAMPLE
Install-Dependencies
#>
function Install-Dependencies {
    $NPM_INFO_PATTERN = '^npm info (?<message>.+)$'
    $NPM_REIFY_TIMING_PATTERN = '^npm timing reify (?<message>.+)$'

    npm install --verbose 2>&1 | ForEach-Object {
        $log = $_

        switch -Regex ($log) {
            $NPM_INFO_PATTERN {
                $parsed = Select-String -Pattern $NPM_INFO_PATTERN -InputObject $log
                $message = $parsed.Matches.Groups[1].Value
                Write-Log -Level 'npm' -Message $message -Color Cyan
            }
            $NPM_REIFY_TIMING_PATTERN {
                $parsed = Select-String -Pattern $NPM_REIFY_TIMING_PATTERN -InputObject $log
                $message = $parsed.Matches.Groups[1].Value.ToLower()
                Write-Log -Level 'npm' -Message $message -Color Cyan
            }
            default {
                # ignore
            }
        }
    }
}

enum Error {
    NoNodeJS = 1
    NoNodePackageManager = 2
}