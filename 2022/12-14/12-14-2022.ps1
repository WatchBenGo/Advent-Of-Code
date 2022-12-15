$CaveScan = Get-Content C:\Users\bsiebers\Desktop\Cave.txt
$EmptyCave = Get-Content C:\Users\bsiebers\Desktop\TestCave.txt

$CaveMap = [System.Collections.ArrayList]@()

ForEach ($Line in $EmptyCave) {
    $CaveMap.Add([System.Collections.ArrayList]$Line.ToCharArray()) | Out-Null
}

$Start = "500,0"
$Offset = 494

$StartX,$StartY = $Start.Split(',')

$CaveMap[$StartY][$StartX - $Offset] = [Char]'+'

#Max X = 518        Min X = 368
#Max y = 165        Min Y = 13

#Draw Cave
ForEach ($Object in $CaveScan) {
    $Points = $Object.Split(" -> ")
    ForEach ($Point in $Points) {
        $PointX,$PointY = $Point.Split(',')
    }
}


#DisplayCave
ForEach ($Line in $CaveMap) {
    ForEach ($Space in $Line) {
        Write-Host "$Space" -NoNewline
    }
    Write-Host ""
}