Import-Module (Join-Path -Path $PSScriptRoot -ChildPath UncommonSense.BridgeOpenings.psd1) -Force

Get-Command -Module UncommonSense.BridgeOpenings |
    Convert-HelpToMarkDown `
        -Title 'UncommonSense.BridgeOpenings' `
        -Description 'PowerShell module to retrieve information about (a selection of) Dutch bridges from brugopen.nl' |
    Out-File -FilePath (Join-Path -Path $PSScriptRoot -ChildPath README.md) -Encoding utf8