param(
    [string]$OS, 
    [string]$PHP, 
    [string]$Laravel
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
                } elseif($currentLaravel -eq "8.*") {
                    $currentTestbench = "^7.4"
                } else {
                    $currentTestbench = "x"
                }
                
                @{
                    os = $currentOs
                    php = $currentPhp
                    laravel = $currentLaravel
                    testbench = $currentTestbench
                }
            }
        } else {
            @{
                os = $currentOs
                php = $currentPhp
                laravel = "x"
                testbench = "x"
            }
        }
    }
}

ConvertTo-Json $Matrix