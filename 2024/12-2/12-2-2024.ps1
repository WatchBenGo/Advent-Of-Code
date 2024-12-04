$Data = Get-Content "C:\Users\bsiebers\OneDrive - Epic\Documents\Personal\Advent of Code\2024\12-2\Reports.txt"

$Safe = $True
$NumSafe = 0

ForEach ($Report in $Data) {
    #Write-Host "$Report"
    $Numbers = $Report.Split(' ')
    $Direction = $Null
    For ($I = 0; $I -le ($Numbers.Length - 2); $I++) {
        If ([Math]::Abs([Int]$Numbers[$I] - [Int]$Numbers[$I+1]) -gt 3){
            #Write-Warning "Unsafe - Too Much Change"
            $Safe = $False
            Break
        }
        If ([Math]::Abs([Int]$Numbers[$I] - [Int]$Numbers[$I+1]) -lt 1){
            #Write-Warning "Unsafe - No Change"
            $Safe = $False
            Break
        }
        
        If ($I -eq 0){
            If ([Int]$Numbers[$I] -gt [Int]$Numbers[$I+1]) {
                $Direction = "DOWN"
            } ElseIf ([Int]$Numbers[$I] -lt [Int]$Numbers[$I+1]) {
                $Direction = "UP"
            } Else {
                #$Safe = $True
            }
        } Else {
            If (([Int]$Numbers[$I] -gt [Int]$Numbers[$I+1]) -and ($Direction -eq "UP")) {
                #Write-Warning "Unsafe - Direction Change"
                $Safe = $False
                Break
            } ElseIf (([Int]$Numbers[$I] -lt [Int]$Numbers[$I+1]) -and ($Direction -eq "DOWN")) {
                #Write-Warning "Unsafe - Direction Change"
                $Safe = $False
                Break
            } Else {
                $Safe = $True
            }
        }
    }
    If ($Safe) {
        #Write-Host "Safe Report" -ForegroundColor Cyan
        $NumSafe++
    }
}

Write-Host "`n`nSafe Reports - $NumSafe" -ForegroundColor Cyan