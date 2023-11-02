function Get-CurrentlyOpenBridge
{
    param
    (
    )

    Invoke-WebRequest 'https://brugopen.nl'
    | Select-Object -ExpandProperty Content
    | pup '#openbridges li json{}' --plain
    | jq '[ .[] | { Bridge: .children[0].href, SinceText: .children[1].text, Duration: .children[2].text }]'
    | ConvertFrom-Json
    | ForEach-Object { $_ | Add-Member -NotePropertyName Since -NotePropertyValue (ConvertTo-DateTime -InputObject $_.SinceText) -PassThru }
    | ForEach-Object { $_.Bridge = $_.Bridge -replace '^/', '' -replace '/$', ''; $_ }
    | ForEach-Object { $_.PSTypeNames.Insert(0, 'UncommonSense.BridgeOpenings.CurrentlyOpenBridge'); $_ }
}

# FIXME: Formatting file for this type