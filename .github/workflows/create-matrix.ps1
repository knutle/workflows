param(
    [string]$OS, 
    [string]$PHP, 
    [string]$Laravel,
    [switch]$Raw
)

$OsMatrix = $OS | ConvertFrom-Json | ConvertFrom-Json
$PhpMatrix = $PHP | ConvertFrom-Json | ConvertFrom-Json

if($Laravel) {
    $LaravelMatrix = $Laravel | ConvertFrom-Json | ConvertFrom-Json
}

$i = -1
$Matrix = $OsMatrix | ForEach-Object { 
    $currentOs = $_

    $PhpMatrix | ForEach-Object {
        $currentPhp = $_

        if($LaravelMatrix) {
            $LaravelMatrix | ForEach-Object {
                $currentLaravel = $_

                if($currentLaravel -eq "8.*") {
                    $currentTestbench = "^6.24"
                } elseif($currentLaravel -eq "9.*") {
                    $currentTestbench = "^7.4"
                } else {
                    $currentTestbench = "x"
                }

                $title = "PHP $currentPhp - "

                if($currentLaravel -ne "x") {
                    $title += "L$currentLaravel - "
                }

                $title += "$currentOs"

                Write-Host "$($title) - Using orchestra/testbench:$currentTestbench"
                
                @{
                    title = $title
                    os = $currentOs
                    php = $currentPhp
                    laravel = $currentLaravel
                    testbench = $currentTestbench
                }
            }
        } else {
            $title = "PHP $currentPhp - $currentOs"

            Write-Host "$($title) - No Laravel"

            @{
                title = $title
                os = $currentOs
                php = $currentPhp
                laravel = "x"
                testbench = "x"
            }
        }
    }
}

if ($Raw) {
  Write-Host ($Matrix | ConvertTo-JSON)
} else {
  # Output the result for consumption by GitHub Actions
  Write-Host "::set-output name=matrix::$($Matrix | ConvertTo-JSON -Compress))"
}
