$fpath = "C:\Exchange\V14\Mailbox\Folder"

$obj = Get-ChildItem -path $fpath -include '*.log' -recurse | 
Select Name,@{Name="NameLength";Expression={$_.name.length}}, @{Name="FileSize";Expression={$_.Length / 1kb}} | 
Where-Object -Property NameLength -gt 8 | 
Where-Object -Property FileSize -eq 1024 | 
Select-Object -expandproperty name

for ($i=0; $i -lt $obj.length; $i++) {
	$file = $obj[$i]
	Remove-Item -Path $fpath\$file
}
