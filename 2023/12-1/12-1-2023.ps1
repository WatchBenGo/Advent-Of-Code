$Data = Get-Content "C:\Users\bsiebers\OneDrive - Epic\Documents\Personal\Advent of Code\2023\12-1\Data.txt"

$Total = 0

ForEach ($Line in $Data) {
    $Numbers = $Line -replace "[^0-9]" , ''
    $First = $Numbers[0]
    $Last = $Numbers[$Numbers.Length - 1]
    $StringValue = $First + $Last
    $Value = [Int] $StringValue
    $Total += $Value
}

$Total


$NewTotal = 0 

ForEach ($Line in $Data) {
    $Line = $Line `
        -replace "one","o1e" `
        -replace "two","t2o"`
        -replace "three","t3e"`
        -replace "four","f4r"`
        -replace "five","f5e"`
        -replace "six","s6x"`
        -replace "seven","s7n"`
        -replace "eight","e8t"`
        -replace "nine","n9e"

    $Numbers = $Line -replace "[^0-9]" , ''
    $First = $Numbers[0]
    $Last = $Numbers[$Numbers.Length - 1]
    $StringValue = $First + $Last
    $Value = [Int] $StringValue
    $NewTotal += $Value
}

$NewTotal