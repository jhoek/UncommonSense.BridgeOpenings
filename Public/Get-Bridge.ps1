function Get-Bridge
{
    [CmdletBinding()]
    param
    (
    )

    Invoke-WebRequest 'https://brugopen.nl'
    | Select-Object -ExpandProperty Content
    | pup '#allbridges th json{}' --plain
    | jq '[ .[] | { ID: .children[0].href, Name: .children[0].children[0].text, Location: .text, Latitude: .children[0].children[0].children[0].children[0].title, Longitude: .children[0].children[0].children[1].children[0].title }]'
    | ConvertFrom-Json
    | ForEach-Object { $_.PSTypeNames.Insert(0, 'UncommonSense.BridgeOpenings.Bridge'); $_ }
}