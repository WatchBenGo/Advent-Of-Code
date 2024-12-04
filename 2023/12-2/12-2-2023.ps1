$Data = Get-Content .\2023\12-2\Data.txt

$MaxRed = "12"
$MaxGreen = "13"
$MaxBlue = "14"

$Sum = 0

ForEach ($Line in $Data)
    {
    $Good = $True
    $GameNumber = $Line.split(":")[0] -replace'\D+'
    
    ForEach ($Draw in $Line.split(":")[1].split(";")) {

        ForEach($Cubes in $Draw.split(",")) {

            $Color = $Cubes.split(" ")[-1]
            [Int]$Number = $Cubes -replace '\D+'
            If (($Color -eq "red") -and ($Number -gt $MaxRed)) {
                $Good = $False
            } ElseIf (($Color -eq "green") -and ($Number -gt $MaxGreen)){
                $Good = $False
            } ElseIf (($Color -eq "blue") -and ($Number -gt $MaxBlue)) {
                $Good = $False
            } Else {
                #Write-Warning "How did you get here?"
            }
        }
    }
    If ($Good) {
        $Sum += $GameNumber
    }
}
$Sum


#Part 2
$Sum=0

ForEach ($Line in $Data) {

    $Colors=@(0,0,0)

    ForEach ($Cube in $Line.split(":")[1].split(";").split(",")) {
        
        If ($Colors[$Cube.split(" ")[-1].length-3] -lt ($Cube -replace '\D+')) {
            
            [int]$Colors[$Cube.split(" ")[-1].length-3] = ($Cube -replace '\D+')
        }
    }
    $Sum+=$Colors[0]*$Colors[1]*$Colors[2]
}
$Sum