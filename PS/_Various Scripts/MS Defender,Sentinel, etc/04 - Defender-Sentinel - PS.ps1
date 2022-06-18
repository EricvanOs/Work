# Use az.security module for Microsoft Defender for Cloud

Set-AzContext -SubscriptionId (Get-AzSubscription -TenantId ((Connect-AzAccount).Context.Tenant)).Id


Get-AzSecurityAlert | Select-Object -First 1



# use Az.SecurityInsights module for Microsoft Sentinel

Get-Command -Module Az.SecurityInsights

Get-AzSentinelIncident -ResourceGroupName loganalytics -WorkspaceName loganalytics2li |
 Select-Object -First 1

