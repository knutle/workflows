param([string]$inputJson)

$input = ConvertFrom-Json $inputJson

Write-Host "Generating MATRIX"
Write-Host $inputJson