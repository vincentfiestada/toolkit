# Copyright 2021 Vincent Fiestada

. (Join-Path 'tools' 'std' 'std.ps1')

<#
.SYNOPSIS
Run a script using `npm run`

.EXAMPLE
Invoke-NpmScript
#>
function Invoke-NpmScript {
    param(
        [Parameter(ValueFromPipeline = $true)]
        [String[]]$Arguments = @()
    )

    if ($Arguments.Length -lt 1) {
        Write-Error 'one or more arguments required'
        exit [Errors]::NoArguments
    }

    npm run ($Arguments -Join ' ')
}

enum Errors {
    NoArguments = 1
}