$Import = Get-Content .\Monkeys.txt
$Monkeys= [System.Collections.ArrayList]@()

ForEach ($Line in $Import) {
    Switch -Regex ($Line) {
        "Monkey (?<Number>.*):" {
            $Monkey = [PSCustomObject] @{
                ID = $Matches.Number
                Items = [System.Collections.ArrayList]@()
                Opp = ""
                Test = ""
                True = ""
                False = ""
                Inspections = 0
            }
            $Monkeys.Add($Monkey) | Out-Null
        }
        "^\s\sStarting items: (?<Items> *.*)" {
            $Store = (($Matches.Items) -replace '\s','').Split(",")
            ForEach ($Entry in $Store) {
                $Monkey.Items.Add([Int]$Entry) | Out-Null
            }
        }
        "^\s\sOperation: new = (?<Opp> *.*)" {
            $Monkey.Opp = ($Matches.Opp).Replace("old","{0}")
        }
        "^\s\sTest: divisible by (?<Divide> *.*)" {
            $Monkey.Test = $Matches.Divide
        }
        "^\s\s\s\sIf true: throw to monkey (?<To> *.*)" {
            $Monkey.True = $Matches.To
        }
        "^\s\s\s\sIf false: throw to monkey (?<To> *.*)" {
            $Monkey.False = $Matches.To
        }
    }
}

For ($I = 1; $I -le 10000; $I ++) {
    ForEach ($Monkey in $Monkeys) {
        ForEach ($Item in $Monkey.Items) {
            $Monkey.Inspections++
            $Level = Invoke-Expression ($Monkey.Opp -F $Item)
            #$Level = [Math]::Floor($Level/3)

            If ($Level % $Monkey.Test) {
                $Monkeys[$Monkey.False].Items.Add($Level) | Out-Null
            } Else {
                $Monkeys[$Monkey.True].Items.Add($Level) | Out-Null
            }

        }
        $Monkey.Items.Clear()
    }
}

$Top2 = $Monkeys | Sort Inspections -Descending | Select -ExpandProperty Inspections -First 2
$Multiply = $Top2[0] * $Top2[1]
$Multiply