Describe 'UncommonSense.BridgeOpenings' {
    BeforeAll {
        Import-Module $PSScriptRoot/UncommonSense.BridgeOpenings.psd1 -Force
    }

    Context 'ConvertTo-DateTime' {
        BeforeAll {
            . ./Private/ConvertTo-DateTime.ps1
        }

        It 'Correctly parses <InputType>' {
            $Output = ConvertTo-DateTime -InputObject $InputObject

            $Output.Day | Should -Be $Day
            $Output.Month | Should -Be $Month
            $Output.Hour | Should -Be $Hour
            $Output.Minute | Should -Be $Minute
            $Output.Second | Should -Be 0
            $Output.Millisecond | Should -Be 0
        } -TestCases @(
            @{InputType = 'times'; InputObject = '11:00'; Day = (Get-Date).Day; Month = (Get-Date).Month; Year = (Get-Date).Year; Hour = 11; Minute = 0 }
            @{InputType = 'date/times'; InputObject = '10-08 11:00'; Day = 10; Month = 8; Year = (Get-Date).Year; Hour = 11; Minute = 0 }
            @{InputType = 'dates'; InputObject = '10-08'; Day = 10; Month = 8; Year = (Get-Date).Year; Hour = 0; Minute = 0 }
        )

        It 'Throws on empty input' {
            { ConvertTo-DateTime -InputObject '' } | Should -Throw
        }

        It 'Returns null on empty input if -AllowBlank is set' {
            ConvertTo-DateTime -InputObject '' -AllowBlank | Should -Be $null
        }
    }

    Context 'Get-Bridge' {
        BeforeAll {
            $Result = Get-Bridge
        }

        It 'All bridges have a valid ID' {
            $Result | Where-Object { -not $_.ID } | Should -HaveCount 0
        }

        It 'All bridges have a valid name' {
            $Result | Where-Object { -not $_.Name } | Should -HaveCount 0
        }

        It 'All bridges have a valid location' {
            $Result | Where-Object { -not $_.Location } | Should -HaveCount 0
        }

        It 'All bridges should have a valid latitude/longitude' {
            $Result | Where-Object { -not $_.Latitude } | Should -HaveCount 0
            $Result | Where-Object { -not $_.Longitude } | Should -HaveCount 0
        }
    }
}