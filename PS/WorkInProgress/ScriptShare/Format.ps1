notepad
$a = get-process | Where-Object{$_.name -like '*notepad*'}


$a | Format-Table | Stop-Process # lukt niet

$a | Stop-Process


$a | Format-Table -Property Name, ID, VM, @{Label        = 'VM(MB)';
                                            Expression   = {$_.VM /1MB};
                                            FormatString = 'N2';
                                            Align        = 'right'}     


# creating objects

$system = New-Object -TypeName PSObject
$system | Get-Member

$os = Get-WmiObject Win32_OperatingSystem

Add-Member -InputObject $system -MemberType NoteProperty  -Name OperatingSystem -Value $os.Caption
Add-Member -InputObject $system -MemberType NoteProperty  -Name ServicePack     -Value $os.CSDVersion

$system | Get-Member
$system.OperatingSystem

$mem = Get-WmiObject Win32_PhysicalMemory
$disk = Get-WmiObject Win32_DiskDrive

Add-Member -InputObject $system -MemberType NoteProperty -Name PhysicalMemory -Value (("{0:N2}" -f ($mem.Capacity)))
Add-Member -InputObject $system -MemberType NoteProperty -Name DiskSize       -Value (("{0:N2}" -f ($disk.Size)))
Add-Member -InputObject $system -MemberType NoteProperty -Name Owner          -Value "janetp"

$system


$info = @{
  "OperatingSystem" = $os.Caption;
  "ServicePack" = $os.CSDVersion;
  "PhysicalMemory" =  (("{0:N2}" -f ($mem.Capacity)));
  "DiskSize" = (("{0:N2}" -f ($disk.Size)));
  "Owner" = 'janetp'
}

$system = New-Object -TypeName PSObject -Property $info

$system

# creating method

$method =
{
  $a = Get-Date -Format F; "Local: " + $a;
  $b = Get-Date; "UTC: " + $b.ToUniversalTime().DateTime
}

Add-Member -InputObject $system -MemberType ScriptMethod  -Name GetUTC -Value $method

$system | Get-Member

$system.GetUTC()


# extra attributen bij een object aanmaken

$os = Get-WmiObject Win32_OperatingSystem
$bios = Get-WmiObject Win32_bios

$extra = $os | Select-Object –Property *, @{n='OSVersion';e={$_.Version}},  #merk op n = name of Label , e is Expression
@{n='OSBuild';e={$_.BuildNumber}},
@{n='BIOSSerial';e={$bios.SerialNumber}} 

$extra

# Er is een attribuut PSComputerName maar geen attribute ComputerName
# een extra atrribuut ComputerName aanmaken 

$os | get-process

$extra = $os | Select-Object –Property *,  @{n='ComputerName';e={$_.PSComputerName}} -ExcludeProperty name

$extra | Get-Process

