$Data = Get-Content .\Rope.txt
$CountKnots = 10
$Knots = 1..$CountKnots | ForEach { , @(0, 0) }
$History = [System.Collections.ArrayList]@()
$History.Add("$($Knots[1][0]) $($Knots[1][1])") | Out-Null

ForEach ($Command in $Data) {
    $Direction, $Steps = $Command.Split(" ")
    For ($I = 1; $I -le $Steps; $I++) {
        Switch ($Direction) {
            R { $Knots[0][0] += 1 }
            L { $Knots[0][0] -= 1 }
            U { $Knots[0][1] += 1 }
            D { $Knots[0][1] -= 1 }
        }
        For ($K = 1; $K -lt $CountKnots; $K++) {
        
            If (([Math]::Abs($Knots[$K - 1][0] - $Knots[$K][0]) -gt 1) -or ([Math]::Abs($Knots[$K - 1][1] - $Knots[$K][1]) -gt 1)) {
                Switch -Wildcard ("$($Knots[$K-1][0] -ne $Knots[$K][0]) $($Knots[$K-1][1] -ne $Knots[$K][1])") {
                    "True*" { $Knots[$K][0] = ($Knots[$K][0]..$Knots[$K - 1][0])[1] }
                    "*True" { $Knots[$K][1] = ($Knots[$K][1]..$Knots[$K - 1][1])[1] }
                }
            }
        }
        $History.Add( "$($Knots[-1][0]) $($Knots[-1][1])") | Out-Null
    }
}

($History | Select -Unique).Count