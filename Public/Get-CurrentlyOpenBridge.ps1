function Get-CurrentlyOpenBridge
{
    param
    (
    )

    ConvertTo-HtmlDocument -Uri 'https://brugopen.nl'
    | Select-HtmlNode -CssSelector '#openbridges li' -All
    | ForEach-Object {
        $Link = $_ | Select-HtmlNode -CssSelector 'a'
        $SinceText = $_ | Select-HtmlNode -CssSelector '.openSince' | Get-HtmlNodeText

        [pscustomobject]@{
            PSTypeName = 'UncommonSense.BridgeOpenings.CurrentlyOpenBridge'
            BridgeID   = $Link.GetAttributeValue('href', '') -replace '^/', '' -replace '/$', ''
            BridgeName = $Link | Get-HtmlNodeText
            SinceText = $SinceText
            Since  = (ConvertTo-DateTime -InputObject $SinceText)
            Duration = $_ | Select-HtmlNode -CssSelector '.duration' | Get-HtmlNodeText
        }
    }
}