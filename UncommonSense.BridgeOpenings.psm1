$Public = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )

Foreach ($import in @($Private + $Public))
{
    Try
    {
        . $import.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

class Bridge
{
    Bridge([string]$ID, [string]$Name, [string]$Location)
    {
        $this.ID = $ID
        $this.Name = $Name
        $this.Location = $Location
    }

    [string]$ID
    [string]$Name
    [string]$Location
}

Register-ArgumentCompleter `
    -CommandName 'Get-BridgeOpening' `
    -ParameterName 'Bridge' `
    -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    Get-Bridge
    | Select-Object -ExpandProperty ID
    | Where-Object { $_ -like "$($WordToComplete)*" }
    | ForEach-Object { New-Object -Type System.Management.Automation.CompletionResult -ArgumentList $_, $_, "ParameterValue", $_ }
}