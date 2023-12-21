  
  function Test-AIROfficeID {
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
  
  #read content of airfile -- only those lines starting with MUC
   $entries = ( ($file | get-content) -match '^MUC')    
   
   if ($entries.count -eq 0) {$strCheck  = $false} else {$strcheck = $true}
   $strcheck = $false
   foreach ($entry in $entries){

   $strIssueOfficeID  =  Get-AIRString -line $entry -part 9   
   
   $AllOfficeID = @(		
   "KL0201" 		,"NYCAF01PR" , 
   "AMSKL0215" 		,"PARAF01PR" , 
   "BRUAF0500"		,"AMSKL059S" , 
   "BRNKL020D" 		,"BRNKL020F" , 
   "AMSKL0290" 		,"KL0230"	 , 
   "KL0210"  		,"AMSKL02DL" , 
   "LONKL0202" 		,"BRUKL02DL" , 
   "AF052T" 		,"LUXAF0500" , 
   "AMSKL0225" 		,"BRUAF0125" , 
   "AMSAF0500" 		,"AMSKL0254" , 
   "LUXAF02PL" 	    ,"LUXKL02PL" , 
   "AMSAF02PL" 	    ,"AMSKL02PL" , 
   "BRUAF02PL" 	    ,"BRUKL02PL" , 
   "MADAF02PL" 	    ,"MADKL02PL" , 
   "DUBAF02PL" 	    ,"DUBKL02PL" , 
   "MILAF02PL" 	    ,"MILKL02PL" , 
   "LONAF02PL" 	    ,"LONKL02PL" , 
   "MILAF04PL" 		,"ROMKL02PL" , 
   "LONKL02IC" 	    ,"DUBKL02IC" , 
   "CPHKL02IC" 		,"OSLKL02IC" , 
   "BRNKL0231" 		,"HELKL02IC" , 
   "STOKL02IC" 		,"SXMKL0210" , 
   "LISKL02IC" 		,"BRUKL0210" , 
   "RIXKL02IC"		,"VNOKL02IC" , 
   "TLLKL02IC"		,"AMSKL02IC" , 
   "BRUKL02IC"		,"LUXKL02IC" , 
   "PARAF0601" 		,"DUBAF0500" , 
   "CPHAF0500" 		,"MILAF0500" , 
   "HELAF0500" 		,"LONAF0500" , 
   "MADAF0500" 		,"OSLAF0500" , 
   "STOAF0500" 		,"LONKL0202" , 
   "LISAF0500" 		,"MILAF0500" ,
   "AMSKL02PS" 		,"AMSKL0278" , 
   "CPHAF0706" 		,"DUBAF0706" , 	
   "LISAF0706" 		,"LONAF0706" , 	
   "MADAF0706" 		,"REKAF0706" , 	
   "STOAF0706" 		,"MADKL02IC" , 
   "WASKL0210"		,"NYCAF0500")

      foreach ($id in $AllOfficeID) {
       $strcheck = ($strIssueOfficeID -match  $id) -or $strcheck
   }
}
$strCheck
}


