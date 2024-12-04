$Data = Get-Content .\2023\12-3\Data.txt

$CurrentNumber = ''
$Total = 0
$Symbol = $False

For($LineNumber = 0; $LineNumber -lt $Data.count; $LineNumber++) {

    For($Position = 0; $Position -lt $Data[$LineNumber].length; $Position++) {

        If($Data[$LineNumber][$Position] -match "[\d]") {

            $CurrentNumber = $CurrentNumber + $($Data[$LineNumber][$Position])

            For($y = $LineNumber -1; $y -le ($LineNumber + 1); $y++) {

                If($y -ge 0 -and $y -lt $Data.count) {

                    For($x = ($Position -1); $x -le ($Position + 1); $x++ ){

                        If($x -ge 0 -and $x -lt $data[$y].length) {

                            If($Data[$y][$x] -notmatch "[\d\.]") {

                                $Symbol = $True
                            }
                        }
                    }
                }
            }
        } Else {
            If ($Symbol) {
                $Total = $Total + [int]$CurrentNumber
                $Symbol = $False
            }
            $CurrentNumber = ''
            Continue
        }
    }
}

Write-Output $total