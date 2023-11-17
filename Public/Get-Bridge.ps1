function Get-Bridge
{
    [CmdletBinding()]
    param
    (
    )

    ConvertTo-HtmlDocument -Uri 'https://brugopen.nl'
    | Select-HtmlNode -CssSelector '#allbridges th' -All
    | ForEach-Object {
        [PSCustomObject]@{
            PSTypeName = 'UncommonSense.BridgeOpenings.Bridge'
            ID         = ($_ | Select-HtmlNode -CssSelector 'a').GetAttributeValue('href', '')
            Name       = $_ | Select-HtmlNode -CssSelector 'a' | Get-HtmlNodeText
            Location   = $_ | Get-HtmlNodeText
            Latitude   = ($_ | Select-HtmlNode -CssSelector 'span.latitude span.value-title').GetAttributeValue('title','')
            Longitude  = ($_ | Select-HtmlNode -CssSelector 'span.longitude span.value-title').GetAttributeValue('title', '')
        }
    }
}