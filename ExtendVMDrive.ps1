Connect-VIServer -server "vsphere host"
Import-Csv -Path 'C:\Temp\vmlist3.csv' | %{
   $vmName = $_.Name
   $vm = get-vm |?{$_.Name -eq $vmName}
   $HD = get-harddisk -VM $vm.Name -Name "Hard disk 1"
   $HD | Set-harddisk -CapacityGB ([decimal]::round($HD.CapacityGB + 10)) -Confirm:$false
} 


