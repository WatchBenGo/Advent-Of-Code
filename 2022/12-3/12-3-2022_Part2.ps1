$Data = Import-Csv C:\Users\Ben\Desktop\Data.csv

$Total = 0

ForEach ($Group in $Data) {
    $Elf1 = ($Group.Elf1).ToCharArray()
    $Elf2 = ($Group.Elf2).ToCharArray()
    $Elf3 = ($Group.Elf3).ToCharArray()

    $Matches = @()
    ForEach ($Char in $Elf1) {
        If (($Elf2 -ccontains $Char) -and ($Elf3 -ccontains $Char)) {
            $Matches += $Char
        }
    }

    $Unique = $Matches | Select -Unique

    Switch ($Unique) {
        a {If ($Unique -cmatch "a"){$Priority = 1} Else {$Priority = 27}}
        b {If ($Unique -cmatch "b"){$Priority = 2} Else {$Priority = 28}}
        c {If ($Unique -cmatch "c"){$Priority = 3} Else {$Priority = 29}}
        d {If ($Unique -cmatch "d"){$Priority = 4} Else {$Priority = 30}}
        e {If ($Unique -cmatch "e"){$Priority = 5} Else {$Priority = 31}}
        f {If ($Unique -cmatch "f"){$Priority = 6} Else {$Priority = 32}}
        g {If ($Unique -cmatch "g"){$Priority = 7} Else {$Priority = 33}}
        h {If ($Unique -cmatch "h"){$Priority = 8} Else {$Priority = 34}}
        i {If ($Unique -cmatch "i"){$Priority = 9} Else {$Priority = 35}}
        j {If ($Unique -cmatch "j"){$Priority = 10} Else {$Priority = 36}}
        k {If ($Unique -cmatch "k"){$Priority = 11} Else {$Priority = 37}}
        l {If ($Unique -cmatch "l"){$Priority = 12} Else {$Priority = 38}}
        m {If ($Unique -cmatch "m"){$Priority = 13} Else {$Priority = 39}}
        n {If ($Unique -cmatch "n"){$Priority = 14} Else {$Priority = 40}}
        o {If ($Unique -cmatch "o"){$Priority = 15} Else {$Priority = 41}}
        p {If ($Unique -cmatch "p"){$Priority = 16} Else {$Priority = 42}}
        q {If ($Unique -cmatch "q"){$Priority = 17} Else {$Priority = 43}}
        r {If ($Unique -cmatch "r"){$Priority = 18} Else {$Priority = 44}}
        s {If ($Unique -cmatch "s"){$Priority = 19} Else {$Priority = 45}}
        t {If ($Unique -cmatch "t"){$Priority = 20} Else {$Priority = 46}}
        u {If ($Unique -cmatch "u"){$Priority = 21} Else {$Priority = 47}}
        v {If ($Unique -cmatch "v"){$Priority = 22} Else {$Priority = 48}}
        w {If ($Unique -cmatch "w"){$Priority = 23} Else {$Priority = 49}}
        x {If ($Unique -cmatch "x"){$Priority = 24} Else {$Priority = 50}}
        y {If ($Unique -cmatch "y"){$Priority = 25} Else {$Priority = 51}}
        z {If ($Unique -cmatch "z"){$Priority = 26} Else {$Priority = 52}}
    }
    $Total = $Total + $Priority

}

$Total
