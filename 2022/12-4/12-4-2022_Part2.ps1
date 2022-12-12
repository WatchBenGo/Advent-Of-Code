$Pairs = Import-Csv C:\Users\Ben\Desktop\CleaningPairs.csv
$FullOverlaps = 0

ForEach ($Pair in $Pairs) {
    $Elf1 = ($Pair.Elf1).Split('-')
    $Elf2 = ($Pair.Elf2).Split('-')
    $Elf1Array = $Elf1[0]..$Elf1[1]
    $Elf2Array = $Elf2[0]..$Elf2[1]

    $Elf1End = $Elf1Array.Length - 1
    $Elf2End = $Elf2Array.Length - 1


    If (Compare-Object -ReferenceObject $Elf1Array -DifferenceObject $Elf2Array -ExcludeDifferent -IncludeEqual) {
        $OverLap = $True
    } Else {
        $OverLap = $False
    }
    If ($OverLap){
        $FullOverlaps = $FullOverlaps + 1
    }
}