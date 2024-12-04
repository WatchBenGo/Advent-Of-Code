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

        #Check OOB
        If (($Column -lt 1) -or ($Column -gt $Puzzle[0].Length - 2)) {
            Return $Count
        }

        <#
        M.M
        .A.
        S.S
        #>
        If (($Puzzle[$Row - 1][$Column - 1] -eq 'M') -and ($Puzzle[$Row - 1][$Column + 1] -eq 'M') -and ($Puzzle[$Row + 1][$Column - 1] -eq 'S') -and ($Puzzle[$Row + 1][$Column + 1] -eq 'S')) {
            $Count++
        }
        
        <#
        S.S
        .A.
        M.M
        #>
        If (($Puzzle[$Row - 1][$Column - 1] -eq 'S') -and ($Puzzle[$Row - 1][$Column + 1] -eq 'S') -and ($Puzzle[$Row + 1][$Column - 1] -eq 'M') -and ($Puzzle[$Row + 1][$Column + 1] -eq 'M')) {
            $Count++
        }

        <#
        M.S
        .A.
        M.S
        #>
        If (($Puzzle[$Row - 1][$Column - 1] -eq 'M') -and ($Puzzle[$Row - 1][$Column + 1] -eq 'S') -and ($Puzzle[$Row + 1][$Column - 1] -eq 'M') -and ($Puzzle[$Row + 1][$Column + 1] -eq 'S')) {
            $Count++
        }
        <#
        S.M
        .A.
        S.M
        #>
        If (($Puzzle[$Row - 1][$Column - 1] -eq 'S') -and ($Puzzle[$Row - 1][$Column + 1] -eq 'M') -and ($Puzzle[$Row + 1][$Column - 1] -eq 'S') -and ($Puzzle[$Row + 1][$Column + 1] -eq 'M')) {
            $Count++
        }

        Return $Count
    }
}

$Data = Get-Content "C:\Users\bsiebers\OneDrive - Epic\Documents\Personal\Advent of Code\2024\12-4\Puzzle.txt"

$Count = 0

For ($I = 1; $I -lt $Data.Count - 1; $I++) {
    For ($J = 0; $J -lt $Data[0].Length; $J++){
        If ($Data[$I][$J] -eq 'A') {
            $Count += Test-Index -Row $I -Column $J -Puzzle $Data
        } 
    }
}

$Count