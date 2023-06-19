
scope Team.ReadBasic.All

https://graph.microsoft.com/v1.0/me/joinedTeams


--> "b65d9086-17b9-47c8-914a-ba1c21497643"


scope Channel.ReadBasic.All


https://graph.microsoft.com/v1.0/teams/{team-id}/channels

-->   19:pdy64a4Z7EuH_S2yC660H8FjMggRFCOby3wxcN9G1OQ1@thread.tacv2


scope ChannelMessage.Send

https://graph.microsoft.com/v1.0/teams/{team-id}/channels/{channel-id}/messages

{
    "body": {
        "content": "Hello world"
    }
}





# https://www.powershellcenter.com/2022/07/15/new-mgchat/

# Graph Explorer is one of the best ways to start as it helps find information about the needed endpoint and permissions.

# The Endpoint used to create chat is https://graph.microsoft.com/v1.0/chats

Connect-MgGraph -Scopes  'Chat.ReadBasic, Chat.Read, Chat.ReadWrite'

Get-MgChat


Import-Module Microsoft.Graph.Teams

$params = @{
	ChatType = "oneOnOne"
	Members = @(
		@{
			"@odata.type" = "#microsoft.graph.aadUserConversationMember"
			Roles = @(
				"owner"
			)
			"User@odata.bind" = "https://graph.microsoft.com/v1.0/users('xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxx')"
		}
		@{
			"@odata.type" = "#microsoft.graph.aadUserConversationMember"
			Roles = @(
				"owner"
			)
			"User@odata.bind" = "https://graph.microsoft.com/v1.0/users('yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyy')"
		}
	)
}

$myChatSession = New-MgChat -BodyParameter $params





$Body = @{
    ContentType = 'html'
    Content = @'
    <img height="200" src="../hostedContents/1/$value" width="200" style="vertical-align:bottom; width:700px; height:700px">
    <Strong>I am a nice bot</Strong>
'@
}

$HostedContents = @(
    @{
        "@microsoft.graph.temporaryId" = "1"
        ContentBytes = [System.IO.File]::ReadAllBytes("C:\Users\f.malaeb\Pictures\ShellBot.png")
        ContentType = "image/png"
    }
)


New-MgChatMessage -ChatId $myChatSession.id -Body $Body -HostedContents $HostedContents









###############
Connect-MgGraph

Get-MgDevice | Where-Object{$_.DisplayName -eq 'Scylla'}

Get-MgUser | Where-Object{$_.DisplayName -eq 'Marcus Aurelius'} 

$properties = @(
	'id',
	'DisplayName',
	'userprincipalname',
	'mail',
	'jobtitle',
	'department',
	'OfficeLocation',
	'MobilePhone',
	'BusinessPhones',
	'streetAddress',
	'city',
	'postalcode',
	'state',
	'country',
	'AccountEnabled',
	'CreatedDateTime'
)

$select=$properties
$filter = "DisplayName eq 'Marcus Aurelius' "

Get-MgUser -filter $filter -Property $properties | Select-Object $select


# all properties of a user (grab all properties and select a subset)

$properties = @('*')
$select = $properties
$filter = " DisplayName eq 'Marcus Aurelius' "
Get-MgUser -filter $filter -Property $properties | Select-Object $select

# use here-strings for $filter?
# explanation of $filter : The Get-MgUser filter uses OData v3
# https://azuresearch.github.io/odata-syntax-diagram/#boolean_expression
# 

