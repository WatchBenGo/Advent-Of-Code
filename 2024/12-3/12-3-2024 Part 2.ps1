$Memory = Get-Content "C:\Users\bsiebers\OneDrive - Epic\Documents\Personal\Advent of Code\2024\12-3\Memory.txt"

$Regex = "mul\((\d+),(\d+)\)"
$Matches = ([regex]$Regex).Matches($Memory)

$Do = "do\(\)"
$Dont = "don't\(\)"
$Enabled = $True

$Sum = 0 

$Pattern = "(?=mul\(|do\(\)|don't\(\))"

$Instructions = $Memory -split $Pattern

ForEach ($Instruction in $Instructions) {
    If ($Instruction -match $Do) {
        $Enabled = $True
    } ElseIf ($Instruction -match $Dont) {
        $Enabled = $False
    } Else {
        If ($Enabled) {
            $Match = [regex]::Match($Instruction,$Regex)
            If ($Match.Success) {
                $Sum += ([int]$Match.Groups[1].Value * [int]$Match.Groups[2].Value)
            }
        }
    }
    
}

$Sum
