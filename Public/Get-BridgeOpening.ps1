function Get-BridgeOpening
{
    param
    (
        [Parameter(Mandatory, ValueFromPipeline)]
        [string[]]$Bridge
    )

    $Bridge.ForEach{
        $CurrentBridge = $_
        $Url = "https://brugopen.nl/$CurrentBridge"

        Invoke-WebRequest -Uri $Url
        | Select-Object -ExpandProperty Content
        | pup '.lastoperations tbody json{}' --plain
        | jq '[.[0].children[] | {FromText: .children[0].text, ToText: .children[1].text, DurationText: .children[2].text, Reason: .children[3].text}]'
        | ConvertFrom-Json
        | ForEach-Object { $_.PSTypeNames.Insert(0, 'UncommonSense.BridgeOpenings.BridgeOpening'); $_ }
        | Foreach-Object { $_ | Add-FromAndToDate }
        | Add-Member -NotePropertyName Bridge -NotePropertyValue $CurrentBridge -PassThru
}
}