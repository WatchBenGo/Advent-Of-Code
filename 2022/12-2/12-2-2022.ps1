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
        X {
            $Player = "Rock"
            $Score += 1
        }
        Y {
            $Player = "Paper"
            $Score += 2
        }
        Z {
            $Player = "Scissors"
            $Score += 3
        }
        Default {Throw "Error"}
    }
    #Write-Host "$Opponent vs. $Player"

    If ($Opponent -eq "Rock" -and $Player -eq "Paper"){
        $Result = "Yes"
    } ElseIf ($Opponent -eq "Rock" -and $Player -eq "Scissors"){
        $Result = "No"
    } ElseIf ($Opponent -eq "Rock" -and $Player -eq "Rock"){
        $Result = "Tie"
    }

    If ($Opponent -eq "Paper" -and $Player -eq "Scissors"){
        $Result = "Yes"
    } ElseIf ($Opponent -eq "Paper" -and $Player -eq "Rock"){
        $Result = "No"
    } ElseIf ($Opponent -eq "Paper" -and $Player -eq "Paper"){
        $Result = "Tie"
    }

    If ($Opponent -eq "Scissors" -and $Player -eq "Rock"){
        $Result = "Yes"
    } ElseIf ($Opponent -eq "Scissors" -and $Player -eq "Paper"){
        $Result = "No"
    } ElseIf ($Opponent -eq "Scissors" -and $Player -eq "Scissors"){
        $Result = "Tie"
    }
    
    Switch ($Result) {
        Yes {$Score += 6}
        No {}
        Tie {$Score += 3}
        Default { Throw "Result Error"}
    }
    $TotalScore += $Score
}

$TotalScore