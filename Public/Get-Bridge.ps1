function Get-Bridge
{
    [CmdletBinding()]
    param
    (
    )

    ConvertTo-HtmlDocument -Uri 'https://brugopen.nl'
    | Select-HtmlNode -CssSelector '#allbridges th' -All
    | ForEach-Object {
        [pscustomobject]@{
            PSTypeName = 'UncommonSense.BridgeOpenings.Bridge'
            ID = ($_ | Select-HtmlNode -CssSelector 'a').Attributes['href'].Value
            Name = $_ | Select-HtmlNode -CssSelector 'a' | Get-HtmlNodeText
            Location = $_ | Get-HtmlNodeText -DirectInnerTextOnly
            Latitude = (($_ | Select-HtmlNode -CssSelector 'a').Attributes['data-latlng'].Value -split ',')[0]
            Longitude = (($_ | Select-HtmlNode -CssSelector 'a').Attributes['data-latlng'].Value -split ',')[1]
        }
    }
}