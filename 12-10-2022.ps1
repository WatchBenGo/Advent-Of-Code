Function Check-Strength {
    param (
        [Parameter(Mandatory=$True)]
        [Int]
        $Cycle
    )
    Process {
        #20,60,100,140,180,220
        #Multiply the Register by Cycle and Sum
        If (($Cycle -eq 20) -or ($Cycle-eq 60) -or ($Cycle -eq 100) -or ($Cycle -eq 140) -or ($Cycle -eq 180) -or ($Cycle -eq 220)) {
            
            $Multiply = $Cycle * $Register
            $Strength = $Add + $Multiply
        
        } Else {
            $Strength = 0
        }
        Return $Strength  
    }
}

Function Draw-Sprite {
    param (
        [Parameter(Mandatory=$True)]
        [Int]
        $Cycle,

        [Parameter(Mandatory=$True)]
        [Int]
        $Register
    )
    Process {
        $Position = ($Cycle % 40) - 1
        #Figure Out if we should display sprit, or not
        If ($Position -in ($Register-1)..($Register+1)) {
            $Sprite = "#"
        } Else {
            $Sprite = "."
        }

        If (($Cycle % 40) -eq 0) {
            Return "$Sprite`n"
        } Else {
            Return "$Sprite"
        }
    }
}

$Instructions = Get-Content .\Instructions.txt

$Clock = 0
$Register = 1
$Sum = 0
$Display = ""

ForEach ($Instruction in $Instructions) {

    Switch ($Instruction.Split(" ")[0]){
        noop {
            $Process = "noop"
        }
        addx {
            $Process = "noop", "$Instruction"
        }
    }
    
    #Do The Process
    ForEach ($Item in $Process) {

        Switch ($Item.Split(" ")[0]){
            noop {
                $Clock++
                $Display = $Display + (Draw-Sprite -Cycle $Clock -Register $Register)
                $Sum = $Sum + (Check-Strength -Cycle $Clock)
            }
            addx {
                $Clock++
                $Display = $Display + (Draw-Sprite -Cycle $Clock -Register $Register)
                $Sum = $Sum + (Check-Strength -Cycle $Clock)
                $Register = $Register + [Int]$Item.Split(" ")[1]
                              
            }
        }
    }    
}

$Sum

Write-Host $Display
