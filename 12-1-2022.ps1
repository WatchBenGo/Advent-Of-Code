#First Part
$Numbers = Get-Content 'C:\Users\bsiebers\Documents\Personal\Advent of Code\Numbers.txt'
$Max = 0


ForEach ($Row in $Numbers) {
    $Split = $Row.Split(',')
    $Total = 0
    ForEach ($Entry in $Split) {
        $Total = $Total + $Entry
    }
    If ($Total -gt $Max) {
        $Max = $Total
    }
}
$Max


#Second Part
$Numbers = Get-Content 'C:\Users\bsiebers\Documents\Personal\Advent of Code\Numbers.txt'
$Max = 0
$Totals = @()


ForEach ($Row in $Numbers) {
    $Split = $Row.Split(',')
    $Total = 0
    ForEach ($Entry in $Split) {
        $Total = $Total + $Entry
    }
    If ($Total -gt $Max) {
        $Max = $Total
    }
    $Totals += $Total
}
$TopThree = $Totals | Sort -Descending | Select -First 3

$SumTopThree = 0
ForEach ($Elf in $TopThree) {
    $SumTopThree = $SumTopThree + $Elf
}
$SumTopThree
