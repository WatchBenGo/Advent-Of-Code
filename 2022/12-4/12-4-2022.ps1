$Pairs = Import-Csv C:\Users\Ben\Desktop\CleaningPairs.csv
$FullOverlaps = 0


ForEach ($Pair in $Pairs) {
    $Elf1 = ($Pair.Elf1).Split('-')
    $Elf2 = ($Pair.Elf2).Split('-')
    $Elf1Array = $Elf1[0]..$Elf1[1]
    $Elf2Array = $Elf2[0]..$Elf2[1]

    $Elf1End = $Elf1Array.Length - 1
    $Elf2End = $Elf2Array.Length - 1


    If ($Elf1Array.Length -gt $Elf2Array.Length) {
        #See if 2 is in 1
        If (($Elf1Array[0] -le $Elf2Array[0]) -and ($Elf1Array[$Elf1End] -ge $Elf2Array[$Elf2End])) {
            #Fully Contained
            $OverLap = $True
        } Else {
            #Not Fully Contained
            $OverLap = $False
        }
    } ElseIf ($Elf2Array.Length -gt $Elf1Array.Length) {
        #See if 1 is in 2
        If (($Elf2Array[0] -le $Elf1Array[0]) -and ($Elf2Array[$Elf2End] -ge $Elf1Array[$Elf1End])) {
            #Fully Contained
            $OverLap = $True
        } Else {
            #Not Fully Contained
            $OverLap = $False
        }
    } ElseIf ($Elf1Array.Length -eq $Elf2Array.Length) {
        #If Start # is not the same not match
        If ($Elf2Array[0] -eq $Elf1Array[0]) {
            #Fully Contained
            $OverLap = $True
        } Else {
            #Not Fully Contained
            $OverLap = $False
        }
    } Else {
        #Should never get here
        Write-Warning "How did you get here?"
    }
    If ($OverLap){
        $FullOverlaps = $FullOverlaps + 1
    }
}