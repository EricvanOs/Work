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
$Endpoint = 'https://storage2he.table.core.windows.net';

#Generated shared access signature.
$SharedAccessSignature = '?sv=2020-02-10&ss=bfqt&srt=sco&sp=rwdlacupx&se=2031-05-01T00:36:08Z&st=2021-04-30T16:36:08Z&spr=https&sig=bpjCscsses5Rejz%2BCQGMX8ZhMLyjmfNfIRaWrCxpXys%3D';

#Table name in the storage account.
$Table = 'MyTestTable';


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