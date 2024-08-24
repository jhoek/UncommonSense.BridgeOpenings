function Get-Bridge
{
    [CmdletBinding()]
    param
    (
    )

    $Properties = @{
    #         ID         = ($_ | Select-HtmlNode -CssSelector 'a').GetAttributeValue('href', '')
    #         Name       = $_ | Select-HtmlNode -CssSelector 'a' | Get-HtmlNodeText
    #         Location   = $_ | Get-HtmlNodeText
    #         Latitude   = ($_ | Select-HtmlNode -CssSelector 'span.latitude span.value-title').GetAttributeValue('title','')
    #         Longitude  = ($_ | Select-HtmlNode -CssSelector 'span.longitude span.value-title').GetAttributeValue('title', '')
    }

    ConvertTo-HtmlDocument -Uri 'https://brugopen.nl'
    | Select-HtmlNode -CssSelector '#allbridges th' -All
    | Convert-HtmlNode -Property @Properties -Mode CssSelector -TypeName UncommonSense.BridgeOpenings.Bridge
}