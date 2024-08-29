function Get-BridgeOpening
{
    param
    (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Alias('ID')]
        [string[]]$Bridge
    )

    process
    {
        $Bridge.ForEach{
            $CurrentBridge = $_
            $Url = "https://brugopen.nl/$CurrentBridge"

            ConvertTo-HtmlDocument -Uri $Url
            | Select-HtmlNode -CssSelector '.lastoperations tbody tr' -All
            | ForEach-Object {
                $Th = $_ | Select-HtmlNode -CssSelector 'th' -All
                $Td = $_ | Select-HtmlNode -CssSelector 'td' -All

                [pscustomobject]@{
                    PSTypeName   = 'UncommonSense.BridgeOpenings.BridgeOpening'
                    Bridge       = $CurrentBridge
                    FromText     = $Th[0] | Get-HtmlNodeText
                    ToText       = $Th[1] | Get-HtmlNodeText
                    DurationText = $Td[0] | Get-HtmlNodeText
                    Reason       = $Td[1] | Get-HtmlNodeText
                }
            }
            | ForEach-Object { $_ | Add-FromAndToDate }
        }
    }
}