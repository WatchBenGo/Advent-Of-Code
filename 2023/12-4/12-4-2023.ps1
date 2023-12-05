$Data = Get-Content "C:\Users\bsiebers\OneDrive - Epic\Documents\Personal\Advent of Code\2023\12-4\Data.txt"
$Total = 0

ForEach($Line in $Data) {

    $Match = 0
    $Line = $Line -replace '\s+', ' '
    $AllNumbers = $Line.split(':')[1]
    $Winners = $AllNumbers.split('|')[0].trim().split(' ')
    $CardNumbers = $AllNumbers.split('|')[1].trim().split(' ')

    ForEach($Entry in $Winners){
        If($CardNumbers -contains $Entry) {
            If ($Match) {
                $Match = $Match *2
            } Else {
                $Match = 1
            }
        }
    }
    $Total = $Total + $Match
}

$Total


## Part 2
$Cards = @(1) * ($Data.count + 1)
$Cards[0] = 0

ForEach($Line in $Data) {

    $Match = 0
    $Line = $Line -replace '\s+', ' '

    [int]$CardNumber = $Line.split(':')[0] -replace "[^0-9]"
    $AllNumbers = $Line.split(':')[1]
    $Winners = $AllNumbers.split('|')[0].trim().split(' ')
    $CardNumbers = $AllNumbers.split('|')[1].trim().split(' ')

    ForEach($Entry in $Winners){
        If($CardNumbers -contains $Entry) {
            $Match = $Match + 1
        }
    }
    For($NoCardsCheck = 0; $NoCardsCheck -lt $Cards[$CardNumber]; $NoCardsCheck++) {
        For($i = ($CardNumber + 1); $i -le ($CardNumber + $Match); $i++) {
            $Cards[$i] = $Cards[$i] + 1
        }
    }
}

$Cards | Measure-Object -Sum