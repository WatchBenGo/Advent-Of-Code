$Data = Get-Content .\2022\12-6\Data.txt

For ($I = 0; $I -lt $Data.Length; $I++) {

    $Array = $Data[($I)..($I + 13)]

    If (($Array | Select-Object -Unique).Count -eq 14) {
        $Index = $I + 14
        Break   
    }
}
$Index