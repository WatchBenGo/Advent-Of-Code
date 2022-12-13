$Lines = Get-Content .\2022\12-12\Map.txt
$MaxX = $lines[0].Length - 1
$MaxY = $lines.Count - 1

$NeighborsPatterns = '[[-1,0],[0,-1],[0,1],[1,0]]' | ConvertFrom-Json

$Map = [Collections.Generic.Dictionary[String,hashtable]]::New()
$Map.EnsureCapacity(($MaxX + 1)*($MaxY + 1))

For ($Y = 0; $Y -lt $Lines.Count; $Y++) {
    For ($X = 0; $X -lt $Lines[0].Length; $X++) {
        $Key = "$X,$Y"
        $Height = $Lines[$Y][$X]
        If ($Height -ceq 'E') {
            $Height = [Char]'a'
            $StartKey = $Key
        } ElseIf ($Height -ceq 'S') {
            $Height = [Char]'z'
            $EndKey = $Key
        }

        $Neighbors = ForEach ($ID in $NeighborsPatterns) {
            $NX = $X + $ID[0]
            $NY = $Y + $ID[1]

            If (($NX -lt 0) -or ($MaxX -lt $NX) -or ($NY -lt 0) -or ($MaxY -lt $NY)) {
                Continue
            }

            $NH = $Lines[$NY][$NX]

            If ($NH -ceq 'S') {
                $NH = [Char]'a'
            } ElseIf ($NH -ceq 'E') {
                $NH = [Char]'z'
            }
            
            $Diff = $Height - $NH

            If ($Diff -le 1) {
                "$NX,$NY"
            }
        }

        $Map[$Key] = @{
            Key = $Key
            Height = $Height
            Neighbors = $Neighbors
            Distance = [Int]::MaxValue
        }
    }
}

$Queue = [Collections.Generic.PriorityQueue[PSObject,Int]]::New()
$Start = $Map[$StartKey]
$Start.Distance = 0
$Queue.Enqueue($Start, $Start.Distance)

$Seen = @{}

While ($Queue.Count -gt 0) {
    $U = $Queue.Dequeue()

    If ($U.Key -eq $EndKey) {
        $U.Distance
        Break
    }

    If ($Seen.ContainsKey($U.Key)) {
        Continue
    }
    $Seen[$U.Key] = 1

    ForEach ($vKey in $U.Neighbors) {
        $V = $Map[$vKey]
        $NewDistance = $U.Distance + 1
        If ($NewDistance -lt $V.Distance) {
            $V.Distance = $NewDistance
            $Queue.Enqueue($V, $V.Distance)
        }
    }
}