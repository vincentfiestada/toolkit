# Copyright 2021 Vincent Fiestada

. (Join-Path 'tools' 'std' 'std.ps1')
. (Join-Path 'tools' 'go' 'install.ps1')
. (Join-Path 'tools' 'go' 'format.ps1')
. (Join-Path 'tools' 'go' 'check.ps1')
. (Join-Path 'tools' 'go' 'test.ps1')
. (Join-Path 'tools' 'go' 'run.ps1')
. (Join-Path 'tools' 'go' 'publish.ps1')

function Invoke-Tools {
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [String] $Command,

        [Parameter(ValueFromPipeline=$true)]
        [String[]] $Arguments = @()
    )

    if ($null -eq $Command.Length) {
        Write-Error 'command required'
        exit [Errors]::NoCommand
    }

    switch ($Command.ToLower()) {
        'install' {
            Install-GoProject
        }
        'format' {
            Invoke-GoFormat
        }
        'check' {
            Invoke-GoChecks
        }
        'fix' {
            Invoke-GoChecks -Fix
        }
        'test' {
            Invoke-GoTests
        }
        'run' {
            Invoke-GoRun $Arguments
        }
        'publish' {
            Publish-GoModule $Arguments[0]
        }

        default {
            Write-Error "invalid command '$Command'"
            exit [Error]::InvalidCommand
        }
    }

}

enum Error {
    NoCommand = 1
    InvalidCommand = 2
}

Invoke-Tools $args[0] $args[1..($args.Length - 1)]
