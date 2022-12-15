#Cleaned up from - https://www.reddit.com/r/PowerShell/comments/zkxotc/advent_of_code_2022_day_13_distress_signal/j079wte/

$Queue = [System.Collections.Queue]
Function ConvertFrom-Text {
    param (
        [System.Object]
        $Argument
    )
    Process {
        [System.Collections.Stack]$Stack = @()
        Switch($Argument -split ',|(?=[]])|(?<=[[])') {
            [ {
                $Stack.Push($Queue::new())
            }
            ] {
                $Store = $Stack.Pop()
                If($Stack.Count -eq 0){
                    Write-Output -NoEnumerate $Store
                } Else {
                    $Stack.Peek().Enqueue($Store)
                }
            }
            Default { $Stack.Peek().Enqueue([int]$_) }
          }
    }
}

Function Compare-Items {
    Param(
        [System.Object]
        $a,

        [System.Object]
        $b
    )
    Process {
        If(($a -is $Queue) -and ($b -is [int])) {
            Compare-Items $a ((Write-Output -NoEnumerate $b) -as $Queue)
        }
        ElseIf (($a -is [int]) -and ($b -is $Queue)) {
            Compare-Items ((Write-Output -NoEnumerate $a) -as $Queue) $b
        }
        ElseIf($a -is [int]) {
            $b - $a
        }
        Else {
            While ($a -or $b) {
                if($a.Count -eq 0 -or $b.Count -eq 0) {
                    return $b.Count - $a.Count
                }
                $r = Compare-Items $a.Dequeue() $b.Dequeue()
                if($r -ne 0) {
                    return $r
                }
            }
            return 0
        }
    }
  }

$Pairs = Get-Content .\2022\12-13\Input.txt

Remove-Variable -ErrorAction SilentlyContinue X,Y
$n = 0
$Catch = switch($Pairs) {
    { $_ -and -not $x} {
        $x = $_
        continue
    }
    { $x -and !$y } {
        $y = $_
        $a,$b = $x,$y | ForEach-Object {,(ConvertFrom-Text $_) }
        [pscustomobject]@{
            n = ++$n
            a = $x
            b = $y
            r = Compare-Items $a $b
        }
        Remove-Variable X,Y
    }
}


($Catch | Where-Object r -gt 0 | Measure-Object -sum n).Sum

$2 = @( $Pairs | Where-Object{$_}; ($keys='[[2]]','[[6]]'))
class ComparePacketString : System.Collections.IComparer {
    [int]Compare( $x, $y ) {
        return (Compare-Items (ConvertFrom-Text $y) (ConvertFrom-Text $x))
    }
}
[array]::Sort($2, [ComparePacketString]::new())
$n = 1
$keys | ForEach-Object { $n *= (1 + $2.IndexOf($_))}
$n