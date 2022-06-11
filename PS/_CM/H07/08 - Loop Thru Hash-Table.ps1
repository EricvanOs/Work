# input hashtable
$subscriptionId = '111-22-333'

$hash = @{
    subscriptionId = $subscriptionId
    resourceGroupName = 'loganalytics'
    workspaceName = 'loganalytics2li'
}

# loop thru hash-table
foreach($h in $hash.GetEnumerator()){
    write-host $h.name  ,  $h.value  
}

