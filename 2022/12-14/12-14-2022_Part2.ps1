$CaveScan = Get-Content .\2022\12-14\Cave.txt

$CaveMap = [System.Collections.ArrayList]@()

$XCoords = @{}
$YCoords = @{}
$I = 0

ForEach ($Object in $CaveScan) { 
    $Points = $Object.Split(" -> ")
    ForEach ($Point in $Points) { 
        [Int]$X,[Int]$Y = $Point.Split(",")
        $XCoords.Add($I,$X)
        $YCoords.Add($I,$Y)
        $I++
    }
}
$XMax = $XCoords.Values | Sort-Object | Select-Object -Last 1 
$XMin = $XCoords.Values | Sort-Object | Select-Object -First 1
$YMax = $YCoords.Values | Sort-Object | Select-Object -Last 1 

$XSize = $XMax - $XMin + 200
$YSize = $YMax + 2

1..$YSize | ForEach-Object {
    $Row = [System.Collections.ArrayList]@()
    1..$XSize | ForEach-Object {
        $Row.Add('.') | Out-Null
    }
    $CaveMap.Add($Row) | Out-Null
}

$Row = [System.Collections.ArrayList]@()
1..$XSize | ForEach-Object {
    $Row.Add('#') | Out-Null
}
$CaveMap.Add($Row) | Out-Null

$Start = "500,0"
$XOffset = $XMin - 40

$StartX,$StartY = $Start.Split(',')
$CaveMap[$StartY][$StartX - $XOffset] = '+'

#Map Cave
ForEach ($Object in $CaveScan) {
    $Points = $Object.Split(" -> ")
    $NumPoints = 1..$Points.Count

    ForEach ($Point in $NumPoints) {
         [Int]$PointX,[Int]$PointY = $Points[$Point - 1].Split(',')
        If ($Point -eq 1) {
            #Start
            $CaveMap[$PointY][$PointX - $XOffset] = '#'
        }  Else {
            #Compare with Previous (Up+Down or Left+Right)
            [Int]$PrevX,[Int]$PrevY = $Points[$Point - 2].Split(',')
            If ($PrevX -eq $PointX) {
                #Draw on Y
                If ($PointY -gt $PrevY) {
                    #Draw Up
                    While ($PointY -gt $PrevY) {
                        $CaveMap[$PointY][$PointX - $XOffset] = '#'
                        $PointY--
                    }
                } Else {
                    #Draw Down
                    While ($PointY -lt $PrevY) {
                        $CaveMap[$PointY][$PointX - $XOffset] = '#'
                        $PointY++
                    }
                }
            } ElseIF ($PrevY -eq $PointY) {
                #Draw on X
                If ($PointX -gt $PrevX) {
                    #Draw Left
                    While ($PointX -gt $PrevX) {
                        $CaveMap[$PointY][$PointX - $XOffset] = '#'
                        $PointX--
                    }
                } Else {
                    #Draw Right
                    While ($PointX -lt $PrevX) {
                        $CaveMap[$PointY][$PointX - $XOffset] = '#'
                        $PointX++
                    }
                }
            } Else {
                Throw "Bad Input"
            }
        }
    }
}

Function Display-Cave {
    param()
    Process {
        ForEach ($Line in $CaveMap) {
            ForEach ($Space in $Line) {
                Write-Host "$Space" -NoNewline
            }
            Write-Host ""
        }
    }
}

$Overflow = 100000
$Count = 0
$Done = $False

:Outer While (!$Done -Or ($Count -lt $Overflow)) {
    
    $Falling = $True
    $X = ($StartX - $XOffset)
    $Y = $StartY

    While ($Falling) {
        Try {
            If ($CaveMap[$Y][$X] -eq 'o') {
                Break Outer
            } ElseIf ($CaveMap[$Y + 1][$X] -eq '.') {
                $Y++
            } ElseIf ($CaveMap[$Y + 1][$X - 1] -eq '.') {
                $X--
                $Y++
            } ElseIf ($CaveMap[$Y + 1][$X + 1] -eq '.') {
                $X++
                $Y++
            } Else {
                $Falling = $False
                $Count++
                $CaveMap[$Y][$X] = 'o'
            }

        } Catch {
            Break Outer
        }
    }
}
$Count