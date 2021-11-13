#!/usr/bin/env pwsh
# Copyright 2021 Vincent Fiestada

. (Join-Path 'tools' 'std' 'std.ps1')
. (Join-Path 'tools' 'std' 'help.ps1')
. (Join-Path 'tools' 'nodejs' 'install.ps1')
. (Join-Path 'tools' 'nodejs' 'format.ps1')
. (Join-Path 'tools' 'nodejs' 'run.ps1')

function Invoke-Tools {
    param(
        [Parameter(ValueFromPipeline=$true)]
        [String] $Command = '',

        [Parameter(ValueFromPipeline=$true)]
        [String[]] $Arguments = @()
    )

    if ($null -eq $Command.Length) {
        Write-Error 'command required'
        exit [Errors]::NoCommand
    }

    $tools = @(
        [Tool]::new(
            'help',
            'list available commands',
            {
                Get-Toolkit $tools
            }
        ),
        [Tool]::new(
            'install',
            'check dev environment and install project',
            {
                Install-NodeJSProject
            }
        ),
        [Tool]::new(
            'format',
            'apply prettier style guide',
            {
                Invoke-Prettier
            }
        ),
        [Tool]::new(
            'start',
            'run development server with live reload',
            {
                Invoke-NpmScript start
            }
        )
    )

    $target = $tools | Where-Object { $_.Command -eq $Command }
    if (-not $target) {
        Write-Error "invalid command '$Command'"
        exit [Error]::InvalidCommand
    }

    Invoke-Command -ScriptBlock $target.Script
}

enum Error {
    NoCommand = 1
}

$command = $args[0]
$arguments = $args[1..($args.Length - 1)]

Invoke-Tools $command $arguments
