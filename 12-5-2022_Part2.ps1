$Data = Get-Content C:\Users\Ben\Desktop\Stacks.txt
$Moves = Import-Csv C:\Users\Ben\Desktop\Moves.csv

$Stack1 = [System.Collections.ArrayList]$Data[0].ToCharArray()
$Stack2 = [System.Collections.ArrayList]$Data[1].ToCharArray()
$Stack3 = [System.Collections.ArrayList]$Data[2].ToCharArray()
$Stack4 = [System.Collections.ArrayList]$Data[3].ToCharArray()
$Stack5 = [System.Collections.ArrayList]$Data[4].ToCharArray()
$Stack6 = [System.Collections.ArrayList]$Data[5].ToCharArray()
$Stack7 = [System.Collections.ArrayList]$Data[6].ToCharArray()
$Stack8 = [System.Collections.ArrayList]$Data[7].ToCharArray()
$Stack9 = [System.Collections.ArrayList]$Data[8].ToCharArray()

ForEach ($Move in $Moves) {

    Switch ($Move.To) {
        1 {$ToStack = $Stack1}
        2 {$ToStack = $Stack2}
        3 {$ToStack = $Stack3}
        4 {$ToStack = $Stack4}
        5 {$ToStack = $Stack5}
        6 {$ToStack = $Stack6}
        7 {$ToStack = $Stack7}
        8 {$ToStack = $Stack8}
        9 {$ToStack = $Stack9}
        Default {Throw "How are you here?"}
    }

    Switch ($Move.From) {
        1 {$FromStack = $Stack1}
        2 {$FromStack = $Stack2}
        3 {$FromStack = $Stack3}
        4 {$FromStack = $Stack4}
        5 {$FromStack = $Stack5}
        6 {$FromStack = $Stack6}
        7 {$FromStack = $Stack7}
        8 {$FromStack = $Stack8}
        9 {$FromStack = $Stack9}
        Default {Throw "How are you here?"}
    }

    #Do the Thing
    $Moving = $FromStack.GetRange(($FromStack.Count - $Move.Number),$Move.Number)
    $ToStack.AddRange($Moving)
    $FromStack.RemoveRange(($FromStack.Count - $Move.Number),$Move.Number)

    Switch ($Move.To) {
        1 {$Stack1 = $ToStack}
        2 {$Stack2 = $ToStack}
        3 {$Stack3 = $ToStack}
        4 {$Stack4 = $ToStack}
        5 {$Stack5 = $ToStack}
        6 {$Stack6 = $ToStack}
        7 {$Stack7 = $ToStack}
        8 {$Stack8 = $ToStack}
        9 {$Stack9 = $ToStack}
        Default {Throw "How are you here?"}
    }

    Switch ($Move.From) {
        1 {$Stack1 = $FromStack}
        2 {$Stack2 = $FromStack}
        3 {$Stack3 = $FromStack}
        4 {$Stack4 = $FromStack}
        5 {$Stack5 = $FromStack}
        6 {$Stack6 = $FromStack}
        7 {$Stack7 = $FromStack}
        8 {$Stack8 = $FromStack}
        9 {$Stack9 = $FromStack}
        Default {Throw "How are you here?"}
    }
}

$Stack1[$Stack1.Count - 1]
$Stack2[$Stack2.Count - 1]
$Stack3[$Stack3.Count - 1]
$Stack4[$Stack4.Count - 1]
$Stack5[$Stack5.Count - 1]
$Stack6[$Stack6.Count - 1]
$Stack7[$Stack7.Count - 1]
$Stack8[$Stack8.Count - 1]
$Stack9[$Stack9.Count - 1]