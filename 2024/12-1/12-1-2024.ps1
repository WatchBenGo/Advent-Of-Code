$Data = Import-Csv "C:\Users\bsiebers\OneDrive - Epic\Documents\Personal\Advent of Code\2024\12-1\Data.csv" -Delimiter ","

$Left = $Data.Left
$Right = $Data.Right

### Part 1
$LeftSort = $Left | Sort
$RightSort = $Right | Sort

$Sum = 0

For ($I = 0; $I -lt 1000; $I++){
    $Num = [Int32]$LeftSort[$I]
    $Entry = [Int32]$RightSort[$I]

    $Sum += [Math]::Abs($Num - $Entry)
}
$Sum


### Part 2

$Similarity = 0

ForEach ($Number in $Left) {
    $Count = 0
    ForEach ($Entry in $Right){
        If ($Number -eq $Entry) {
            $Count++
        }
    }
    $Multiply = [Int32]$Number * $Count
    $Similarity += $Multiply
}
$Similarity