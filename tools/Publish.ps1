param (
    [string] $version,
    [string] $workshopId,
    [string] $addonDir
)

$choice = Read-Host -Prompt "Do you want to publish '$version' on Steam Workshop? (y/N)"
if ('y' -ne $choice.ToLower()) {
    Write-Host "Skipping Steam Workshop upload"
    Exit
}

try {
    $publisherPath = (Get-ItemProperty -Path Registry::"HKEY_CURRENT_USER\Software\Bohemia Interactive\publisher" -ErrorAction Stop).path
} catch {
    Throw "Can't find Publisher path in registry"
}

$modPath = $PSScriptRoot + "/../releases/$version/$addonDir" | Resolve-Path

$publisherArguments = @(
    "update",
    "/id:$workshopId",
    "/changeNote:""Automatic mod upload""",
    "/path:""$modPath"""
)

Start-Process -FilePath "$publisherPath\PublisherCmd.exe" -NoNewWindow -Wait -ArgumentList $publisherArguments
