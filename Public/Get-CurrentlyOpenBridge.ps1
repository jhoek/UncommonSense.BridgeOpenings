<#
.SYNOPSIS
Retrieves a list of currently open bridges
#>
function Get-CurrentlyOpenBridge
{
    param
    (
    )

    ConvertTo-HtmlDocument -Uri 'https://brugopen.nl'
    | Select-HtmlNode -CssSelector '#openbridges li' -All
    | ForEach-Object {
        $Link = $_ | Select-HtmlNode -CssSelector 'a'
        $SinceText = (($_ | Get-HtmlNodeText -DirectInnerTextOnly) -split 'open sinds ')[1] -replace '\s\(\)$', ''

        [pscustomobject]@{
            PSTypeName = 'UncommonSense.BridgeOpenings.CurrentlyOpenBridge'
            BridgeID   = $Link.GetAttributeValue('href', '') -replace '^/', '' -replace '/$', ''
            BridgeName = $Link | Get-HtmlNodeText
            SinceText  = $SinceText
            Since      = (ConvertTo-DateTime -InputObject $SinceText)
            Duration   = $_ | Select-HtmlNode -CssSelector '.duration' | Get-HtmlNodeText
        }
    }
}