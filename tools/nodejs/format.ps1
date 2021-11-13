# Copyright 2021 Vincent Fiestada

. (Join-Path 'tools' 'std' 'std.ps1')

<#
.SYNOPSIS
Format code using prettier

.EXAMPLE
Invoke-Prettier
#>
function Invoke-Prettier {
    $errs = [CodeErrorCollection]::new()
    $count = 0

    $path = $null
    $SUCCESS = '^(?<path>.+) (?<time>\d+ms)$'
    $ERROR_START = '^\[error\] (?<path>[^:]+): (?<message>.+)$'
    $ERROR_CONTINUED = '^\[error\] (?<message>.+)$'

    npx prettier --write . 2>&1 | ForEach-Object {
        $log = $_

        switch -Regex ($log) {
            $SUCCESS {
                $count += 1
                $parsed = Select-String -Pattern $SUCCESS -InputObject $log
                $path = $parsed.Matches.Groups[1].Value
                $time = $parsed.Matches.Groups[2].Value

                Write-Info "format '$path' in $time"
            }
            $ERROR_START {
                $count += 1
                $parsed = Select-String -Pattern $ERROR_START -InputObject $log
                $path = $parsed.Matches.Groups[1].Value
                $message = $parsed.Matches.Groups[2].Value

                $errs.Add($path, $message)
                break
            }
            $ERROR_CONTINUED {
                if ($null -eq $path) {
                    Write-Error 'cannot append error to unknown path'
                    exit [Errors]::InvalidState
                }

                $parsed = Select-String -Pattern $ERROR_CONTINUED -InputObject $log
                $message = $parsed.Matches.Groups[1].Value

                $errs.Add($path, $message)
                break
            }
            default {
                # ignore
            }
        }

        
    }

    if ($errs.Count() -gt 0) {
        $errs.Write()
    }

    Write-Ok "examined $count files"
    Write-Divider

    if ($errs.Count() -eq 0) {
        Write-Ok 'style guide applied'
    } else {
        Write-Fail "encountered $( $errs.Count() ) errors"
    }
}

enum Errors {
    NoArguments = 1
    InvalidState = 2
}