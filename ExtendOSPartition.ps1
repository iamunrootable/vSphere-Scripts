Import-Csv -Path 'C:\Temp\vmlist.csv' | %{
    $vmName = $_.Name
    $Dest = "\\" + $vmName + "\"+ "C$\Windows\temp"
    Copy-Item "C:\temp\diskpart.txt" -Destination $Dest -Force
    Invoke-VMScript -vm $vmName -ScriptText "C:\windows\system32\diskpart.exe /s c:\Windows\temp\diskpart.txt" -ScriptType BAT
}