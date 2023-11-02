function Get-Bridge
{
    param
    (
    )

    Invoke-WebRequest 'https://brugopen.nl'
    | Select-Object -ExpandProperty Content
    | pup '#allbridges th json{}' --plain
    | jq '[ .[] | { ID: .children[0].href, Name: .children[0].children[0].text, Location: .text }]'
    | ConvertFrom-Json
    | ForEach-Object { $_.PSTypeNames.Insert(0, 'UncommonSense.BridgeOpenings.Bridge'); $_ }
}

# FIXME: Lat/long? toevoegen