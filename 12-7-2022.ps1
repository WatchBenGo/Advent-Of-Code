$Commands = Get-Content "C:\Users\bsiebers\Documents\Personal\Advent of Code\FileSystem.txt"
$FileSizes = @()

$CurrentPath = ""
$Directories = @{}

ForEach($Line in $Commands) {
    If($Line -match "^\$\s") {
        #Commands
        Switch -Regex ($Line) {
            '^\$\sls' {
                #No need to do anything
                Continue
            }
            '^\$\scd\s(?<Dir>\w+)' {
                $CurrentPath += "/$($Matches.Dir)"
                $Directories.Add($CurrentPath,0)
            }
            '^\$\scd\s\.\.' {
                $CurrentPath = $CurrentPath.Substring(0,$CurrentPath.LastIndexOf('/'))
            }
        }
    }
    Else { 
        #Data
        If($Line -match "^dir"){
            #No need to do anything
            Continue
        }
        Else {
            $Line -match "^(?<Size>\d+)\s(?<Filename>.*)$" | Out-Null
            $FileSizes += $Matches.Size

            $TempPath = $CurrentPath + "/"
            $ParentDirs = @()
            while($TempPath.Length -gt 1){
                $TempPath = $TempPath.Substring(0,$TempPath.LastIndexOf('/'))
                $ParentDirs += $TempPath
            }
            ForEach($Dir in $ParentDirs){
                If($Dir.Length -gt 0) {
                    $Directories.$Dir += $Matches.Size
                }
            }
        }
    }
}

#Part 1
$Sum = 0
$Directories.GetEnumerator() | where {$_.Value -le 100000} | % {$Sum += $_.Value}  
Write-Host $Sum

#Part 2
$RootSum = 0
ForEach($Row in $FileSizes) {
    $RootSum += [int]$Row
}

$Free = 70000000 - $RootSum
$Needed = 30000000 - $Free
$Remove = $Directories.GetEnumerator() | where {$_.Value -ge $Needed} | Sort-Object -Property Value | Select-Object -First 1

Write-Host $Remove.Value