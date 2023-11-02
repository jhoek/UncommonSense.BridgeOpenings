Describe 'UncommonSense.BridgeOpenings' {
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
}