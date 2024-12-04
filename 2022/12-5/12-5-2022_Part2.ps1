$Data = Get-Content .\2022\12-5\Stacks.txt
$Moves = Import-Csv .\2022\12-5\Moves.csv

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