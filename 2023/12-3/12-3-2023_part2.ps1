$Data = Get-Content "C:\Users\bsiebers\OneDrive - Epic\Documents\Personal\Advent of Code\2023\12-3\Data.txt"

$CurrentNumber = ''

$Match = $null
$Total = 0
$Gears = @()
$Result = @{}

For($LineNumber = 0; $LineNumber -lt $Data.count;$LineNumber++) {

    For($Position = 0; $Position -lt $Data[$LineNumber].length; $Position++) {

        If($Data[$LineNumber][$Position] -Match "[\d]") {

            $CurrentNumber = $CurrentNumber + $($Data[$LineNumber][$Position])

            For($y = $LineNumber -1; $y -le ($LineNumber + 1); $y++) {

                If($y -ge 0 -and $y -lt $Data.count) {

                    For($x = ($Position -1); $x -le ($Position + 1);$x++ ){

                        If($x -ge 0 -and $x -lt $Data[$y].length) {

                            If($Data[$y][$x] -Match '\*') {

                                $Match = "$y" + 'X' + "$x"

                            }
                        }
                    }
                }
            }
        } Else {
            If($Match) {

                If($Result[$Match]) {

                    $Result[$Match] = $Result[$Match] * [int]$CurrentNumber
                    $Gears += $Match

                } Else {
                    $Result += @{$Match = [int]$CurrentNumber}
                }
                $Match = $null
            }
            $CurrentNumber = ''
            Continue
        }
    }
}

Foreach($Ratio in $Gears) {
    $Total = $Total + $Result[$Ratio]
}
Write-Output $Total