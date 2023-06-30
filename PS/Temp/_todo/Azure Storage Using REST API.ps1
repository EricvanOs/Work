Function Insert-AzureTableData
{
    [CmdletBinding()]
    
    Param
    (
        [parameter(Mandatory=$true)][string]$Endpoint,
        [parameter(Mandatory=$true)][string]$SharedAccessSignature,
        [parameter(Mandatory=$true)][string]$Table,
        [parameter(Mandatory=$true)][hashtable]$TableData
    )
 
    #Create request header.
    $Headers = @{
        "x-ms-date"=(Get-Date -Format r);
        "x-ms-version"="2016-05-31";
        "Accept-Charset"="UTF-8";
        "DataServiceVersion"="3.0;NetFx";
        "MaxDataServiceVersion"="3.0;NetFx";
        "Accept"="application/json;odata=nometadata"
    };
 
    #Construct URI.
    $URI = ($Endpoint + "/" + $Table + "/" + $SharedAccessSignature);
 
    #Convert table data to JSON and encode to UTF8.
    $Body = [System.Text.Encoding]::UTF8.GetBytes((ConvertTo-Json -InputObject $TableData));
 
    #Insert data to Azure storage table.
    Invoke-WebRequest -Method Post -Uri $URI -Headers $Headers -Body $Body -ContentType "application/json";
}
 
Function Get-AzureTableData
{
    [CmdletBinding()]
    
    Param
    (
        [parameter(Mandatory=$true)][string]$Endpoint,
        [parameter(Mandatory=$true)][string]$SharedAccessSignature,
        [parameter(Mandatory=$true)][string]$Table
    )
 
    #Create request header.
    $Headers = @{
        "x-ms-date"=(Get-Date -Format r);
        "x-ms-version"="2016-05-31";
        "Accept-Charset"="UTF-8";
        "DataServiceVersion"="3.0;NetFx";
        "MaxDataServiceVersion"="3.0;NetFx";
        "Accept"="application/json;odata=nometadata"
    };
 
    #Construct URI.
    $URI = ($Endpoint + "/" + $Table + "/" + $SharedAccessSignature);
 
    #Insert data to Azure storage table.
    $Response = Invoke-WebRequest -Method Get -Uri $URI -Headers $Headers;
 
    #Return table data.
    Return ,($Response.Content | ConvertFrom-Json).Value;
}
 
#Storage account URL.
$Endpoint = 'https://<storage account>.table.core.windows.net';
 
#Generated shared access signature.
$SharedAccessSignature = '<insert shared access signature here>';
 
#Table name in the storage account.
$Table = '<Table name>';
 
 
##############################
#Query all rows from a table.
Get-AzureTableData -Endpoint $Endpoint -SharedAccessSignature $SharedAccessSignature -Table $Table;
##############################
 
##############################
#Data you want to add to the table.
$TableData = @{
    "PartitionKey" = "PartitionKeyData1";
    "RowKey" = "RowKeyTestData1";
    "<Column Name>" = "<Column Data>";
};
 
 
#Insert data.
Insert-AzureTableData -Endpoint $Endpoint -SharedAccessSignature $SharedAccessSignature -Table $Table -TableData $TableData;
##############################