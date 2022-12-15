$CaveScan = Get-Content .\2022\12-14\Cave.txt

$CaveMap = [System.Collections.ArrayList]@()

#Max X = 518        Min X = 368
#Max y = 165        Min Y = 13

1..170 | ForEach-Object {
    $Row = [System.Collections.ArrayList]@()
    1..520 | ForEach-Object {
        $Row.Add('.') | Out-Null
    }
    $CaveMap.Add($Row) | Out-Null
}

$Start = "500,0"
#$Offset = 494

$StartX,$StartY = $Start.Split(',')

$CaveMap[$StartY][$StartX] = '+'

#Draw Cave
ForEach ($Object in $CaveScan) {
    $Points = $Object.Split(" -> ")
    $NumPoints = 1..$Points.Count

    ForEach ($Point in $NumPoints) {
         [Int]$PointX,[Int]$PointY = $Points[$Point - 1].Split(',')
        If ($Point -eq 1) {
            #Start
            $CaveMap[$PointY][$PointX] = '#'
        }  Else {
            #Compare with Previous (Up+Down or Left+Right)
            [Int]$PrevX,[Int]$PrevY = $Points[$Point - 2].Split(',')
            If ($PrevX -eq $PointX) {
                #Draw on Y
                If ($PointY -gt $PrevY) {
                    #Draw Up
                    While ($PointY -gt $PrevY) {
                        $CaveMap[$PointY][$PointX] = '#'
                        $PointY--
                    }
                } Else {
                    #Draw Down
                    While ($PointY -lt $PrevY) {
                        $CaveMap[$PointY][$PointX] = '#'
                        $PointY++
                    }
                }
            } ElseIF ($PrevY -eq $PointY) {
                #Draw on X
                If ($PointX -gt $PrevX) {
                    #Draw Left
                    While ($PointX -gt $PrevX) {
                        $CaveMap[$PointY][$PointX] = '#'
                        $PointX--
                    }
                } Else {
                    #Draw Right
                    While ($PointX -lt $PrevX) {
                        $CaveMap[$PointY][$PointX] = '#'
                        $PointX++
                    }
                }
            } Else {
                Throw "Bad Input"
            }
        }
    }
}

#DisplayCave
#$Display = @()

ForEach ($Line in $CaveMap) {
    ForEach ($Space in $Line) {
        Write-Host "$Space" -NoNewline
        #$Display += $Space
    }
    Write-Host ""
    #$Display += "`r`n"
}

Function Drop-Sand {
    param ()
    Process {
        Return $True
    }
}

$Overflow = $False
$Count = 0

While (!$Overflow) {
    $Overflow = Drop-Sand
    $Count++
}