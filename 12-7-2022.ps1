$Commands = Get-Content C:\Users\Ben\Desktop\TestFileSystem.txt

#Commands
#cd <foldername>
#cd .. (Up one level)
#cd / (top level)
#ls - List
    #123 ABC - File named ABC w/ size 123
    #dir xyz - directory named xyz

$FileSystem = [PSCustomObject]@{
    Directories = [System.Collections.ArrayList]@()
    Files = [System.Collections.ArrayList]@()
}

$CurrentDirectory = ""

ForEach ($Line in $Commands) {
    #Current Directory
    If ($Line[0] -eq "$") {
        #Command
        $Split = $Line.Split(' ')
        Switch ($Split[1]) {
            cd {
                Switch ($Split[2]) {
                    / {
                        $CurrentDirectory = $FileSystem
                    }
                    .. {
                        $CurrentDirectory = $CurrentDirectory.ParentDirectory
                    }
                    Default {
                        
                    }
                }
                
            }
            ls {
                #Do I need to do anything?
            }
        }
    } Else {
        #Data
    }
}