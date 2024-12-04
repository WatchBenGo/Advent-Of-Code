Function Test-Index {
    Param(
        [Parameter(Mandatory=$True)]
        [Int]$Row,

        [Parameter(Mandatory=$True)]
        [Int]$Column,

        [Parameter(Mandatory=$True)]
        $Puzzle
    )

    Process {
        $Count = 0

        #Back
        If ($Column -ge 3) {
            If (($Puzzle[$Row][$Column - 1] -eq 'M') -and ($Puzzle[$Row][$Column - 2] -eq 'A') -and ($Puzzle[$Row][$Column - 3] -eq 'S')) {
                $Count++
            }
        }

        #Forward
        If ($Column -le ($Puzzle[0].Length - 4)){
            If (($Puzzle[$Row][$Column + 1] -eq 'M') -and ($Puzzle[$Row][$Column + 2] -eq 'A') -and ($Puzzle[$Row][$Column + 3] -eq 'S')) {
                $Count++
            }
        }

        #Up
        If ($Row -ge 3) {
            If (($Puzzle[$Row - 1][$Column] -eq 'M') -and ($Puzzle[$Row - 2][$Column] -eq 'A') -and ($Puzzle[$Row - 3][$Column] -eq 'S')) {
                $Count++
            }
        }

        #Down
        If ($Row -le ($Puzzle.Count - 4)){
            If (($Puzzle[$Row + 1][$Column] -eq 'M') -and ($Puzzle[$Row + 2][$Column] -eq 'A') -and ($Puzzle[$Row + 3][$Column] -eq 'S')) {
                $Count++
            }
        }

        #Up Right
        If (($Row -ge 3) -and ($Column -le ($Puzzle[0].Length - 4))){
            If (($Puzzle[$Row - 1][$Column + 1] -eq 'M') -and ($Puzzle[$Row - 2][$Column + 2] -eq 'A') -and ($Puzzle[$Row - 3][$Column + 3] -eq 'S')) {
                $Count++
            }
        }

        #Up Left
        If (($Row -ge 3) -and ($Column -ge 3)){
            If (($Puzzle[$Row - 1][$Column - 1] -eq 'M') -and ($Puzzle[$Row - 2][$Column - 2] -eq 'A') -and ($Puzzle[$Row - 3][$Column - 3] -eq 'S')) {
                $Count++
            }
        }

        #Down Right
        If (($Row -le ($Puzzle.Count - 4)) -and ($Column -le ($Puzzle[0].Length - 4))){
            If (($Puzzle[$Row + 1][$Column + 1] -eq 'M') -and ($Puzzle[$Row + 2][$Column + 2] -eq 'A') -and ($Puzzle[$Row + 3][$Column + 3] -eq 'S')) {
                $Count++
            }
        }

        #Down Left
        If (($Row -le ($Puzzle.Count - 4)) -and ($Column -ge 3)){
            If (($Puzzle[$Row + 1][$Column - 1] -eq 'M') -and ($Puzzle[$Row + 2][$Column - 2] -eq 'A') -and ($Puzzle[$Row + 3][$Column - 3] -eq 'S')) {
                $Count++
            }
        }
        Return $Count
    }
}

$Data = Get-Content "C:\Users\bsiebers\OneDrive - Epic\Documents\Personal\Advent of Code\2024\12-4\Puzzle.txt"

$Count = 0

For ($I = 0; $I -lt $Data.Count; $I++) {
    For ($J = 0; $J -lt $Data[0].Length; $J++){
        If ($Data[$I][$J] -eq 'X') {
            $Count += Test-Index -Row $I -Column $J -Puzzle $Data
        } 
    }
}

$Count