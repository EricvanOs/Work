function Test-AIREMD {
	<#
	.SYNOPSIS
	
	.DESCRIPTION
	
	.PARAMETERS
	
	.EXAMPLE
	
	#>
	[CmdletBinding()]
	Param(
	[System.IO.FileInfo] $file
	)

	if ((($objfile | get-content) -match '^EMD').count -eq 0){$false} else {$true}


}


