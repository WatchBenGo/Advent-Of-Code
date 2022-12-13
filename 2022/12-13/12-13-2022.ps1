$Pairs = (Get-Content C:\Users\bsiebers\Desktop\Input.txt -Raw).Trim() -split "`r`n`r`n"

$Indicies = @()
ForEach ( $Index in (1..$Pairs.Count)) {
    $Left,$Right = $Pairs[0] -split "`r`n"
}
