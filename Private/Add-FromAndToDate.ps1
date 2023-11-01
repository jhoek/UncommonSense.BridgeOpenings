function Add-FromAndToDate
{
    param
    (
        [Parameter(Mandatory, ValueFromPipeline)]
        [PSTypeName('UncommonSense.BridgeOpenings.BridgeOpening')]
        $InputObject
    )

    process
    {
        $InputObject.ForEach{
            $From = switch -Regex ($_.FromText)
            {
                '^(?<Hour>\d{2}):(?<Minute>\d{2})$'
                {
                    Get-Date -Hour $Matches.Hour -Minute $Matches.Minute -Second 0 -MilliSecond 0
                }

                '^(?<Day>\d{2})-(?<Month>\d{2})\s(?<Hour>\d{2}):(?<Minute>\d{2})$'
                {
                    Get-Date -Month $Matches.Month -Day $Matches.Day -Hour $Matches.Hour -Minute $Matches.Minute -Second 0 -MilliSecond 0
                }

                default
                {
                    throw "Cannot parse datetime/date $($_)"
                }
            }

            [Nullable[datetime]]$To = switch -Regex ($_.ToText)
            {
                '^$'
                {
                    $null
                }

                '^(?<Hour>\d{2}):(?<Minute>\d{2})$'
                {
                    Get-Date -Hour $Matches.Hour -Minute $Matches.Minute -Second 0 -MilliSecond 0
                }

                default
                {
                    throw "Cannot parse datetime/date $($_)"
                }
            }

            if ($To.HasValue){
                if ($From.Hour -gt $To.Hour)
                {
                    $To = $To.AddDays(1)
                }
            }

            $_
            | Add-Member -NotePropertyName From -NotePropertyValue $From -PassThru
            | Add-Member -NotePropertyName To -NotePropertyValue $To -PassThru
        }
    }
}
