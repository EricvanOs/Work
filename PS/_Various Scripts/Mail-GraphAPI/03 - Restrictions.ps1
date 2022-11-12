<#
Configure ApplicationAccessPolicy
To configure an application access policy and limit the scope of application permissions:

Connect to Exchange Online PowerShell. For details, see Connect to Exchange Online PowerShell.

Identify the app’s client ID and a mail-enabled security group to restrict the app’s access to.

Identify the app’s application (client) ID in the Azure app registration portal.
Create a new mail-enabled security group or use an existing one and identify the email address for the group.
Create an application access policy.

Run the following command, replacing the arguments for AppId, PolicyScopeGroupId, and Description.

sh

Copy
New-ApplicationAccessPolicy -AppId e7e4dbfc-046f-4074-9b3b-2ae8f144f59b -PolicyScopeGroupId EvenUsers@contoso.com -AccessRight RestrictAccess -Description "Restrict this app to members of distribution group EvenUsers."
Test the newly created application access policy.

Run the following command, replacing the arguments for Identity and AppId.

sh

Copy
Test-ApplicationAccessPolicy -Identity user1@contoso.com -AppId e7e4dbfc-046-4074-9b3b-2ae8f144f59b 
The output of this command will indicate whether the app has access to User1’s mailbox.
#>