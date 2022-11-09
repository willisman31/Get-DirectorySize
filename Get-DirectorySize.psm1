<#
    .Synopsis
    Displays the size of a directory and all of its contents in bytes by default.

    .Description
    Displays the size of a folder or directory and all of its contents recursively with 
    the output delivered by default in bytes.

    .Parameter Path
    Path to directory being measured

    .Parameter K
    Display contents in kilobytes

    .Parameter M
    Display contents in megabytes

    .Parameter G
    Display contents in gigabytes
#>
function Get-DirectorySize {
    param(
        [Parameter(Mandatory=$false)]
        [Alias('Path')]
        [String[]]
        $BasePath = '.\',
        [Parameter(Mandatory=$false)]
        [Alias('K')]
        $kb,
        [Parameter(Mandatory=$false)]
        [Alias('M')]
        $mb,
        [Paramter(Mandatory=$false)]
        [Alias('G')]
        $gb
    )
    $sum=0
    ForEach($item in $contents) {
        if ($item -is [System.IO.DirectoryInfo]) {
            $sum += $item.Length
        } else {
            Get-DirectorySize -Path $item
        }
    }
    if ($kb) {
        Write-Output $sum/1Kb + " Kb"
    } elseif ($mb) {
        Write-Output $sum/1Mb + " Mb"
    } elseif ($gb) {
        Write-Output $sum/1Gb + " Gb"
    } else {
        Write-Output $sum
    }
}
Export-ModuleMember -Function Get-DirectorySize
