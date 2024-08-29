# UncommonSense.BridgeOpenings

PowerShell module to retrieve information about (a selection of) Dutch bridges from brugopen.nl

## Requirements

Requires UncommonSense.Hap, a PowerShell wrapper for the HTML Agility Pack.

## Index

| Command | Synopsis |
| ------- | -------- |
| [Get-Bridge](#Get-Bridge) | Retrieves a list of all bridges |
| [Get-BridgeOpening](#Get-BridgeOpening) | Retrieves recent bridge openings |
| [Get-CurrentlyOpenBridge](#Get-CurrentlyOpenBridge) | Retrieves a list of currently open bridges |

<a name="Get-Bridge"></a>
## Get-Bridge
### Synopsis
Retrieves a list of all bridges
### Syntax
```powershell
Get-Bridge [<CommonParameters>]
```
<a name="Get-BridgeOpening"></a>
## Get-BridgeOpening
### Synopsis
Retrieves recent bridge openings
### Syntax
```powershell
Get-BridgeOpening [-Bridge] <string[]> [<CommonParameters>]
```
### Parameters
#### Bridge &lt;String[]&gt;
    
    Required?                    true
    Position?                    1
    Default value                
    Accept pipeline input?       true (ByValue, ByPropertyName)
    Accept wildcard characters?  false
<a name="Get-CurrentlyOpenBridge"></a>
## Get-CurrentlyOpenBridge
### Synopsis
Retrieves a list of currently open bridges
### Syntax
```powershell
Get-CurrentlyOpenBridge
```
<div style='font-size:small; color: #ccc'>Generated 29-08-2024 19:05</div>
