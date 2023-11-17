function ConvertTo-DateTime
{
    [OutputType([Nullable[datetime]])]
    param
    (
        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [string]$InputObject,

        [switch]$AllowBlank
    )

    switch -Regex ($InputObject)
    {
        '^$'
        {
            if (-not $AllowBlank)
            {
                throw "Cannot parse an empty datetime/date."
            }
            else
            {
                return $null
            }
        }

        '^(?<Day>\d{2})-(?<Month>\d{2})$'
        {
            return Get-Date -Month $Matches.Month -Day $Matches.Day -Hour 0 -Minute 0 -Second 0 -Millisecond 0
        }

        '^(?<Hour>\d{2}):(?<Minute>\d{2})$'
        {
            return Get-Date -Hour $Matches.Hour -Minute $Matches.Minute -Second 0 -Millisecond 0
        }

        '^(?<Day>\d{2})-(?<Month>\d{2})\s(?<Hour>\d{2}):(?<Minute>\d{2})$'
        {
            return Get-Date -Month $Matches.Month -Day $Matches.Day -Hour $Matches.Hour -Minute $Matches.Minute -Second 0 -Millisecond 0
        }

        default
        {
            throw "Cannot parse datetime/date $($_)"
        }
    }
}