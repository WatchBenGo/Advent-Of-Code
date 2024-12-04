$Memory = Get-Content "C:\Users\bsiebers\OneDrive - Epic\Documents\Personal\Advent of Code\2024\12-3\Memory.txt"

$Regex = "mul\((\d+),(\d+)\)"

$Matches = ([regex]$Regex).Matches($Memory)

$Sum = 0

ForEach ($Match in $Matches) {
    $Sum += ([int]$Match.Groups[1].Value * [int]$Match.Groups[2].Value)
}

$Sum