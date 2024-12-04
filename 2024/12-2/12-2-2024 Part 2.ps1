$Data = Get-Content "C:\Users\bsiebers\OneDrive - Epic\Documents\Personal\Advent of Code\2024\12-2\Reports.txt"

$Safe = $True
$NumSafe = 0

Function Test-IsSafe {
    Param(
        [Parameter( Mandatory=$true)]
        [array]$Numbers
    )
    
    Process {
        $Increasing = $True
        $Decreasing = $True
    
        For($I = 0; $I -lt $Numbers.Count-1; $I++){
            If([int]$Numbers[$I] -le [int]$Numbers[$I+1]) {
                $Decreasing = $False
            }
            If([int]$Numbers[$I] -ge [int]$Numbers[$I+1]) {
                $Increasing = $False
            }
        }
 
        If($Increasing -or $Decreasing){
            $Numbers = $Numbers | Sort -Property {[int]$_}
            For($I = 0; $I -lt $Numbers.Count-1; $I++){
                [int]$Diff = [int]$Numbers[$I+1]-[int]$Numbers[$I]
                If([int]$Diff -gt 3 -or [int]$Diff -le 0){
                    Return $False
                }
            }
            Return $True
        }
        Return $False
    }
}

ForEach($Report in $Data){
    $Numbers = $Report.Split(' ')
    If(Test-IsSafe -Numbers $Numbers){
        $NumSafe++
    }Else{
        $RemoveIsSafe = $False
        For($I = 0; $I -lt $Numbers.Count; $I++){
            [System.Collections.ArrayList]$CopyArray = $Numbers.Clone()
            [System.Collections.ArrayList]$CopyArray.RemoveAt($I)
            If(Test-IsSafe -Numbers $CopyArray){
                $RemoveIsSafe = $True
            }
        }
        If($RemoveIsSafe){
            $NumSafe++
        }
    }
}

$NumSafe