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
            [Nullable[datetime]]$From = ConvertTo-DateTime -InputObject $_.FromText
            [Nullable[datetime]]$To = ConvertTo-DateTime -InputObject $_.ToText -AllowBlank

            if ($To.HasValue)
            {
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