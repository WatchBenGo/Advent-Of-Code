$Data = Get-Content C:\Users\bsiebers\Desktop\Stacks.txt
$Moves = Import-Csv C:\Users\bsiebers\Desktop\Moves.csv

$Stacks = [System.Collections.ArrayList]@()

ForEach ($Line in $Data) {
    $Stacks.Add([System.Collections.ArrayList]$Line.ToCharArray()) | Out-Null
}

ForEach ($Move in $Moves) {

    $ToStack = $Stacks[$Move.To - 1]
    $FromStack = $Stacks[$Move.From -1]

    $Moving = $FromStack.GetRange(($FromStack.Count - $Move.Number),$Move.Number)
    $ToStack.AddRange($Moving)
    $FromStack.RemoveRange(($FromStack.Count - $Move.Number),$Move.Number)

    $Stacks[$Move.To - 1] = $ToStack
    $Stacks[$Move.From - 1] = $FromStack
}

ForEach ($Stack in $Stacks) {
    Write-Host $Stack[$Stack.Count - 1] -NoNewline
}