#Rock defeats Scissors, Scissors defeats Paper, and Paper defeats Rock

#A for Rock, B for Paper, and C for Scissors
#X for Rock, Y for Paper, and Z for Scissors



#The score for a single round is the score for the shape you selected 
#(1 for Rock, 2 for Paper, and 3 for Scissors) 
#plus the score for the outcome of the round 
#(0 if you lost, 3 if the round was a draw, and 6 if you won)


$Data = Import-Csv .\2022\12-2\Input.csv
$TotalScore = 0

ForEach ($Round in $Data) {
    $Opponent = ""
    $Player = ""
    $Score = 0

    Switch ($Round.Opponent) {
        A {$Opponent = "Rock"}
        B {$Opponent = "Paper"}
        C {$Opponent = "Scissors"}
        Default {Throw "Error"}
    }
    Switch ($Round.Player) {
        Z {
            $Result = "Win"
            $Score += 6
        }
        X {
            $Result = "Lose"
        }
        Y {
            $Result = "Tie"
            $Score += 3
        }
        Default {Throw "Error"}
    }

    If ($Opponent -eq "Rock" -and $Result -eq "Win"){
        $Player = "Paper"
    } ElseIf ($Opponent -eq "Rock" -and $Result -eq "Lose"){
        $Player = "Scissors"
    } ElseIf ($Opponent -eq "Rock" -and $Result -eq "Tie"){
        $Player = "Rock"
    }

    If ($Opponent -eq "Paper" -and $Result -eq "Win"){
        $Player = "Scissors"
    } ElseIf ($Opponent -eq "Paper" -and $Result -eq "Lose"){
        $Player = "Rock"
    } ElseIf ($Opponent -eq "Paper" -and $Result -eq "Tie"){
        $Player = "Paper"
    }

    If ($Opponent -eq "Scissors" -and $Result -eq "Win"){
        $Player = "Rock"
    } ElseIf ($Opponent -eq "Scissors" -and $Result -eq "Lose"){
        $Player = "Paper"
    } ElseIf ($Opponent -eq "Scissors" -and $Result -eq "Tie"){
        $Player = "Scissors"
    }

    Write-Host "$Opponent vs. $Player"
    
    Switch ($Player) {
        Rock {$Score += 1}
        Paper {$Score += 2}
        Scissors {$Score += 3}
        Default { Throw "Result Error"}
    }
    $TotalScore += $Score
}

$TotalScore