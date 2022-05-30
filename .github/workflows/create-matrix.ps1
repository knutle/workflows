param(
    [string]$OsInput, 
    [string]$PhpInput, 
    [string]$LaravelInput
)

$OsMatrix = ConvertFrom-Json $OsInput
$PhpMatrix = ConvertFrom-Json $PhpInput
$LaravelMatrix = ConvertFrom-Json $LaravelInput

Write-Host "OS: " -NoNewLine
Write-Host $OsMatrix

Write-Host "PHP: " -NoNewLine
Write-Host $PhpMatrix

Write-Host "Laravel: " -NoNewLine
Write-Host $LaravelMatrix
