param (
    [string] $version
)

$modCppPath = $PSScriptRoot + "/../releases/$version/@vet_unflipping/mod.cpp"

$replaced = (Get-Content $modCppPath) -replace "0.0.0", "$version"

$replaced | Out-File $modCppPath
