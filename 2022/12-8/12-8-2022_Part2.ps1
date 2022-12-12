$Trees = Get-Content .\Trees.txt
$Max = 0

For ($I = 0; $I -lt $Trees.Length; $I++){
    For ($J = 0; $J -lt $Trees[$I].Length; $J++) {
        $UpOK = 0
        $DownOK = 0
        $LeftOK = 0
        $RightOK = 0

        For ($K = $I - 1; $K -ge 0; $K--) {
            $UpOK++
            If ($Trees[$K][$J] -ge $Trees[$I][$J]) {
                Break
            }
        }
    
        For ($K = $I + 1; $K -lt $Trees.Length; $K++) {
            $DownOK++
            If ($Trees[$K][$J] -ge $Trees[$I][$J]) {
                Break
            }
           
        }
    
        For ($K = $J - 1; $K -ge 0; $K--) {     
            $LeftOK++
            If ($Trees[$I][$K] -ge $Trees[$I][$J]) {
                Break
            }
           
        }
    
        For ($K = $J + 1; $K -lt $Trees[$I].Length; $K++) {
            $RightOK++
            If ($Trees[$I][$K] -ge $Trees[$I][$J]) {
                Break
            }
        }
        
        $Multiply = $UpOK * $DownOK * $LeftOK * $RightOK
        If ($Multiply -gt $Max) {
            $Max = $Multiply
        }      
    }
}

Write-Host "Answer: $Max"