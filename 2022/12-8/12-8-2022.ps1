cls
$Trees = Get-Content .\Trees.txt
$Visible = 0

For ($I = 0; $I -lt $Trees.Length; $I++){
    For ($J = 0; $J -lt $Trees[$I].Length; $J++) {
        $UpOK = 0
        $DownOK = 0
        $LeftOK = 0
        $RightOK = 0
        $Current = $Trees[$I][$J]

        If (($I -eq 0) -or ($I -eq ($Trees.Length - 1))){
            $Visible++
            Write-Host "$Current" -NoNewline -ForegroundColor Red
        } ElseIf (($J -eq 0) -or ( $J -eq ($Trees[0].Length - 1))) {
            $Visible++
            Write-Host "$Current" -NoNewline -ForegroundColor Red
        } Else {
            For ($K = $I - 1; $K -ge 0; $K--) {
                If ($Trees[$K][$J] -ge $Trees[$I][$J]) {
                    $UpOK = 0
                    Break
                }
                $UpOK++
            }
    
            For ($K = $I + 1; $K -lt $Trees.Length; $K++) {
                If ($Trees[$K][$J] -ge $Trees[$I][$J]) {
                    $DownOK = 0
                    Break
                }
                $DownOK++
            }
    
            For ($K = $J - 1; $K -ge 0; $K--) {     
                If ($Trees[$I][$K] -ge $Trees[$I][$J]) {
                    $LeftOK = 0
                    Break
                }
                $LeftOK++
            }
    
            For ($K = $J + 1; $K -lt $Trees[$I].Length; $K++) {
                If ($Trees[$I][$K] -ge $Trees[$I][$J]) {
                    $RightOK = 0
                    Break
                }
                $RightOK++
            }
            If ($UpOK -or $DownOK -or $LeftOK -or $RightOK) {
                $Visible++
                Write-Host "$Current" -NoNewline -ForegroundColor Red
            } Else {
                Write-Host "$Current" -NoNewline -ForegroundColor Green
            }
        }
    }
    Write-Host ""
}
Write-Host "`nAnswer: $Visible"