#https://github.com/kirkhofer/adventofcode/blob/main/2022/day11/posh/day11.ps1
$Import = Get-Content .\Monkeys.txt

$Monkeys= @()

ForEach ($Line in $Import) {
    Switch -Regex ($Line) {
        "Monkey (?<Number>.*):" {
            $Monkey = [PSCustomObject] @{
                ID = $Matches.Number
                Items = @()
                Throws = @()
                Opp = ""
                Test = ""
                True = ""
                False = ""
                Inspections = 0
            }
            $Monkeys += $Monkey
        }
        "^\s\sStarting items: (?<Items> *.*)" {
            $Monkey.Items = (($Matches.Items) -replace '\s','').Split(",")
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
$Monkeys

$runs=($monkeys|%{$_.items.count}|Measure-Object -Sum).Sum
$ix=1
while( $runs -gt 0 -and $ix -le 20)
{
    foreach($monkey in $monkeys)
    {
        Write-Host "Monkey $($monkey.id)"
        $level=0
        foreach($item in $monkey.items+$monkey.throws)
        {
            $monkey.inspections++

            Write-Host "`t$item"
            $level = Invoke-Expression ($monkey.opp -f $item)
            Write-Host "`tLevel=$level"

            $level = [math]::floor($level / 3)
            Write-Host "`tLevel2=$level"

            $rs = $level % $monkey.test
            Write-Host $("`trt={0} % {1}" -f $level,$monkey.test)
            Write-Host "`trs=$rs"
            if( $rs -eq 0 )
            {
                Write-Host "`tThrow to $($monkey.True)"
                if( $monkey.id -lt $monkey.True )
                {
                    $monkeys[$monkey.True].items+=$level
                }
                else
                {
                    $monkeys[$monkey.True].throws+=$level
                }
                
            }
            else
            {
                if( $monkey.id -lt $monkey.False )
                {
                    $monkeys[$monkey.False].items+=$level
                }
                else
                {
                    $monkeys[$monkey.False].throws+=$level
                }
            }
        }
    }
    foreach($monkey in $monkeys){$monkey.items=$monkey.throws;$monkey.throws=@()}
    $runs=($monkeys|%{$_.items.count}|Measure-Object -Sum).Sum
    $ix++
}
$top2=($monkeys|select id,inspections|sort-object inspections -desc|select -first 2)
Write-Host ("Answer 1: {0}" -f $top2[0].inspections*$top2[1].inspections)