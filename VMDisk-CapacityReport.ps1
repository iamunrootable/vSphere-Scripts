﻿Connect-VIServer -server "vSphere"
$report = @()  
foreach($vm in Get-VM){  
    Get-HardDisk -VM $vm | ForEach-Object {  
        $HardDisk = $_  
        $row = "" | Select Hostname, VM, GuestName, Datastore, VMXpath, HardDisk, DiskType, CapacityGB, DiskFreespace, TotalVMFSConsumed, ProvisionType  
                    $row.Hostname = $vm.VMHost.Name  
                    $row.VM = $VM.Name  
                    $row.GuestName = $vm.Guest.HostName  
                    $row.Datastore = $HardDisk.Filename.Split("]")[0].TrimStart("[")  
                    $row.VMXpath = $HardDisk.FileName  
                    $row.HardDisk = $HardDisk.Name  
                    $row.CapacityGB = ("{0:f1}" -f ($HardDisk.CapacityKB/1MB))  
$row.DiskFreespace = $vm.Guest.Disks | Measure-Object FreeSpaceGB -Sum | Select -ExpandProperty Sum
$row.DiskType = $HardDisk.get_DiskType()  
$row.TotalVMFSConsumed = $vm.get_UsedSpaceGB()  
$row.ProvisionType = $HardDisk.StorageFormat  
                    $report += $row  
  }  
}  
$report | Export-Csv -Path C:\Temp\VMDisk-CapacityReport.csv -NoTypeInformation -UseCulture  
 