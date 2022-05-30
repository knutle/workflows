param([string]$InputJson)

$input = ConvertFrom-Json $InputJson

Write-Host "Generating MATRIX"
Write-Host $InputJson
$InputJson